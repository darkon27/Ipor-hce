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
    public class EvolucionObjetivaFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public List<SS_HC_EvolucionMedica_FE> listarSS_HC_EvolucionObjetiva(
                    SS_HC_EvolucionMedica_FE objSC)
        {

            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();

            List<SS_HC_EvolucionMedica_FE> objLista = new List<SS_HC_EvolucionMedica_FE>();
            using (var context = new ModelFormularios())
            {

                List<SS_HC_EvolucionMedica_FE> objConsultas = (from t in context.SS_HC_EvolucionMedica_FE
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

                /*
                DataKey = new
                {
                    UnidadReplicacion = objSC.UnidadReplicacion,
                    IdPaciente = objSC.IdPaciente,
                    EpisodioClinico = objSC.EpisodioClinico,
                    IdEpisodioAtencion = objSC.IdEpisodioAtencion
                };
                */

                /*
                String accionTemp = "V";
                if (objLista.Count > 1) accionTemp = "L";

                String xlmIn = XMLString(objLista, new List<SS_HC_EvolucionObjetiva>(), "SS_HC_EvolucionObjetiva");
                setAuditoriaListado(new SS_HC_EvolucionObjetiva(), new SS_HC_EvolucionObjetiva(), accionTemp,
                    "SS_HC_EvolucionObjetiva", objAudit, DataKey, xlmIn);
                */

                //Agregado auditoria --> N° 2
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
                        Secuencia = objSC.CodigoSecuencia
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
                    objAudit = Control.AddAudita(new SS_HC_EvolucionMedica_FE(), new SS_HC_EvolucionMedica_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_EvolucionMedica_FE");
                    objAudit.TableName = "SS_HC_EvolucionMedica_FE";
                    objAudit.Type = tempType;
                    objAudit.VistaData = xlmIn;
                    objAudit.Accion = objSC.Accion;
                    contextEnty.Entry(objAudit).State = EntityState.Added;
                    contextEnty.SaveChanges();
                }
                //--

            }
            return objLista;
        }
        public int setMantenimiento(SS_HC_EvolucionMedica_FE objSC)
        {
            dynamic DataKey;
            int valorRetorno = 0; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (objSC != null)
                        {
                            SS_HC_EvolucionMedica_FE objAnterior = null;
                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objAnterior = (from t in context.SS_HC_EvolucionMedica_FE
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
                                    //objSC.Accion = objSC.Version;
                                    //objSC.EvolucionObjetiva = objSC.EvolucionObjetiva.Substring(1,500);
                                    context.Entry(objSC).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {                   
                                   //objSC.EvolucionObjetiva = objSC.EvolucionObjetiva.Substring(0, 499);
                                    context.Entry(objSC).State = EntityState.Added;
                                }                             
                            }
                        
                            /***TERMINA AUDITORÍA *****/
                            context.SaveChanges();
                            dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                            valorRetorno = -1;
                        }

                        //** Agregado auditoria --> N° 3
                        using (var contextEnty = new WEB_ERPSALUDEntities())
                        {
                            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                            List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                            //dynamic DataKey;
                            DataKey = new
                            {
                                UnidadReplicacion = objSC.UnidadReplicacion,
                                IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                EpisodioClinico = objSC.EpisodioClinico,
                                IdPaciente = objSC.IdPaciente
                            };
                            string tempType = objAudit.Type;
                            objAudit = Control.AddAudita(new SS_HC_EvolucionMedica_FE(), new SS_HC_EvolucionMedica_FE(), DataKey, objAudit.Type);
                            objAudit.TableName = "SS_HC_EvolucionMedica_FE ";
                            objAudit.Type = objSC.Accion.Substring(0, 1);
                            objAudit.Accion = objSC.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //**

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
        public virtual String XMLString(List<SS_HC_EvolucionMedica_FE> obPadre, String TablaID)
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
