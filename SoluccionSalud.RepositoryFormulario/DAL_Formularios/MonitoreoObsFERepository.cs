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
using System.Data.Entity; //Entity Framework
using System.Xml;
using System.Xml.Serialization;
using SoluccionSalud.Repository.Repository;
using Newtonsoft.Json;




namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class MonitoreoObsFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public List<SS_HC_Monitoreo_Obs_FE> MonitoreoListar(SS_HC_Monitoreo_Obs_FE ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_Monitoreo_Obs_FE> objLista = new List<SS_HC_Monitoreo_Obs_FE>();

            using (var context = new ModelFormularios())
            {
                objLista = context.SP_SS_HC_Monitoreo_Obs_Listar_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.IdMedico, ObjTrace.IdEspecialidad, ObjTrace.IdMonitoreo,ObjTrace.Hora_Inicio,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdDiagnostico, ObjTrace.IdFormaInicio,ObjTrace.Estado).ToList();

                //Agregado auditoria --> N° 2
                using (var contextEnty = new WEB_ERPSALUDEntities())
                {
                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
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
                    objAudit = Control.AddAudita(new SS_HC_Monitoreo_Obs_FE(), new SS_HC_Monitoreo_Obs_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_Monitoreo_Obs_FE");
                    objAudit.TableName = "SS_HC_Monitoreo_Obs_FE";
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

        public int setMantenimiento(SS_HC_Monitoreo_Obs_FE ObjTraces, List<SS_HC_Monitoreo_Obs_FE> Cabecera, List<SS_HC_Monitoreo_Obs_FE> Detalle)
        {

            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();

            SS_HC_Monitoreo_Obs_Diagnostico_FE objDesMedDiag;
            SS_HC_Monitoreo_Obs_Diagnostico_FE InforDetalleObj = new SS_HC_Monitoreo_Obs_Diagnostico_FE();

            InforDetalleObj.SS_HC_Monitoreo_Obs_FE = null;

            System.Nullable<int> iReturnValue;

            int valorRetorno = 0;

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (SS_HC_Monitoreo_Obs_FE ObjTrace in Cabecera)
                        {
                            var InformacionObj = (from t in context.SS_HC_Monitoreo_Obs_FE
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();

                            //if (InformacionObj == null) InformacionObj = new SS_HC_DescansoMedico_FE();

                            iReturnValue = context.SP_SS_HC_Monitoreo_Obs_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                          ObjTrace.EpisodioClinico, ObjTrace.IdMedico, ObjTrace.IdEspecialidad, ObjTrace.IdMonitoreo, ObjTrace.Hora_Inicio,
                                           ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, 
                                           ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdDiagnostico, ObjTrace.IdFormaInicio, ObjTrace.Estado).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());



                            foreach (SS_HC_Monitoreo_Obs_FE ObjTraceDell in Detalle)
                            {

                                var virtualObj = (from t in context.SS_HC_Monitoreo_Obs_Diagnostico_FE
                                                  where t.IdPaciente == ObjTraceDell.IdPaciente
                                                 && t.EpisodioClinico == ObjTraceDell.EpisodioClinico
                                                 && t.IdEpisodioAtencion == ObjTraceDell.IdEpisodioAtencion
                                                 && t.Secuencia == ObjTraceDell.IdFormaInicio
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();


                                if (InformacionObj != null && virtualObj == null && ObjTraceDell.Accion != "DELETE")
                                {
                                    ObjTraceDell.Accion = "INSERTDETALLE";
                                }



                                if (virtualObj != null) InforDetalleObj = virtualObj;

                                objDesMedDiag = new SS_HC_Monitoreo_Obs_Diagnostico_FE();
                                objDesMedDiag.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
                                objDesMedDiag.IdPaciente = ObjTraceDell.IdPaciente;
                                objDesMedDiag.EpisodioClinico = ObjTraceDell.EpisodioClinico;
                                objDesMedDiag.IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion;
                                if (ObjTraceDell.IdFormaInicio != null) objDesMedDiag.Secuencia = (int)ObjTraceDell.IdFormaInicio;
                                objDesMedDiag.IdDiagnostico = (int)ObjTraceDell.IdDiagnostico;

                                context.SP_SS_HC_Monitoreo_Obs_FE(ObjTraceDell.UnidadReplicacion, ObjTraceDell.IdEpisodioAtencion, ObjTraceDell.IdPaciente,
                                ObjTraceDell.EpisodioClinico, ObjTraceDell.IdMedico, ObjTraceDell.IdEspecialidad,ObjTrace.IdMonitoreo, ObjTrace.Hora_Inicio,
                                 ObjTraceDell.UsuarioCreacion, ObjTraceDell.FechaCreacion, ObjTraceDell.UsuarioModificacion,
                                ObjTraceDell.FechaModificacion, ObjTraceDell.Accion, ObjTraceDell.Version,
                                ObjTraceDell.IdDiagnostico, ObjTraceDell.IdFormaInicio, ObjTraceDell.Estado).SingleOrDefault();

                                //** Agregado auditoria --> N° 3
                                using (var contextEnty = new WEB_ERPSALUDEntities())
                                {
                                    //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                    dynamic DataKey;
                                    DataKey = new
                                    {
                                        UnidadReplicacion = ObjTraces.UnidadReplicacion,
                                        IdEpisodioAtencion = ObjTraces.IdEpisodioAtencion,
                                        EpisodioClinico = ObjTraces.EpisodioClinico,
                                        IdPaciente = ObjTraces.IdPaciente
                                    };
                                    string tempType = objAudit.Type;
                                    objAudit = Control.AddAudita(new SS_HC_Monitoreo_Obs_FE(), new SS_HC_Monitoreo_Obs_FE(), DataKey, objAudit.Type);
                                    objAudit.TableName = "SS_HC_Monitoreo_Obs_FE ";
                                    objAudit.Type = ObjTraces.Accion.Substring(0, 1);
                                    objAudit.Accion = ObjTraces.Accion;
                                    contextEnty.Entry(objAudit).State = EntityState.Added;
                                    contextEnty.SaveChanges();
                                }
                                //**

                            }
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());



                        }




                        /*******************************/
                        context.SaveChanges();
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        var sqlException = ex.InnerException as SqlException;
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        public int setMantenimientoGrupo(SS_HC_Monitoreo_Obs_FE ObjTraces, List<SS_HC_Monitoreo_Obs_Ing_FE> listaCabecera01)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        //if (ObjTraces != null)
                        //{
                        //    iReturnValue = context.SP_SS_HC_Monitoreo_Obs_FE(ObjTraces.UnidadReplicacion, ObjTraces.IdEpisodioAtencion, ObjTraces.IdPaciente,
                        //               ObjTraces.EpisodioClinico, ObjTraces.IdMedico, ObjTraces.IdEspecialidad, ObjTraces.IdMonitoreo, ObjTraces.Hora_Inicio,
                        //               ObjTraces.UsuarioCreacion, ObjTraces.FechaCreacion, ObjTraces.UsuarioModificacion, ObjTraces.FechaModificacion,
                        //               ObjTraces.Accion, ObjTraces.Version, ObjTraces.IdDiagnostico, ObjTraces.IdFormaInicio, ObjTraces.Estado).SingleOrDefault();
                        //    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        //}
                        if (listaCabecera01 != null)
                        {
                            foreach (var ObjTrace in listaCabecera01)
                            {

                                iReturnValue = context.SP_SS_HC_Monitoreo_Obs_Ing_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,

                                   ObjTrace.Secuencia, 
                                   ObjTrace.Fecha, ObjTrace.Hora,ObjTrace.Goteoxmin,ObjTrace.MU,ObjTrace.Fun_Vital_PA1,ObjTrace.Fun_Vital_PA2,ObjTrace.Fun_Vital_P,
                                   ObjTrace.Fun_Vital_R,ObjTrace.Fun_Vital_T,ObjTrace.FCF,ObjTrace.Din_Ut_Frec,ObjTrace.Din_Ut_Dur,ObjTrace.Din_Ut_Int,ObjTrace.Ex_Val_Dilat,
                                   ObjTrace.Ex_Val_Incorp,ObjTrace.Ex_Val_AP,ObjTrace.Ex_Val_IdM,ObjTrace.Observaciones,ObjTrace.Firma,
                                   ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                                ).SingleOrDefault();


                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());


                            }
                        }
                       
                        
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


        public List<SS_HC_Monitoreo_Obs_Ing_FE> Listar_MonitoreoIngreso(SS_HC_Monitoreo_Obs_Ing_FE obj)
        {

            List<SS_HC_Monitoreo_Obs_Ing_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_Monitoreo_Obs_Ing_FE_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.Secuencia
                                     , obj.Fecha
                                     , obj.Hora
                                     , obj.Goteoxmin
                                     , obj.MU
                                     , obj.Fun_Vital_PA1
                                     , obj.Fun_Vital_PA2
                                     , obj.Fun_Vital_P
                                     , obj.Fun_Vital_R
                                     , obj.Fun_Vital_T
                                     , obj.FCF
                                     , obj.Din_Ut_Frec
                                     , obj.Din_Ut_Dur
                                     , obj.Din_Ut_Int
                                     , obj.Ex_Val_Dilat
                                     , obj.Ex_Val_Incorp
                                     , obj.Ex_Val_AP
                                     , obj.Ex_Val_IdM
                                     , obj.Observaciones
                                     , obj.Firma
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objExamen;

        }

        public virtual String XMLString(List<SS_HC_Monitoreo_Obs_FE> obPadre, String TablaID)
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
