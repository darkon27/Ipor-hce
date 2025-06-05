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
    public class ProximaAtencionFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public int setMantenimiento(SS_HC_ProximaAtencion_FE ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                try
                {
                    iReturnValue = context.USP_ProximaAtencion_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                        ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.ProximaAtencionFlag,
                        ObjTrace.FechaSolicitada, ObjTrace.FechaPlaneada, ObjTrace.IdEspecialidad, ObjTrace.IdEstablecimientoSalud,
                        ObjTrace.IdTipoInterConsulta, ObjTrace.IdTipoReferencia, ObjTrace.Observacion, ObjTrace.IdProcedimiento,
                        ObjTrace.CodigoComponente, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS, ObjTrace.Estado,
                        ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                        ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPersonalSalud,
                        ObjTrace.IdDiagnostico, ObjTrace.ProcedimientoText, ObjTrace.DiagnosticoText).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                }
                catch (Exception ex)
                {
                    throw ex;
                }

            }
            return valorRetorno;
        }

        public List<SS_HC_ProximaAtencion_FE> ProximaAtencionListar(SS_HC_ProximaAtencion_FE ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_ProximaAtencion_FE> objLista = new List<SS_HC_ProximaAtencion_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_ProximaAtencion_FEListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.ProximaAtencionFlag,
                    ObjTrace.FechaSolicitada, ObjTrace.FechaPlaneada, ObjTrace.IdEspecialidad, ObjTrace.IdEstablecimientoSalud,
                    ObjTrace.IdTipoInterConsulta, ObjTrace.IdTipoReferencia, ObjTrace.Observacion, ObjTrace.IdProcedimiento,
                    ObjTrace.CodigoComponente, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS, ObjTrace.Estado,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                    ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPersonalSalud,
                    ObjTrace.IdDiagnostico, ObjTrace.ProcedimientoText, ObjTrace.DiagnosticoText).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    Secuencia = ObjTrace.Secuencia
                };

                //Agregado auditoria --> N° 2
                using (var contextEnty = new WEB_ERPSALUDEntities())
                {
                    //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                    //dynamic DataKey;
                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdPaciente = ObjTrace.IdPaciente,
                        Secuencia = ObjTrace.Secuencia
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
                    objAudit = Control.AddAudita(new SS_HC_ProximaAtencion_FE(), new SS_HC_ProximaAtencion_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_ProximaAtencion_FE");
                    objAudit.TableName = "SS_HC_ProximaAtencion_FE";
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

        public int setMantenimiento(SS_HC_ProximaAtencion_FE ObjTrace, List<SS_HC_ProximaAtencion_FE> listaDetalle, List<SS_HC_ProximaAtencionDiagnostico> listaDetalleDiag)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            SS_HC_ProximaAtencionDiagnostico_FE objDetalle;
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (ObjTrace != null)
                        {
                            //var InformacionObj = (from t in context.SS_HC_ProximaAtencion_FE
                            //                      where t.IdPaciente == ObjTrace.IdPaciente
                            //                      && t.EpisodioClinico == ObjTrace.EpisodioClinico
                            //                      && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                            //                      && t.Secuencia == ObjTrace.Secuencia
                            //                      orderby t.IdEpisodioAtencion descending
                            //                      select t).SingleOrDefault();
                            //if (InformacionObj == null) InformacionObj = new SS_HC_ProximaAtencion_FE();

                            //iReturnValue = context.USP_ProximaAtencion_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                            //    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.ProximaAtencionFlag,
                            //    ObjTrace.FechaSolicitada, ObjTrace.FechaPlaneada, ObjTrace.IdEspecialidad, ObjTrace.IdEstablecimientoSalud,
                            //    ObjTrace.IdTipoInterConsulta, ObjTrace.IdTipoReferencia, ObjTrace.Observacion, ObjTrace.IdProcedimiento,
                            //    ObjTrace.CodigoComponente, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS, ObjTrace.Estado,
                            //    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                            //    ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPersonalSalud,
                            //    ObjTrace.IdDiagnostico, ObjTrace.ProcedimientoText, ObjTrace.DiagnosticoText).SingleOrDefault();
                            //valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());                            //detalle
                            //int secuenciaReg = Convert.ToInt32(iReturnValue.ToString().Trim());                            //detalle
                            //DataKey = new
                            //{
                            //    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                            //    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                            //    EpisodioClinico = ObjTrace.EpisodioClinico,
                            //    IdPaciente = ObjTrace.IdPaciente,
                            //    Secuencia = ObjTrace.Secuencia,
                            //    ProximaAtencionFlag = ObjTrace.ProximaAtencionFlag
                            //};
                            // Audit

                            //objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                            //objAudit.TableName = "SS_HC_ProximaAtencion";
                            //objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                            //context.Entry(objAudit).State = EntityState.Added;


                            if (listaDetalle != null)
                            {
                                foreach (var obj in listaDetalle)
                                {
                                    if (obj.Accion == "DELETE")
                                    {
                                        //** Agregado auditoria --> Eliminar
                                        using (var contextEnty = new WEB_ERPSALUDEntities())
                                        {
                                            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                            //dynamic DataKey;
                                            DataKey = new
                                            {
                                                UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                                IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                                EpisodioClinico = ObjTrace.EpisodioClinico,
                                                IdPaciente = ObjTrace.IdPaciente
                                            };
                                            string tempType = objAudit.Type;
                                            objAudit = Control.AddAudita(new SS_HC_ProximaAtencion_FE(), new SS_HC_ProximaAtencion_FE(), DataKey, objAudit.Type);
                                            objAudit.TableName = "SS_HC_ProximaAtencion_FE ";
                                            objAudit.Type = "D";
                                            objAudit.Accion = "DELETE";
                                            contextEnty.Entry(objAudit).State = EntityState.Added;
                                            contextEnty.SaveChanges();
                                        }
                                        //**
                                    }

                                    int tempoCod = 0;
                                    if (obj.Version != null) tempoCod = Convert.ToInt32(obj.Version.Trim());

                                    var InformacionObjDell = (from t in context.SS_HC_ProximaAtencionDiagnostico_FE
                                                              where t.IdPaciente == obj.IdPaciente
                                                              && t.EpisodioClinico == obj.EpisodioClinico
                                                              && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
                                                              && t.Secuencia == obj.Secuencia
                                                              && t.SecuenciaProximaAtencion == tempoCod
                                                              orderby t.IdEpisodioAtencion descending
                                                              select t).SingleOrDefault();
                                    if (InformacionObjDell == null) InformacionObjDell = new SS_HC_ProximaAtencionDiagnostico_FE();

                                    objDetalle = new SS_HC_ProximaAtencionDiagnostico_FE();
                                    objDetalle.UnidadReplicacion = obj.UnidadReplicacion;
                                    objDetalle.IdPaciente = obj.IdPaciente;
                                    objDetalle.EpisodioClinico = obj.EpisodioClinico;
                                    objDetalle.IdEpisodioAtencion = obj.IdEpisodioAtencion;
                                    objDetalle.Secuencia = obj.Secuencia;
                                    objDetalle.SecuenciaProximaAtencion = tempoCod;
                                    objDetalle.UnidadReplicacion = obj.UnidadReplicacion;
                                    objDetalle.IdDiagnostico = obj.IdProcedimiento;

                                    //--obj.Secuencia = secuenciaReg;
                                    iReturnValue = context.USP_ProximaAtencion_FE(obj.UnidadReplicacion, obj.IdEpisodioAtencion,
                                        obj.IdPaciente, obj.EpisodioClinico, obj.Secuencia, obj.ProximaAtencionFlag,
                                        obj.FechaSolicitada, obj.FechaPlaneada, obj.IdEspecialidad, obj.IdEstablecimientoSalud,
                                        obj.IdTipoInterConsulta, obj.IdTipoReferencia, obj.Observacion, obj.IdProcedimiento,
                                        obj.CodigoComponente, obj.TipoOrdenAtencion, obj.IndicadorEPS, obj.Estado,
                                        obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion, obj.FechaModificacion,
                                        obj.Accion, obj.Version, obj.IdPersonalSalud,
                                        obj.IdDiagnostico, obj.ProcedimientoText, obj.DiagnosticoText).SingleOrDefault();
                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                }
                            }
                        }

                        //** Agregado auditoria --> N° 3
                        using (var contextEnty = new WEB_ERPSALUDEntities())
                        {
                            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                            //dynamic DataKey;
                            DataKey = new
                            {
                                UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                EpisodioClinico = ObjTrace.EpisodioClinico,
                                IdPaciente = ObjTrace.IdPaciente
                            };
                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_ProximaAtencion_FE(), new SS_HC_ProximaAtencion_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_ProximaAtencion_FE ";
                            objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                            objAudit.Accion = ObjTrace.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //**

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
        public virtual String XMLString(List<SS_HC_ProximaAtencion_FE> obPadre, String TablaID)
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
