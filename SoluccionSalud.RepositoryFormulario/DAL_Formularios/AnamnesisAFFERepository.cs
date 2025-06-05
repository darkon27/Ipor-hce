using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using SoluccionSalud.ModelERP_FORM;
using SoluccionSalud.Model;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository;
using System.Data.Entity;
using System.Xml;
using System.Xml.Serialization;
using SoluccionSalud.Repository.Repository;
using Newtonsoft.Json;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class AnamnesisAFFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public List<SS_HC_Anamnesis_AFAM_CAB_FE> listarEntidad(SS_HC_Anamnesis_AFAM_CAB_FE objSC)
        {

            List<SS_HC_Anamnesis_AFAM_CAB_FE> objLista = new List<SS_HC_Anamnesis_AFAM_CAB_FE>();
            using (var context = new ModelFormularios())
            {

                List<SS_HC_Anamnesis_AFAM_CAB_FE> objConsultas = (from t in context.SS_HC_Anamnesis_AFAM_CAB_FE
                                                                  where
                                                                  t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                  && t.IdPaciente == objSC.IdPaciente
                                                                  && t.EpisodioClinico == objSC.EpisodioClinico
                                                                  && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                  orderby t.IdEpisodioAtencion descending
                                                                  select t).ToList();

                if (objConsultas != null)
                {
                    objLista.AddRange(objConsultas);
                }
            }
            return objLista;
        }
        public List<SS_HC_Anamnesis_AFAM_FE> AnamnesisAFListar(SS_HC_Anamnesis_AFAM_FE objSC)
        {
            try
            {
                dynamic DataKey = null;
                //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                List<SS_HC_Anamnesis_AFAM_FE> objLista = new List<SS_HC_Anamnesis_AFAM_FE>();
                //using (var context = new WEB_ERPSALUDEntities())
                using (var context = new ModelFormularios())
                {
                    List<SS_HC_Anamnesis_AFAM_FE> objConsultas = (from  t in context.SS_HC_Anamnesis_AFAM_FE
                                                                  where
                                                                  t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                  && t.IdPaciente == objSC.IdPaciente
                                                                  && t.EpisodioClinico == objSC.EpisodioClinico
                                                                  && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                  orderby t.IdEpisodioAtencion descending
                                                                  select  t).ToList();



                    if (objConsultas != null)
                    {
                        objLista.AddRange(objConsultas);
                    }

                    //Agregado auditoria --> N° 2
                    using (var contextEnty = new WEB_ERPSALUDEntities())
                    {
                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                        //     dynamic DataKey;
                        DataKey = new
                        {
                            UnidadReplicacion = objSC.UnidadReplicacion,
                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                            EpisodioClinico = objSC.EpisodioClinico,
                            IdPaciente = objSC.IdPaciente,
                            SecuenciaFamilia = objSC.SecuenciaFamilia
                        };

                        if (objLista.Count > 1)
                        {
                            objAudit.Type = "L";
                        }
                        else
                        {
                            objAudit.Type = "V";
                        }

                        string tempType = objAudit.Type;
                        objAudit = Control.AddAudita(new SS_HC_Anamnesis_AFAM_FE(), new SS_HC_Anamnesis_AFAM_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_Anamnesis_AFAM_FE");
                        objAudit.TableName = "SS_HC_Anamnesis_AFAM_FE";
                        objAudit.Type = tempType;
                        objAudit.VistaData = xlmIn;
                        objAudit.Accion = objSC.Accion;
                        contextEnty.Entry(objAudit).State = EntityState.Added;
                        contextEnty.SaveChanges();
                    }
                    //--

                    /*
                    DataKey = new
                    {
                        UnidadReplicacion = objSC.UnidadReplicacion,
                        IdPaciente = objSC.IdPaciente,
                        EpisodioClinico = objSC.EpisodioClinico,
                        IdEpisodioAtencion = objSC.IdEpisodioAtencion
                    };

                    String accionTemp = "V";
                    if (objLista.Count > 1) accionTemp = "L";

                    //String xlmIn = XMLString(objLista, new List<SS_HC_EvolucionObjetiva>(), "SS_HC_EvolucionObjetiva");//CAMBAIR DE CLASE
                    String xlmIn = "";
                    setAuditoriaListado(new SS_HC_Anamnesis_AFAM(), new SS_HC_Anamnesis_AFAM(), accionTemp,
                        "SS_HC_Anamnesis_AFAM", objAudit, DataKey, xlmIn);
                     */
                }
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public long setMantAnamnesisAF(SS_HC_Anamnesis_AFAM_CAB_FE objSCabecera, SS_HC_Anamnesis_AFAM_FE ObjTraces, List<SS_HC_Anamnesis_AFAM_FE> DetalleUno, List<SS_HC_Anamnesis_AFAM_Enfermedad_FE> DetalleEnf)
        {

            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            long valorRetorno = -1;

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuenciaFam = new Dictionary<String, int>();
                        // CABECERA MAIN ( FAMILIARES)
                        if (objSCabecera != null)
                        {
                            //List<SS_HC_Anamnesis_AFAM_CAB_FE> objAnteriorCab = new List<SS_HC_Anamnesis_AFAM_CAB_FE>();

                            int objCount = 0;
                            if (objSCabecera.Accion == null) objSCabecera.Accion = "X";
                            if ((objSCabecera.Accion.Substring(0, 1) != "I") && (objSCabecera.Accion.Substring(0, 1) != "N"))
                            {
                                objCount = context.SS_HC_Anamnesis_AFAM_CAB_FE
                                                  .Where(t =>
                                                  t.UnidadReplicacion == objSCabecera.UnidadReplicacion
                                                  && t.IdPaciente == objSCabecera.IdPaciente
                                                  && t.EpisodioClinico == objSCabecera.EpisodioClinico
                                                  && t.IdEpisodioAtencion == objSCabecera.IdEpisodioAtencion
                                                  ).DefaultIfEmpty()
                                                   .Count();


                            }
                            /**TRANSACCIÓN*/
                            if (objCount > 0)
                            {
                                if (objSCabecera.Accion == "UPDATE")
                                {
                                    objSCabecera.Version = "CCEPF014";
                                    context.Entry(objSCabecera).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSCabecera.Accion == "NUEVO")
                                {
                                    objSCabecera.Version = "CCEPF014";
                                    context.Entry(objSCabecera).State = EntityState.Added;
                                }
                            }
                        }

                        // DETALLES
                        if (objSCabecera.AntecedenteFami_flag == "S")
                        {
                            int contadorCab = 0;
                            /**obtener la última secuencia*/
                            var secuenciaFamMax = context.SS_HC_Anamnesis_AFAM_FE
                                    .Where(t =>
                                            t.IdPaciente == ObjTraces.IdPaciente
                                            && t.UnidadReplicacion == ObjTraces.UnidadReplicacion
                                            && t.EpisodioClinico == ObjTraces.EpisodioClinico
                                            && t.IdEpisodioAtencion == ObjTraces.IdEpisodioAtencion
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.SecuenciaFamilia);
                            // DETALLE MAIN (FAMILIARES)
                            if (DetalleUno.Count > 0 | DetalleUno.Count != null)
                            {
                                foreach (SS_HC_Anamnesis_AFAM_FE objSC in DetalleUno)
                                {
                                    if (objSC != null)
                                    {
                                        objSC.Version = "CCEPF014";
                                        int secuenciaFamAux = objSC.SecuenciaFamilia;
                                        //SS_HC_Anamnesis_AFAM_FE objAnterior = null;
                                        int objCount = 0;
                                        if (objSC.Accion == null) objSC.Accion = "X";
                                        if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                                        {
                                            objCount = context.SS_HC_Anamnesis_AFAM_FE
                                                           .Where(t =>
                                                           t.UnidadReplicacion == objSC.UnidadReplicacion
                                                           && t.IdPaciente == objSC.IdPaciente
                                                           && t.EpisodioClinico == objSC.EpisodioClinico
                                                           && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                           && t.SecuenciaFamilia == objSC.SecuenciaFamilia
                                                           ).DefaultIfEmpty()
                                                            .Count();
                                        }
                                        /**TRANSACCIÓN*/
                                        if (objCount > 0)
                                        {
                                            if (objSC.Accion == "UPDATE")
                                            {

                                                context.Entry(objSC).State = EntityState.Modified;
                                                mapSecuenciaFam.Add("" + secuenciaFamAux, objSC.SecuenciaFamilia);
                                            }
                                            else if (objSC.Accion == "DELETE")
                                            {
                                                //PRIMERO ELIMINAR DETALLE
                                                List<SS_HC_Anamnesis_AFAM_Enfermedad_FE> objConsultasDet =
                                                    (from t in context.SS_HC_Anamnesis_AFAM_Enfermedad_FE
                                                     where
                                                     t.UnidadReplicacion == objSC.UnidadReplicacion
                                                     && t.IdPaciente == objSC.IdPaciente
                                                     && t.EpisodioClinico == objSC.EpisodioClinico
                                                     && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                     && t.SecuenciaFamilia == objSC.SecuenciaFamilia
                                                     orderby t.IdEpisodioAtencion descending
                                                     select t).ToList();
                                                if (objConsultasDet != null)
                                                {
                                                    foreach (SS_HC_Anamnesis_AFAM_Enfermedad_FE resultDet in objConsultasDet)
                                                    {
                                                        context.Entry(resultDet).State = EntityState.Deleted;
                                                    }
                                                }
                                                context.Entry(objSC).State = EntityState.Deleted;

                                                //** Agregado auditoria - Eliminar -->
                                                using (var contextEnty = new WEB_ERPSALUDEntities())
                                                {
                                                    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                                    //    dynamic DataKey;
                                                    DataKey = new
                                                    {
                                                        UnidadReplicacion = objSCabecera.UnidadReplicacion,
                                                        IdEpisodioAtencion = objSCabecera.IdEpisodioAtencion,
                                                        EpisodioClinico = objSCabecera.EpisodioClinico,
                                                        IdPaciente = objSCabecera.IdPaciente
                                                    };
                                                    string tempType = objAudit.Type;
                                                    objAudit = Control.AddAudita(new SS_HC_Anamnesis_AFAM_FE(), new SS_HC_Anamnesis_AFAM_FE(), DataKey, objAudit.Type);
                                                    objAudit.TableName = "SS_HC_Anamnesis_AFAM_FE ";
                                                    objAudit.Type = "D";
                                                    objAudit.Accion = "DELETE";
                                                    contextEnty.Entry(objAudit).State = EntityState.Added;
                                                    contextEnty.SaveChanges();
                                                }
                                                //**
                                            }
                                        }
                                        else
                                        {
                                            if (objSC.Accion == "NUEVO")
                                            {
                                                contadorCab++;
                                                objSC.SecuenciaFamilia = secuenciaFamMax + contadorCab;
                                                context.Entry(objSC).State = EntityState.Added;
                                                mapSecuenciaFam.Add("" + secuenciaFamAux, objSC.SecuenciaFamilia);
                                            }
                                        }
                                        valorRetorno = 1;
                                    }
                                    else
                                    {
                                        //valorRetorno = 0;
                                    }
                                }

                                /*********GUARDAR DETALLE******************************/
                                //if ( DetalleEnf.Count > 0)
                                if (DetalleEnf.Count != null || DetalleEnf.Count > 0)
                                {
                                    int contadorDet = 0;
                                    /**obtener la última secuencia*/
                                    var secuenciaMax = context.SS_HC_Anamnesis_AFAM_Enfermedad_FE
                                            .Where(t =>
                                                    t.IdPaciente == ObjTraces.IdPaciente
                                                    && t.UnidadReplicacion == ObjTraces.UnidadReplicacion
                                                    && t.EpisodioClinico == ObjTraces.EpisodioClinico
                                                    && t.IdEpisodioAtencion == ObjTraces.IdEpisodioAtencion
                                        //&& t.SecuenciaFamilia == ObjTraces.SecuenciaFamilia
                                            ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                                    foreach (SS_HC_Anamnesis_AFAM_Enfermedad_FE objDetalle in DetalleEnf)
                                    {
                                        objDetalle.Version = "CCEPF014";
                                        if (mapSecuenciaFam.ContainsKey("" + objDetalle.SecuenciaFamilia))
                                        {
                                            int SecuenciaFamReal = mapSecuenciaFam["" + objDetalle.SecuenciaFamilia];
                                            if (objDetalle.Accion == "DETALLE")
                                            {
                                                contadorDet++;
                                                objDetalle.SecuenciaFamilia = SecuenciaFamReal;
                                                objDetalle.Secuencia = secuenciaMax + contadorDet;
                                                context.Entry(objDetalle).State = EntityState.Added;
                                            }
                                            else if (objDetalle.Accion == "UPDATEDETALLE")
                                            {
                                                context.Entry(objDetalle).State = EntityState.Modified;
                                            }
                                            else if (objDetalle.Accion == "DELETEDETALLE")
                                            {
                                                context.Entry(objDetalle).State = EntityState.Deleted;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        /******************************************************/
                        //** Agregado auditoria --> N° 3
                        using (var contextEnty = new WEB_ERPSALUDEntities())
                        {
                            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                            //    dynamic DataKey;
                            DataKey = new
                            {
                                UnidadReplicacion = objSCabecera.UnidadReplicacion,
                                IdEpisodioAtencion = objSCabecera.IdEpisodioAtencion,
                                EpisodioClinico = objSCabecera.EpisodioClinico,
                                IdPaciente = objSCabecera.IdPaciente
                            };
                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_Anamnesis_AFAM_FE(), new SS_HC_Anamnesis_AFAM_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_Anamnesis_AFAM_FE ";
                            objAudit.Type = objSCabecera.Accion.Substring(0, 1);
                            objAudit.Accion = objSCabecera.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //**


                        context.SaveChanges();
                        dbContextTransaction.Commit();
                        valorRetorno = 1;
                    }
                    catch (Exception ex)
                    {
                        valorRetorno = 0;
                        dbContextTransaction.Rollback();
                        //throw ex;
                    }
                }
            }
            return valorRetorno;
        }
        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Anamnesis_AFAM_FE> obPadre, String TablaID)
        {
            string jsons = JsonConvert.SerializeObject(new[] { obPadre }, Newtonsoft.Json.Formatting.Indented);
            jsons = jsons.Trim().Substring(1, jsons.Length - 2);
            char coma = '"';
            string json = @"{ " + coma + "TRACKING_CHE" + coma + " : { ";
            string str1 = ": []";
            string str1_1 = ": null";
            jsons = jsons.Replace(str1, str1_1);
            var xmlDocument = new XmlDocument();
            var d = xmlDocument.CreateXmlDeclaration("1.0", "utf-16", "yes");
            xmlDocument.AppendChild(d);
            if (obPadre.Count == 0)
            {
                jsons = json + TablaID + "" + ": {" + coma + "Estado" + coma + ":" + coma + "No hay información" + coma + " }" + "} }";
            }
            else
            {
                jsons = json + TablaID + "" + ":" + jsons + "} }";
            }
            var xml = JsonConvert.DeserializeXmlNode(jsons);
            var root = xmlDocument.ImportNode(xml.DocumentElement, true);
            xmlDocument.AppendChild(root);
            return xmlDocument.OuterXml.ToString();
        }
        //--

        public List<SS_HC_Anamnesis_AFAM_FE> AnamnesisAFListarTOP(SS_HC_Anamnesis_AFAM_FE objSC)
        {
            try
            {
                dynamic DataKey = null;
                //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                List<SS_HC_Anamnesis_AFAM_FE> objLista = new List<SS_HC_Anamnesis_AFAM_FE>();
                //using (var context = new WEB_ERPSALUDEntities())
                using (var context = new ModelFormularios())
                {
                    List<SS_HC_Anamnesis_AFAM_FE> objConsultas = (from t in context.SS_HC_Anamnesis_AFAM_FE
                                                                  where
                                                                  t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                  && t.IdPaciente == objSC.IdPaciente
                                                                 /* && t.EpisodioClinico == objSC.EpisodioClinico*/
                                                                 /* && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion*/
                                                                  orderby t.IdEpisodioAtencion descending, t.EpisodioClinico descending 
                                                                  select  t).Take(1).ToList();



                    if (objConsultas != null)
                    {
                        objLista.AddRange(objConsultas);
                    }

                   
                   
                }
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SS_HC_Anamnesis_AFAM_CAB_FE> listarEntidadTOP(SS_HC_Anamnesis_AFAM_CAB_FE objSC)
        {

            List<SS_HC_Anamnesis_AFAM_CAB_FE> objLista = new List<SS_HC_Anamnesis_AFAM_CAB_FE>();
            using (var context = new ModelFormularios())
            {

                List<SS_HC_Anamnesis_AFAM_CAB_FE> objConsultas = (from t in context.SS_HC_Anamnesis_AFAM_CAB_FE
                                                                  where
                                                                   t.IdPaciente == objSC.IdPaciente
                                                                 /* && t.EpisodioClinico == objSC.EpisodioClinico
                                                                  && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion*/
                                                                  orderby t.IdEpisodioAtencion descending, t.EpisodioClinico descending
                                                                  select t).Take(1).ToList();

                if (objConsultas != null)
                {
                    objLista.AddRange(objConsultas);
                }
            }
            return objLista;
        }

    }
}
