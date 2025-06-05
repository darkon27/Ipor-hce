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
    public class TriajeAlergiasRepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();   //Agregado auditoria --> N° 1

        public int setMantenimiento(SS_HC_Triaje_Ant_Alergia_FE ObjTraces, List<SS_HC_Triaje_Ant_Alergia_FE> Cabecera, List<SS_HC_Triaje_Ant_Alergia_FE> Detalle)
        {     
            SS_HC_Triaje_Ant_AlergiaDetalle_FE objAnamSintoma;
            SS_HC_Triaje_Ant_AlergiaDetalle_FE InforDetalleObj = new SS_HC_Triaje_Ant_AlergiaDetalle_FE();
            InforDetalleObj.SS_HC_Triaje_Ant_Alergia_FE = null;
      
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        // C A B E C E R A
                        foreach (SS_HC_Triaje_Ant_Alergia_FE ObjTrace in Cabecera)
                        {
                            var InformacionObj = (from t in context.SS_HC_Triaje_Ant_Alergia_FE
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioTriaje == ObjTrace.EpisodioTriaje

                                                  orderby t.EpisodioTriaje descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_Triaje_Ant_Alergia_FE();

                            iReturnValue = context.USP_HC_Triaje_Ant_Alergia_FE(ObjTrace.UnidadReplicacion, 
                                          ObjTrace.IdPaciente, ObjTrace.EpisodioTriaje,
                                          ObjTrace.TieneHistoria,ObjTrace.TieneAlimento, ObjTrace.TieneAmbiental, ObjTrace.TieneContacto,
                                          ObjTrace.MedicamentoRegular,ObjTrace.TransfusionSanguinea,ObjTrace.ProblemaTransfusion,ObjTrace.Comentarios,
                                          ObjTrace.IdFormaInicio, ObjTrace.IdCursoEnfermedad,
                                          ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                                          ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                                          ObjTrace.IdMedicamento, ObjTrace.LineaDet,ObjTrace.FamiliaDet,ObjTrace.SubFamiliaDet,
                                          ObjTrace.IdTipoAlergiaDet, ObjTrace.Accion, ObjTrace.DesdeCuandoDet, ObjTrace.EstudioAlegistaDet,
                                           ObjTrace.ObservacionesDet, ObjTrace.Estado, ObjTrace.Version, ObjTrace.TransfusionSanguinea,
                                         ObjTrace.TipoRegistroDet, ObjTrace.DescripcionManualDet).SingleOrDefault();
                                          
                                         
                                          
                                          
                                          
                                         

                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            // D E T A L L E
                            foreach (SS_HC_Triaje_Ant_Alergia_FE ObjTraceDell in Detalle)
                            {
                                if (ObjTraceDell.Accion == "DELETEDETALLE")
                                {
                                    //Agregado auditoria --> Eliminar
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                           
                                            EpisodioClinico = ObjTrace.EpisodioTriaje,
                                            IdPaciente = ObjTrace.IdPaciente
                                        };

                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Triaje_Ant_Alergia_FE(), new SS_HC_Triaje_Ant_Alergia_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Triaje_Ant_Alergia_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //--
                                }
                                var virtualObj = (from t in context.SS_HC_Triaje_Ant_AlergiaDetalle_FE
                                                  where t.IdPaciente == ObjTraceDell.IdPaciente
                                                 && t.EpisodioTriaje == ObjTraceDell.EpisodioTriaje
                                                
                                                 && t.Secuencia == ObjTraceDell.IdFormaInicio
                                                  orderby t.EpisodioTriaje descending
                                                  select t).SingleOrDefault();
                                if (virtualObj != null) InforDetalleObj = virtualObj;

                                // Para la Audotoria
                                objAnamSintoma = new SS_HC_Triaje_Ant_AlergiaDetalle_FE();
                                objAnamSintoma.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
                                objAnamSintoma.IdPaciente = ObjTraceDell.IdPaciente;
                                objAnamSintoma.EpisodioTriaje = ObjTraceDell.EpisodioTriaje;
                                
                                if (ObjTraceDell.IdFormaInicio != null) objAnamSintoma.Secuencia = (int)ObjTraceDell.IdFormaInicio;
                                objAnamSintoma.IdCIAP2 = ObjTraceDell.IdCursoEnfermedad;
                                objAnamSintoma.CodigoComponente = ObjTraceDell.IdMedicamento; // Para la uditoria                                

                                context.USP_HC_Triaje_Ant_Alergia_FE(ObjTraceDell.UnidadReplicacion, 
                                          ObjTraceDell.IdPaciente, ObjTraceDell.EpisodioTriaje,
                                          ObjTraceDell.TieneHistoria, ObjTraceDell.TieneAlimento, ObjTraceDell.TieneAmbiental, ObjTraceDell.TieneContacto,
                                          ObjTraceDell.MedicamentoRegular, ObjTraceDell.TransfusionSanguinea, ObjTraceDell.ProblemaTransfusion, ObjTraceDell.Comentarios,
                                          ObjTraceDell.IdFormaInicio, ObjTraceDell.IdCursoEnfermedad,
                                          ObjTraceDell.Estado, ObjTraceDell.UsuarioCreacion,
                                          ObjTraceDell.FechaCreacion, ObjTraceDell.UsuarioModificacion, ObjTraceDell.FechaModificacion,
                                          ObjTraceDell.IdMedicamento, ObjTraceDell.LineaDet, ObjTraceDell.FamiliaDet, ObjTraceDell.SubFamiliaDet,
                                          ObjTraceDell.IdTipoAlergiaDet, ObjTraceDell.Accion, ObjTraceDell.DesdeCuandoDet, ObjTraceDell.EstudioAlegistaDet,
                                           ObjTraceDell.ObservacionesDet, ObjTraceDell.Estado, ObjTraceDell.Version, ObjTraceDell.TransfusionSanguinea,
                                         ObjTraceDell.TipoRegistroDet, ObjTraceDell.DescripcionManualDet).SingleOrDefault();                      
                            
                            }
                            //valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            //Agregado auditoria --> N° 3
                            using (var contextEnty = new WEB_ERPSALUDEntities())
                            {
                                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                dynamic DataKey;
                                DataKey = new
                                {
                                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                    
                                    EpisodioClinico = ObjTrace.EpisodioTriaje,
                                    IdPaciente = ObjTrace.IdPaciente
                                };

                                string tempType = objAudit.Type;
                                objAudit = Control.AddAudita(new SS_HC_Triaje_Ant_Alergia_FE(), new SS_HC_Triaje_Ant_Alergia_FE(), DataKey, objAudit.Type);
                                objAudit.TableName = "SS_HC_Triaje_Ant_Alergia_FE";
                                objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                objAudit.Accion = ObjTrace.Accion;
                                contextEnty.Entry(objAudit).State = EntityState.Added;
                                contextEnty.SaveChanges();
                            }
                            //--
                        }
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

       

        public List<SS_HC_Triaje_Ant_Alergia_FE> TriajeAlergia_Listar(SS_HC_Triaje_Ant_Alergia_FE ObjTrace)
        {
            try
            {
                List<SS_HC_Triaje_Ant_Alergia_FE> objLista = new List<SS_HC_Triaje_Ant_Alergia_FE>();
                using (var context = new ModelFormularios())
                {
                               objLista =  context.USP_HC_Triaje_Ant_Alergia_FE_Listar(ObjTrace.UnidadReplicacion,
                                          ObjTrace.IdPaciente, ObjTrace.EpisodioTriaje,  
                                          ObjTrace.IdFormaInicio, ObjTrace.IdCursoEnfermedad,                              
                                          ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                                          ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion,
                                          ObjTrace.Version, ObjTrace.TieneHistoria, ObjTrace.TieneAlimento, ObjTrace.TieneAmbiental, ObjTrace.TieneContacto,
                                          ObjTrace.MedicamentoRegular,ObjTrace.TransfusionSanguinea,ObjTrace.ProblemaTransfusion,ObjTrace.Comentarios,
                                          ObjTrace.IdMedicamento, ObjTrace.IdTipoAlergiaDet,  
                                          ObjTrace.LineaDet, ObjTrace.FamiliaDet, ObjTrace.SubFamiliaDet,
                                          ObjTrace.DesdeCuandoDet, ObjTrace.ObservacionesDet,
                                          ObjTrace.EstudioAlegistaDet, ObjTrace.TipoRegistroDet, ObjTrace.DescripcionManualDet).ToList();
                    
                    //Agregado auditoria --> N° 2
                    using (var contextEnty = new WEB_ERPSALUDEntities())
                    {
                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                        dynamic DataKey;
                        DataKey = new
                        {
                            UnidadReplicacion = ObjTrace.UnidadReplicacion,
                            
                            EpisodioClinico = ObjTrace.EpisodioTriaje,
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
                        objAudit = Control.AddAudita(new SS_HC_Triaje_Ant_Alergia_FE(), new SS_HC_Triaje_Ant_Alergia_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_Triaje_Ant_Alergia_FE");
                        objAudit.TableName = "SS_HC_Triaje_Ant_Alergia_FE";
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

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Triaje_Ant_Alergia_FE> obPadre, String TablaID)
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
