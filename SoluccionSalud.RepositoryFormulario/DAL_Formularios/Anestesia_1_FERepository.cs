using Newtonsoft.Json;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.ModelERP_FORM;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class Anestesia_1_FERepository
    {

        
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1




        public List<SS_HC_FichaAnestesia_1_FE> listarEntidad(SS_HC_FichaAnestesia_1_FE ObjTrace)
        {
            try
            {
                List<SS_HC_FichaAnestesia_1_FE> objLista = new List<SS_HC_FichaAnestesia_1_FE>();
                using (var context = new ModelFormularios())
                {


                    objLista = context.SS_HC_FichaAnestesia_1_FE
                               .Where(t =>
                                       t.IdPaciente == ObjTrace.IdPaciente
                                       && t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                       && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                       && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
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
                            IdPaciente = ObjTrace.IdPaciente
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
                        objAudit = Control.AddAudita(new SS_HC_FichaAnestesia_1_FE(), new SS_HC_FichaAnestesia_1_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_FichaAnestesia_1_FE");
                        objAudit.TableName = "SS_HC_FichaAnestesia_1_FE";
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



        public int setMantenimiento(SS_HC_FichaAnestesia_1_FE objSC, List<SS_HC_AnestesiaExamenApoyoDetalle_FE> ExamenDetalle1,
            List<SS_HC_AnestesiaDiagnosticoDetalle_FE> DiagnosticoDetalle2, List<SS_HC_AnestesiaExamenApoyoDetalle_FE> ObjDetalle3, List<SS_HC_AnestesiaExamenApoyoDetalle_FE> ObjDetalle4, List<SS_HC_AnestesiaDiagnosticoDetalle_FE> ObjDetalle5
       )
        {

            int valorRetorno = -1; //ERROR
            int contadorDetDos = 0;
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();

                        if (objSC != null)
                        {

                            SS_HC_FichaAnestesia_1_FE objAnterior = null;
                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objAnterior = (from t in context.SS_HC_FichaAnestesia_1_FE
                                               where
                                               t.UnidadReplicacion == objSC.UnidadReplicacion
                                               && t.IdPaciente == objSC.IdPaciente
                                               && t.EpisodioClinico == objSC.EpisodioClinico
                                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                               orderby t.IdEpisodioAtencion descending
                                               select t).SingleOrDefault();
                            }
                            /**TRANSACCIÓN*/
                            if (objAnterior != null)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    //objSC.Accion = "CCEPF005";
                                    objSC.Accion = "UPDATE";
                                    context.Entry(objSC).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    //objSC.Accion = "CCEPF005";
                                    objSC.Accion = "NUEVO";
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



                        if (ExamenDetalle1 != null)
                        {

                            /**obtener la última secuencia*/
                            var secuenciaMaxDos = context.SS_HC_AnestesiaExamenApoyoDetalle_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_AnestesiaExamenApoyoDetalle_FE objDetalle2Ciru in ExamenDetalle1)
                            {

                                //int secuenciaAuxDos = objDetalleDos.Secuencia;
                                if (objDetalle2Ciru.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDetDos++;
                                    objDetalle2Ciru.Secuencia = secuenciaMaxDos + contadorDetDos;
                                    context.Entry(objDetalle2Ciru).State = EntityState.Added;
                                }
                                else if (objDetalle2Ciru.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {
                                    context.Entry(objDetalle2Ciru).State = EntityState.Modified;
                                    //mapSecuencia.Add("" + secuenciaAuxDos, objDetalleDos.Secuencia);

                                }
                                else if (objDetalle2Ciru.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalle2Ciru).State = EntityState.Deleted;

                                    //** Agregado auditoria -->Eliminar
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
                                        objAudit = Control.AddAudita(new SS_HC_AnestesiaExamenApoyoDetalle_FE(), new SS_HC_AnestesiaExamenApoyoDetalle_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AnestesiaExamenApoyoDetalle_FE ";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }

                        /*********GUARDAR DETALLE 2 ***************/
                        if (DiagnosticoDetalle2 != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_AnestesiaDiagnosticoDetalle_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                //  && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_AnestesiaDiagnosticoDetalle_FE objDetalle in DiagnosticoDetalle2)
                            {
                                int secuenciaAux = objDetalle.Secuencia;
                                if (objDetalle.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDetalle.Secuencia = secuenciaMax + contadorDet;
                                    objDetalle.Version = "CCEPF323_1";
                                    //objDetalle.Accion = "NUEVO";
                                    context.Entry(objDetalle).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {

                                    objDetalle.Version = "CCEPF323_1";
                                    objDetalle.Accion = "UPDATE";
                                    context.Entry(objDetalle).State = EntityState.Modified;
                                    mapSecuencia.Add("" + secuenciaAux, objDetalle.Secuencia);

                                }
                                else if (objDetalle.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalle).State = EntityState.Deleted;
                                    //** Agregado auditoria -->Eliminar
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
                                            IdPaciente = objSC.IdPaciente,
                                            //  IdGinecoobstetricos = objSC.IdGinecoobstetricos
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_AnestesiaDiagnosticoDetalle_FE(), new SS_HC_AnestesiaDiagnosticoDetalle_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AnestesiaDiagnosticoDetalle_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }




                        /*********GUARDAR DETALLE 3 ***************/
                        if (ObjDetalle3 != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_AnestesiaExamenApoyoDetalle_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                //  && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_AnestesiaExamenApoyoDetalle_FE objDetalle in ObjDetalle3)
                            {
                                int secuenciaAux = objDetalle.Secuencia;
                                if (objDetalle.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDetalle.Secuencia = secuenciaMax + contadorDet;
                                    objDetalle.Version = "CCEPF323_1";
                                    //objDetalle.Accion = "NUEVO";
                                    context.Entry(objDetalle).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {

                                    objDetalle.Version = "CCEPF323_1";
                                    objDetalle.Accion = "UPDATE";
                                    context.Entry(objDetalle).State = EntityState.Modified;
                                    mapSecuencia.Add("" + secuenciaAux, objDetalle.Secuencia);

                                }
                                else if (objDetalle.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalle).State = EntityState.Deleted;
                                    //** Agregado auditoria -->Eliminar
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
                                            IdPaciente = objSC.IdPaciente,
                                            //  IdGinecoobstetricos = objSC.IdGinecoobstetricos
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_AnestesiaExamenApoyoDetalle_FE(), new SS_HC_AnestesiaExamenApoyoDetalle_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AnestesiaExamenApoyoDetalle_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }


                        /*********GUARDAR DETALLE 4 ***************/
                        if (ObjDetalle4 != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_AnestesiaExamenApoyoDetalle_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                //  && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_AnestesiaExamenApoyoDetalle_FE objDetalle in ObjDetalle4)
                            {
                                int secuenciaAux = objDetalle.Secuencia;
                                if (objDetalle.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDetalle.Secuencia = secuenciaMax + contadorDet;
                                    objDetalle.Version = "CCEPF323_1";
                                    //objDetalle.Accion = "NUEVO";
                                    context.Entry(objDetalle).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {

                                    objDetalle.Version = "CCEPF323_1";
                                    objDetalle.Accion = "UPDATE";
                                    context.Entry(objDetalle).State = EntityState.Modified;
                                    mapSecuencia.Add("" + secuenciaAux, objDetalle.Secuencia);

                                }
                                else if (objDetalle.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalle).State = EntityState.Deleted;
                                    //** Agregado auditoria -->Eliminar
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
                                            IdPaciente = objSC.IdPaciente,
                                            //  IdGinecoobstetricos = objSC.IdGinecoobstetricos
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_AnestesiaExamenApoyoDetalle_FE(), new SS_HC_AnestesiaExamenApoyoDetalle_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AnestesiaExamenApoyoDetalle_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }


                        /*********GUARDAR DETALLE 5 ***************/
                        if (ObjDetalle5 != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax = context.SS_HC_AnestesiaDiagnosticoDetalle_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                //  && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_AnestesiaDiagnosticoDetalle_FE objDetalle in ObjDetalle5)
                            {
                                int secuenciaAux = objDetalle.Secuencia;
                                if (objDetalle.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDet++;
                                    objDetalle.Secuencia = secuenciaMax + contadorDet;
                                    objDetalle.Version = "CCEPF323_1";
                                    //objDetalle.Accion = "NUEVO";
                                    context.Entry(objDetalle).State = EntityState.Added;
                                }
                                else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                {

                                    objDetalle.Version = "CCEPF323_1";
                                    objDetalle.Accion = "UPDATE";
                                    context.Entry(objDetalle).State = EntityState.Modified;
                                    mapSecuencia.Add("" + secuenciaAux, objDetalle.Secuencia);

                                }
                                else if (objDetalle.Accion == "DELETEDETALLE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalle).State = EntityState.Deleted;
                                    //** Agregado auditoria -->Eliminar
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
                                            IdPaciente = objSC.IdPaciente,
                                            //  IdGinecoobstetricos = objSC.IdGinecoobstetricos
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_AnestesiaDiagnosticoDetalle_FE(), new SS_HC_AnestesiaDiagnosticoDetalle_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_AnestesiaDiagnosticoDetalle_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }

                        



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
                            objAudit = Control.AddAudita(new SS_HC_FichaAnestesia_1_FE(), new SS_HC_FichaAnestesia_1_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_FichaAnestesia_1_FE ";
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
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_FichaAnestesia_1_FE> obPadre, String TablaID)
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




    }
}
