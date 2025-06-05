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
   public class OftalmologicoFERepository
    {

        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public List<SS_HC_Oftalmologico_FE> OftalmologicoListar(SS_HC_Oftalmologico_FE objSC)
        {
            List<SS_HC_Oftalmologico_FE> objLista = new List<SS_HC_Oftalmologico_FE>();

            using (var context = new ModelFormularios())
            {
                List<SS_HC_Oftalmologico_FE> objConsultas = (from t in context.SS_HC_Oftalmologico_FE
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
                    objAudit = Control.AddAudita(new SS_HC_Oftalmologico_FE(), new SS_HC_Oftalmologico_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_Oftalmologico_FE");
                    objAudit.TableName = "SS_HC_Oftalmologico_FE";
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


        public int setMantenimiento(SS_HC_Oftalmologico_FE objSave)
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

                        if (objSave != null)
                        {
                            int objCount = 0;
                            int valor = 0;
                            if (objSave.Accion == null) objSave.Accion = "X";

                            if ((objSave.Accion.Substring(0, 1) != "I") && (objSave.Accion.Substring(0, 1) != "N"))
                            {

                                //var InformacionObj = (from t in context.SS_HC_NotasIngreso_FE
                                //                      where   t.UnidadReplicacion == objSave.UnidadReplicacion
                                //                      && t.IdPaciente == objSave.IdPaciente
                                //                      && t.EpisodioClinico == objSave.EpisodioClinico
                                //                      && t.IdEpisodioAtencion == objSave.IdEpisodioAtencion
                                //                      orderby t.IdEpisodioAtencion descending
                                //                      select t).SingleOrDefault();
                                objCount = context.SS_HC_Oftalmologico_FE
                                               .Where(t =>
                                                   t.UnidadReplicacion == objSave.UnidadReplicacion
                                                   && t.IdPaciente == objSave.IdPaciente
                                                   && t.EpisodioClinico == objSave.EpisodioClinico
                                                   && t.IdEpisodioAtencion == objSave.IdEpisodioAtencion

                                                )
                                              .DefaultIfEmpty()
                                              .Count();

                                //if (InformacionObj == null) InformacionObj = new SS_HC_DescansoMedico_FE();

                                //iReturnValue = context.SP_NotasIngresos_FE(objSave.UnidadReplicacion, objSave.IdEpisodioAtencion, objSave.IdPaciente,
                                //              objSave.EpisodioClinico, objSave.NotaIngreso,
                                //              objSave.Estado, objSave.UsuarioCreacion, objSave.FechaCreacion, objSave.UsuarioModificacion,
                                //              objSave.FechaModificacion, objSave.Accion, objSave.Version).SingleOrDefault();

                                //valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            }

                            if (objCount > 0)
                            {
                                if (objSave.Accion == "UPDATE")
                                {
                                    objSave.Version = "CCEPF510";
                                    context.Entry(objSave).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSave.Accion == "NUEVO")
                                {

                                    objSave.Version = "CCEPF510";
                                    context.Entry(objSave).State = EntityState.Added;
                                }
                                //InformacionObj = new SS_HC_MiscelaneosPacienteGeneral();
                            }
                            /*******************************/
                            valorRetorno = 1;
                            context.SaveChanges();
                            dbContextTransaction.Commit();
                        }
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



        public virtual String XMLString(List<SS_HC_Oftalmologico_FE> obPadre, String TablaID)
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
