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
using System.Data.Entity;  //Entity Framework
using System.Xml;
using System.Xml.Serialization;
using SoluccionSalud.Repository.Repository;
using Newtonsoft.Json;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class AntecedentesPersonalesINFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public List<SS_HC_AntecedentesPersonalesIN_FE> listarEntidad(SS_HC_AntecedentesPersonalesIN_FE ObjTrace)
        {
            try
            {
                List<SS_HC_AntecedentesPersonalesIN_FE> objLista = new List<SS_HC_AntecedentesPersonalesIN_FE>();
                using (var context = new ModelFormularios())
                {
                    objLista = context.USP_AntecedentesPersonalesINListarFE(
                                ObjTrace.UnidadReplicacion,
                                ObjTrace.IdEpisodioAtencion,
                                ObjTrace.IdPaciente,
                                ObjTrace.EpisodioClinico,
                                ObjTrace.CodigoSecuencia,
                                ObjTrace.UsuarioCreacion,
                                ObjTrace.FechaCreacion,
                                ObjTrace.UsuarioModificacion,
                                ObjTrace.FechaModificacion,
                                ObjTrace.Version,
                                ObjTrace.Accion
                            ).ToList();

                    //Agregado auditoria --> N° 2
                    using (var contextEnty = new WEB_ERPSALUDEntities())
                    {
                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                        dynamic DataKey;
                        DataKey = new
                        {
                            UnidadReplicacion = ObjTrace.UnidadReplicacion,
                            IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                            EpisodioClinico = ObjTrace.EpisodioClinico,
                            IdPaciente = ObjTrace.IdPaciente,
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
                        objAudit = Control.AddAudita(new SS_HC_AntecedentesPersonalesIN_FE(), new SS_HC_AntecedentesPersonalesIN_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_AntecedentesPersonalesIN_FE");
                        objAudit.TableName = "SS_HC_AntecedentesPersonalesIN_FE";
                        objAudit.Type = tempType;
                        objAudit.VistaData = xlmIn;
                        objAudit.Accion = ObjTrace.Accion;
                        contextEnty.Entry(objAudit).State = EntityState.Added;
                        contextEnty.SaveChanges();
                    }
                    //--
                }
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int setMantenimiento(SS_HC_AntecedentesPersonalesIN_FE objSC, List<SS_HC_AntecedentesPersonalesINDetalle_FE> Detalle)
        {

            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();

                        #region Cabecerra

                        if (objSC != null)
                        {

                            int objCount = 0;

                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {


                                objCount = context.SS_HC_AntecedentesPersonalesIN_FE
                                                  .Where(t =>
                                                        t.IdPaciente == objSC.IdPaciente
                                                        && t.UnidadReplicacion == objSC.UnidadReplicacion
                                                        && t.EpisodioClinico == objSC.EpisodioClinico
                                                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                    )
                                                  .DefaultIfEmpty()
                                                  .Count();

                            }

                            /**TRANSACCIÓN*/


                            if (objCount > 0)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    objSC.Version = "CCEPF012";
                                    context.Entry(objSC).State = EntityState.Modified;

                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    objSC.Version = "CCEPF012";
                                    context.Entry(objSC).State = EntityState.Added;
                                }
                            }

                            //context.SaveChanges();
                            //dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                            //valorRetorno = -1;
                        }

                        #endregion

                        /*********GUARDAR DETALLE***************/

                        #region Detalle

                        if (Detalle != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_AntecedentesPersonalesINDetalle_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            
                            foreach (SS_HC_AntecedentesPersonalesINDetalle_FE objDetalle in Detalle)
                            {
                                int secuenciaAux = objDetalle.Secuencia;
                                objDetalle.Version = "CCEPF012";
                                if (objDetalle.Accion == "DETALLE" || objDetalle.Accion == "NUEVO") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDetalle.Secuencia = secuenciaMax + contadorDet;
                                    objDetalle.Accion = "NUEVO";
                                    context.Entry(objDetalle).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {
                                    objDetalle.Accion = "UPDATE";
                                    context.Entry(objDetalle).State = EntityState.Modified;
                                    mapSecuencia.Add("" + secuenciaAux, objDetalle.Secuencia);

                                }
                                else if (objDetalle.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalle).State = EntityState.Deleted;

                                    //** Agregado auditoria - Eliminar -->
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objSC.UnidadReplicacion,
                                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                            EpisodioClinico = objSC.EpisodioClinico,
                                            IdPaciente = objSC.IdPaciente
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_AntecedentesPersonalesIN_FE(), new SS_HC_AntecedentesPersonalesIN_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AntecedentesPersonalesIN_FE ";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }


                        }

                        #endregion

                        //** Agregado auditoria --> N° 3
                        using (var contextEnty = new WEB_ERPSALUDEntities())
                        {
                            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                            dynamic DataKey;
                            DataKey = new
                            {
                                UnidadReplicacion = objSC.UnidadReplicacion,
                                IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                EpisodioClinico = objSC.EpisodioClinico,
                                IdPaciente = objSC.IdPaciente
                            };
                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_AntecedentesPersonalesIN_FE(), new SS_HC_AntecedentesPersonalesIN_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_AntecedentesPersonalesIN_FE ";
                            objAudit.Type = objSC.Accion.Substring(0, 1);
                            objAudit.Accion = objSC.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //**

                        /*******************************/

                        context.SaveChanges();
                        dbContextTransaction.Commit();

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
        public virtual String XMLString(List<SS_HC_AntecedentesPersonalesIN_FE> obPadre, String TablaID)
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

    }
}
