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
    public class InterConsultaFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public List<SS_HC_InterConsulta_FE> InterConsultaListar(SS_HC_InterConsulta_FE ObjTrace)
        {
            //dynamic DataKey;
            List<SS_HC_InterConsulta_FE> objLista = new List<SS_HC_InterConsulta_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_InterConsulta_FEListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.ProximaAtencionFlag,
                    ObjTrace.FechaSolicitada, ObjTrace.FechaPlaneada, ObjTrace.IdEspecialidad, ObjTrace.IdEstablecimientoSalud,
                    ObjTrace.IdTipoInterConsulta, ObjTrace.IdTipoReferencia, ObjTrace.Observacion, ObjTrace.IdProcedimiento,
                    ObjTrace.CodigoComponente, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS, ObjTrace.Estado,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                    ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPersonalSalud,
                    ObjTrace.IdDiagnostico, ObjTrace.ProcedimientoText, ObjTrace.DiagnosticoText).ToList();

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
                    objAudit = Control.AddAudita(new SS_HC_InterConsulta_FE(), new SS_HC_InterConsulta_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_InterConsulta_FE");
                    objAudit.TableName = "SS_HC_InterConsulta_FE";
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

        public int setMantenimiento(SS_HC_InterConsulta_FE ObjTrace, List<SS_HC_InterConsulta_FE> listaDetalle)
        {
            int valorRetorno = 0;
            System.Nullable<int> iReturnValue;
            var secuenciaMax = 0;

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                       
                        if (listaDetalle != null)
                        {
                            int a = 0;
                            foreach (SS_HC_InterConsulta_FE objSC in listaDetalle)
                            {



                                if (objSC.Accion == "NUEVO") // Insertar Detalle
                                {

                                     secuenciaMax = context.SS_HC_InterConsulta_FE
                                                  .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                                    var secuMax = secuenciaMax + 1;

                                    iReturnValue = context.USP_InterConsulta_FE_Insert(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                                              objSC.IdPaciente, objSC.EpisodioClinico,
                                             secuMax,
                                              null, objSC.FechaSolicitada,
                                              objSC.FechaPlaneada, objSC.IdEspecialidad,
                                              objSC.IdEstablecimientoSalud, objSC.IdTipoInterConsulta, objSC.IdTipoReferencia,
                                              objSC.Observacion,
                                              null, objSC.CodigoComponente, objSC.TipoOrdenAtencion,
                                              objSC.IndicadorEPS, objSC.Estado, objSC.UsuarioCreacion,
                                              objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                                              objSC.Accion, objSC.Version,
                                              objSC.IdPersonalSalud, objSC.IdDiagnostico, objSC.ProcedimientoText
                                              , objSC.DiagnosticoText, objSC.IdProcedimiento, null, null, objSC.IdDiagnostico).SingleOrDefault();

                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                    // D E T A L L E


                                    //Agregado auditoria --> N° 3
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

                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_InterConsulta_FE(), new SS_HC_InterConsulta_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_InterConsulta_FE";
                                        objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                        objAudit.Accion = ObjTrace.Accion;
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                }

                                if (objSC.Accion == "UPDATE") // UPDATE Detalle
                                {
                                   // secuenciaMax++;
                                    iReturnValue = context.USP_InterConsulta_FE_Insert(objSC.UnidadReplicacion,
                                        objSC.IdEpisodioAtencion,
                                              objSC.IdPaciente,
                                              objSC.EpisodioClinico,
                                             objSC.Secuencia,
                                             null,
                                             objSC.FechaSolicitada,
                                              objSC.FechaPlaneada,
                                              objSC.IdEspecialidad,
                                              objSC.IdEstablecimientoSalud,
                                              objSC.IdTipoInterConsulta,
                                              objSC.IdTipoReferencia,
                                              objSC.Observacion,
                                              1,
                                              objSC.CodigoComponente,
                                              objSC.TipoOrdenAtencion,
                                              objSC.IndicadorEPS,
                                              objSC.Estado,
                                              objSC.UsuarioCreacion,
                                              objSC.FechaCreacion,
                                              objSC.UsuarioModificacion,
                                              objSC.FechaModificacion,
                                              objSC.Accion,
                                              objSC.Version,
                                              objSC.IdPersonalSalud,
                                              objSC.IdDiagnostico,
                                              objSC.ProcedimientoText
                                             , objSC.DiagnosticoText,
                                             objSC.IdProcedimiento,
                                             null,
                                             1,
                                             objSC.IdDiagnostico).SingleOrDefault();

                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                    // D E T A L L E


                                    //Agregado auditoria --> N° 3
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

                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_InterConsulta_FE(), new SS_HC_InterConsulta_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_InterConsulta_FE";
                                        objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                        objAudit.Accion = ObjTrace.Accion;
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                }


                                if (objSC.Accion == "DELETE")  // Eliminar Detalle
                                {
                                    context.Entry(objSC).State = EntityState.Deleted;
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
                                        objAudit = Control.AddAudita(new SS_HC_InterConsulta_FE(), new SS_HC_InterConsulta_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_InterConsulta_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                        valorRetorno = Convert.ToInt32(1);
                                    }
                                    //**
                                }

                                //--
                            }
                            context.SaveChanges();
                            dbContextTransaction.Commit();
                        }
                    }
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
                return valorRetorno;
            }

        }

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_InterConsulta_FE> obPadre, String TablaID)
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
