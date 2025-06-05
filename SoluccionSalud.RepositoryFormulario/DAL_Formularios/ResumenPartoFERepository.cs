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
    public class ResumenPartoFERepository
    {

        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public List<SS_HC_RESUMEN_PARTO_FE> ResumenPartoListar(SS_HC_RESUMEN_PARTO_FE ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_RESUMEN_PARTO_FE> objLista = new List<SS_HC_RESUMEN_PARTO_FE>();

            using (var context = new ModelFormularios())
            {
                objLista = context.SP_SS_HC_RESUMEN_PARTO_LISTAR_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.IdResParto, ObjTrace.Fecha_Ing, ObjTrace.Hora_Ing, ObjTrace.Controladora,
                    ObjTrace.Membranas, ObjTrace.Horas_memb, ObjTrace.P_Selector1, ObjTrace.P_Selector2, ObjTrace.P_Observacion,
                    ObjTrace.P_Dur_Parto, ObjTrace.S_Selector1, ObjTrace.Observaciones1_S, ObjTrace.S_Fecha_Parto, ObjTrace.S_Hora_Parto,
                    ObjTrace.S_Selector2, ObjTrace.S_Episiotomia, ObjTrace.S_Desgarro, ObjTrace.S_Selector3, ObjTrace.S_Selector4,
                    ObjTrace.Observaciones2_S, ObjTrace.S_Dur_Parto, 
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version,ObjTrace.Estado).ToList();

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
                    objAudit = Control.AddAudita(new SS_HC_RESUMEN_PARTO_FE(), new SS_HC_RESUMEN_PARTO_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_RESUMEN_PARTO_FE");
                    objAudit.TableName = "SS_HC_RESUMEN_PARTO_FE";
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

        public int setResumenPartoMantenimiento(SS_HC_RESUMEN_PARTO_FE ObjTraces, List<SS_HC_RESUMEN_PARTO_FE> Cabecera)
        {

            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();

               

            System.Nullable<int> iReturnValue;

            int valorRetorno = 0;

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (SS_HC_RESUMEN_PARTO_FE ObjTrace in Cabecera)
                        {
                            var InformacionObj = (from t in context.SS_HC_RESUMEN_PARTO_FE
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();

                            //if (InformacionObj == null) InformacionObj = new SS_HC_DescansoMedico_FE();

                            iReturnValue = context.SP_SS_HC_RESUMEN_PARTO_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                            ObjTrace.EpisodioClinico, ObjTrace.IdResParto, ObjTrace.Fecha_Ing, ObjTrace.Hora_Ing, ObjTrace.Controladora,
                                            ObjTrace.Membranas, ObjTrace.Horas_memb, ObjTrace.P_Selector1, ObjTrace.P_Selector2, ObjTrace.P_Observacion,
                                            ObjTrace.P_Dur_Parto, ObjTrace.S_Selector1, ObjTrace.Observaciones1_S, ObjTrace.S_Fecha_Parto, ObjTrace.S_Hora_Parto,
                                            ObjTrace.S_Selector2, ObjTrace.S_Episiotomia, ObjTrace.S_Desgarro, ObjTrace.S_Selector3, ObjTrace.S_Selector4,
                                            ObjTrace.Observaciones2_S, ObjTrace.S_Dur_Parto,
                                            ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                            ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Estado).SingleOrDefault();

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
                                                objAudit = Control.AddAudita(new SS_HC_RESUMEN_PARTO_FE(), new SS_HC_RESUMEN_PARTO_FE(), DataKey, objAudit.Type);
                                                objAudit.TableName = "SS_HC_RESUMEN_PARTO_FE ";
                                                objAudit.Type = ObjTraces.Accion.Substring(0, 1);
                                                objAudit.Accion = ObjTraces.Accion;
                                                contextEnty.Entry(objAudit).State = EntityState.Added;
                                                contextEnty.SaveChanges();
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

        public int setMantenimientoGrupo(SS_HC_RESUMEN_PARTO_FE ObjTraces, List<SS_HC_RESPARTO_EMB_ANT_FE> listaCabecera01, List<SS_HC_RESPARTO_EMB_ACT_FE> listaCabecera02)
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


                        if (ObjTraces != null)
                        {


                            iReturnValue = context.SP_SS_HC_RESUMEN_PARTO_FE(ObjTraces.UnidadReplicacion, ObjTraces.IdEpisodioAtencion, ObjTraces.IdPaciente,
                                              ObjTraces.EpisodioClinico, ObjTraces.IdResParto, ObjTraces.Fecha_Ing, ObjTraces.Hora_Ing, ObjTraces.Controladora,
                                              ObjTraces.Membranas, ObjTraces.Horas_memb, ObjTraces.P_Selector1, ObjTraces.P_Selector2, ObjTraces.P_Observacion,
                                              ObjTraces.P_Dur_Parto, ObjTraces.S_Selector1, ObjTraces.Observaciones1_S, ObjTraces.S_Fecha_Parto, ObjTraces.S_Hora_Parto,
                                              ObjTraces.S_Selector2, ObjTraces.S_Episiotomia, ObjTraces.S_Desgarro, ObjTraces.S_Selector3, ObjTraces.S_Selector4,
                                              ObjTraces.Observaciones2_S, ObjTraces.S_Dur_Parto,
                                              ObjTraces.UsuarioCreacion, ObjTraces.FechaCreacion, ObjTraces.UsuarioModificacion,
                                              ObjTraces.FechaModificacion, ObjTraces.Accion, ObjTraces.Version, ObjTraces.Estado).SingleOrDefault();



                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());


                            
                        }
                       
                        if (listaCabecera01 != null)
                        {
                            foreach (var ObjTrace in listaCabecera01)
                            {

                                iReturnValue = context.SP_SS_HC_RESPARTO_EMB_ANT_FE_(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,

                                   ObjTrace.Secuencia,
                                   ObjTrace.Pariedad1, ObjTrace.Pariedad2, ObjTrace.Pariedad3, ObjTrace.Pariedad4, ObjTrace.Gravidez, 
                                   ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                                ).SingleOrDefault();


                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());


                            }
                        }

                        if (listaCabecera02 != null)
                        {
                            foreach (var ObjTrace in listaCabecera02)
                            {

                                iReturnValue = context.SP_SS_HC_RESPARTO_EMB_ACT_FE_(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,

                                   ObjTrace.Secuencia,
                                   ObjTrace.FUR, ObjTrace.FPP, ObjTrace.EGXFUR, ObjTrace.PFGECO, ObjTrace.EG,ObjTrace.AU,
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


        public List<SS_HC_RESPARTO_EMB_ANT_FE> Listar_ResumenPartoAnt(SS_HC_RESPARTO_EMB_ANT_FE obj)
        {

            List<SS_HC_RESPARTO_EMB_ANT_FE> objResumenParto = null;

            using (var context = new ModelFormularios())
            {

                objResumenParto = context.SP_SS_HC_RESPARTO_EMB_ANT_FE_LISTAR(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.Secuencia
                                     , obj.Pariedad1
                                     , obj.Pariedad2
                                     , obj.Pariedad3
                                     , obj.Pariedad4
                                     , obj.Gravidez                                     
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objResumenParto;

        }


        public List<SS_HC_RESPARTO_EMB_ACT_FE> Listar_ResumenPartoAct(SS_HC_RESPARTO_EMB_ACT_FE obj)
        {

            List<SS_HC_RESPARTO_EMB_ACT_FE> objResumenPartoAct = null;

            using (var context = new ModelFormularios())
            {

                objResumenPartoAct = context.SP_SS_HC_RESPARTO_EMB_ACT_FE_LISTAR(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.Secuencia
                                     , obj.FUR
                                     , obj.FPP
                                     , obj.EGXFUR
                                     , obj.PFGECO
                                     , obj.EG
                                     , obj.AU
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objResumenPartoAct;

        }


        public virtual String XMLString(List<SS_HC_RESUMEN_PARTO_FE> obPadre, String TablaID)
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
