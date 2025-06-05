using Newtonsoft.Json;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.ModelERP_FORM;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class NotaEnfermeriaFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public List<SS_HC_NotasEnfermeria_FE> ReporteNotaEnfermeriaListar(SS_HC_NotasEnfermeria_FE objSC)
        {
            List<SS_HC_NotasEnfermeria_FE> objLista = new List<SS_HC_NotasEnfermeria_FE>();
            using (var context = new ModelFormularios())
            {
                List<SS_HC_NotasEnfermeria_FE> objConsultas = (from t in context.SS_HC_NotasEnfermeria_FE
                                                               where
                                                               t.UnidadReplicacion == objSC.UnidadReplicacion
                                                               && t.IdPaciente == objSC.IdPaciente
                                                               && t.EpisodioClinico == objSC.EpisodioClinico
                                                               //&& t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                               orderby t.IdEpisodioAtencion descending
                                                               select t).ToList();

                if (objConsultas != null)
                {
                    objLista.AddRange(objConsultas);
                }              
                //--
            }
            return objLista;
        }


        public List<SS_HC_NotasEnfermeria_FE> NotaEnfermeriaListar(SS_HC_NotasEnfermeria_FE objSC)
        {
            List<SS_HC_NotasEnfermeria_FE> objLista = new List<SS_HC_NotasEnfermeria_FE>();
            using (var context = new ModelFormularios())
            {
                List<SS_HC_NotasEnfermeria_FE> objConsultas = (from t in context.SS_HC_NotasEnfermeria_FE
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
                    objAudit = Control.AddAudita(new SS_HC_NotasEnfermeria_FE(), new SS_HC_NotasEnfermeria_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_NotasEnfermeria_FE");
                    objAudit.TableName = "SS_HC_NotasEnfermeria_FE";
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


        public int setMantenimiento(SS_HC_NotasEnfermeria_FE objSave)
        {

            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();

            int valorRetorno = 0;

            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {

                        if (objSave != null)
                        {

                            SS_HC_NotasEnfermeria_FE objAnterior = null;
                            if (objSave.Accion == null) objSave.Accion = "X";
                            if ((objSave.Accion.Substring(0, 1) != "I") && (objSave.Accion.Substring(0, 1) != "N"))
                            {
                                objAnterior = (from t in context.SS_HC_NotasEnfermeria_FE
                                               where
                                               t.UnidadReplicacion == objSave.UnidadReplicacion
                                               && t.IdPaciente == objSave.IdPaciente
                                               && t.EpisodioClinico == objSave.EpisodioClinico
                                               && t.IdEpisodioAtencion == objSave.IdEpisodioAtencion
                                               //  && t.IdGinecoobstetricos == objSC.IdGinecoobstetricos
                                               orderby t.IdEpisodioAtencion descending
                                               select t).SingleOrDefault();
                            }
                            /**TRANSACCIÓN*/
                            if (objAnterior != null)
                            {
                                if (objSave.Accion == "UPDATE")
                                {
                                    //objSC.Accion = "CCEPF005";
                                    objSave.Accion = "UPDATE";
                                    context.Entry(objSave).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSave.Accion == "NUEVO")
                                {
                                    //objSC.Accion = "CCEPF005";
                                    objSave.Accion = "NUEVO";
                                    context.Entry(objSave).State = EntityState.Added;
                                }

                            }


                            context.SaveChanges();
                            dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                        }



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





        public virtual String XMLString(List<SS_HC_NotasEnfermeria_FE> obPadre, String TablaID)
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
