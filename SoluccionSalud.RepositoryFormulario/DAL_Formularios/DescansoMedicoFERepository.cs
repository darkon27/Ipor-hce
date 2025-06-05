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
    public class DescansoMedicoFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public int DescansoMedico(SS_HC_DescansoMedico_FE ObjTrace)
        {


            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_DescansoMedico_FE objAnterior = new SS_HC_DescansoMedico_FE();
                        if ((ObjTrace.Accion.Substring(0, 1) != "I") || (ObjTrace.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_DescansoMedico_FE
                                           where t.IdPaciente == ObjTrace.IdPaciente
                                           && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                           && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                           && t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                           orderby t.IdEpisodioAtencion descending
                                           select t).SingleOrDefault();

                        }

                        iReturnValue = context.USP_DescansoMedico_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                        ObjTrace.EpisodioClinico, ObjTrace.FechaInicioDescanso, ObjTrace.FechaFinDescanso, ObjTrace.Observacion,
                        ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                        ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Dias, ObjTrace.fecha, ObjTrace.IdDiagnostico, ObjTrace.IdFormaInicio).SingleOrDefault();
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());




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

        public List<SS_HC_DescansoMedico_FE> DescansoMedicoListar(SS_HC_DescansoMedico_FE ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_DescansoMedico_FE> objLista = new List<SS_HC_DescansoMedico_FE>();

            using (var context = new ModelFormularios())
            {
                objLista = context.USP_DescansoMedicoListar_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.FechaInicioDescanso, ObjTrace.FechaFinDescanso, ObjTrace.Observacion,
                    ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Dias, ObjTrace.IdFormaInicio).ToList();

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
                    objAudit = Control.AddAudita(new SS_HC_DescansoMedico_FE(), new SS_HC_DescansoMedico_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_DescansoMedico_FE");
                    objAudit.TableName = "SS_HC_DescansoMedico_FE";
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

        public int setMantenimiento(SS_HC_DescansoMedico_FE ObjTraces, List<SS_HC_DescansoMedico_FE> Cabecera, List<SS_HC_DescansoMedico_FE> Detalle)
        {

            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();

            SS_HC_DescansoMedico_Diagnostico_FE objDesMedDiag;
            SS_HC_DescansoMedico_Diagnostico_FE InforDetalleObj = new SS_HC_DescansoMedico_Diagnostico_FE();

            InforDetalleObj.SS_HC_DescansoMedico_FE = null;

            System.Nullable<int> iReturnValue;
          
            int valorRetorno = 0;

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (SS_HC_DescansoMedico_FE ObjTrace in Cabecera)
                        {
                            var InformacionObj = (from t in context.SS_HC_DescansoMedico_FE
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  && t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();

                            //if (InformacionObj == null) InformacionObj = new SS_HC_DescansoMedico_FE();

                            iReturnValue = context.USP_DescansoMedico_FE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                          ObjTrace.EpisodioClinico, ObjTrace.FechaInicioDescanso, ObjTrace.FechaFinDescanso, ObjTrace.Observacion,
                                          ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                          ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Dias,
                                          ObjTrace.fecha, ObjTrace.IdDiagnostico, ObjTrace.IdFormaInicio).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            
                            foreach (SS_HC_DescansoMedico_FE ObjTraceDell in Detalle)
                            {

                                var virtualObj = (from t in context.SS_HC_DescansoMedico_Diagnostico_FE
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

                                objDesMedDiag = new SS_HC_DescansoMedico_Diagnostico_FE();
                                objDesMedDiag.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
                                objDesMedDiag.IdPaciente = ObjTraceDell.IdPaciente;
                                objDesMedDiag.EpisodioClinico = ObjTraceDell.EpisodioClinico;
                                objDesMedDiag.IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion;
                                if (ObjTraceDell.IdFormaInicio != null) objDesMedDiag.Secuencia = (int)ObjTraceDell.IdFormaInicio;
                                objDesMedDiag.IdDiagnostico = (int)ObjTraceDell.IdDiagnostico;

                                context.USP_DescansoMedico_FE(ObjTraceDell.UnidadReplicacion, ObjTraceDell.IdEpisodioAtencion, ObjTraceDell.IdPaciente,
                                ObjTraceDell.EpisodioClinico, ObjTraceDell.FechaInicioDescanso, ObjTraceDell.FechaFinDescanso, ObjTraceDell.Observacion,
                                ObjTraceDell.Estado, ObjTraceDell.UsuarioCreacion, ObjTraceDell.FechaCreacion, ObjTraceDell.UsuarioModificacion,
                                ObjTraceDell.FechaModificacion, ObjTraceDell.Accion, ObjTraceDell.Version, ObjTraceDell.Dias,
                                ObjTraceDell.fecha, ObjTraceDell.IdDiagnostico, ObjTraceDell.IdFormaInicio).SingleOrDefault();

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
                                    objAudit = Control.AddAudita(new SS_HC_DescansoMedico_FE(), new SS_HC_DescansoMedico_FE(), DataKey, objAudit.Type);
                                    objAudit.TableName = "SS_HC_DescansoMedico_FE ";
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

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_DescansoMedico_FE> obPadre, String TablaID)
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


