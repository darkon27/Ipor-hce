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
    public class DiagnosticoFERepository
    {

        public List<SS_HC_Diagnostico_FE> DiagnosticoListar(SS_HC_Diagnostico_FE ObjTrace)
        {
            Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();
            List<SS_HC_Diagnostico_FE> objLista = new List<SS_HC_Diagnostico_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.USP_DiagnosticoListar_FE(
                    ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.FechaRegistro,
                    ObjTrace.IdDiagnostico, ObjTrace.IdDiagnosticoValoracion, ObjTrace.DeterminacionDiagnostica,
                    ObjTrace.IdDiagnosticoPrincipal, ObjTrace.GradoAfeccion, ObjTrace.Observacion,
                    ObjTrace.IndicadorAntecedente, ObjTrace.TipoAntecedente, ObjTrace.IndicadorPreExistencia,
                    ObjTrace.IndicadorCronico, ObjTrace.IndicadorNuevo, ObjTrace.DetalleDiagnostico,
                    ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                    ).ToList();

                //using (var contextEnty = new WEB_ERPSALUDEntities())
                //{
                //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                //    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                //    dynamic DataKey;
                //    DataKey = new
                //    {
                //        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                //        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                //        EpisodioClinico = ObjTrace.EpisodioClinico,
                //        IdPaciente = ObjTrace.IdPaciente,
                //        Secuencia = ObjTrace.Secuencia
                //    };

                //    if (objLista.Count > 1)
                //    {
                //        objAudit.Type = "L";
                //    }
                //    else
                //    {
                //        objAudit.Type = "V";
                //    }

                //    string tempType = objAudit.Type;
                //    objAudit = Control.AddAudita(new SS_HC_Diagnostico_FE(), new SS_HC_Diagnostico_FE(), DataKey, objAudit.Type);
                //    String xlmIn = XMLString(objLista, "SS_HC_Diagnostico_FE");
                //    objAudit.TableName = "SS_HC_Diagnostico_FE";
                //    objAudit.Type = tempType;
                //    objAudit.VistaData = xlmIn;
                //    objAudit.Accion = ObjTrace.Accion;
                //    contextEnty.Entry(objAudit).State = EntityState.Added;
                //    contextEnty.SaveChanges();
                //}
            }
            return objLista;

        }

        public int setMantenimiento(SS_HC_Diagnostico_FE ObjTraces, List<SS_HC_Diagnostico_FE> listaCabecera, List<SS_HC_Diagnostico_FE> Detalle)
        {
            Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();
            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                        /*********GUARDAR DETALLE***************/
                        if (Detalle != null)
                        {
                            Nullable<int> iReturnValue;
                            foreach (SS_HC_Diagnostico_FE objDetalle in Detalle)
                            {
                                if (objDetalle.Accion == "NUEVO") // Insertar Detalle
                                {
                                    var Valor = context.SS_HC_Diagnostico_FE
                                          .Where(t =>
                                                  t.IdPaciente == objDetalle.IdPaciente
                                                  && t.UnidadReplicacion == objDetalle.UnidadReplicacion
                                                  && t.EpisodioClinico == objDetalle.EpisodioClinico
                                                  && t.IdEpisodioAtencion == objDetalle.IdEpisodioAtencion
                                                  && t.IdDiagnostico == objDetalle.IdDiagnostico
                                          ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                                    if (Valor == 0)
                                    {
                                        iReturnValue = context.USP_Diagnostico_FE(
                                       objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion,
                                       objDetalle.IdPaciente, objDetalle.EpisodioClinico, objDetalle.Secuencia, objDetalle.FechaRegistro,
                                       objDetalle.IdDiagnostico, objDetalle.IdDiagnosticoValoracion, objDetalle.DeterminacionDiagnostica,
                                       objDetalle.IdDiagnosticoPrincipal, objDetalle.GradoAfeccion, objDetalle.Observacion,
                                       objDetalle.IndicadorAntecedente, objDetalle.TipoAntecedente, objDetalle.IndicadorPreExistencia,
                                       objDetalle.IndicadorCronico, objDetalle.IndicadorNuevo, objDetalle.DetalleDiagnostico,
                                       objDetalle.Estado, objDetalle.UsuarioCreacion, objDetalle.FechaCreacion,
                                       objDetalle.UsuarioModificacion, objDetalle.FechaModificacion,
                                       objDetalle.Accion, objDetalle.Version).SingleOrDefault();
                                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                    }

                                    #region AuditoriaNuevo 
                                    //Le paso en duro porque aveces no captura la acción verdadera.
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objDetalle.UnidadReplicacion,
                                            IdEpisodioAtencion = objDetalle.IdEpisodioAtencion,
                                            EpisodioClinico = objDetalle.EpisodioClinico,
                                            IdPaciente = objDetalle.IdPaciente,
                                            Secuencia = objDetalle.Secuencia
                                        };

                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Diagnostico_FE(), new SS_HC_Diagnostico_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Diagnostico_FE";
                                        objAudit.Type = "N";
                                        objAudit.Accion = "NUEVO";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    #endregion
                                }
                                else if (objDetalle.Accion == "DELETE")
                                {
                                    #region AuditoriaDelete
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objDetalle.UnidadReplicacion,
                                            IdEpisodioAtencion = objDetalle.IdEpisodioAtencion,
                                            EpisodioClinico = objDetalle.EpisodioClinico,
                                            IdPaciente = objDetalle.IdPaciente,
                                            Secuencia = objDetalle.Secuencia
                                        };

                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Diagnostico_FE(), new SS_HC_Diagnostico_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Diagnostico_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    #endregion

                                    iReturnValue = context.USP_Diagnostico_FE(
                                         objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion,
                                         objDetalle.IdPaciente, objDetalle.EpisodioClinico, objDetalle.Secuencia, objDetalle.FechaRegistro,
                                         objDetalle.IdDiagnostico, objDetalle.IdDiagnosticoValoracion, objDetalle.DeterminacionDiagnostica,
                                         objDetalle.IdDiagnosticoPrincipal, objDetalle.GradoAfeccion, objDetalle.Observacion,
                                         objDetalle.IndicadorAntecedente, objDetalle.TipoAntecedente, objDetalle.IndicadorPreExistencia,
                                         objDetalle.IndicadorCronico, objDetalle.IndicadorNuevo, objDetalle.DetalleDiagnostico,
                                         objDetalle.Estado, objDetalle.UsuarioCreacion, objDetalle.FechaCreacion,
                                         objDetalle.UsuarioModificacion, objDetalle.FechaModificacion,
                                         objDetalle.Accion, objDetalle.Version).SingleOrDefault();
                                    valorRetorno = objDetalle.Secuencia;

                                }

                                else if (objDetalle.Accion == "UPDATE")
                                {
                                    iReturnValue = context.USP_Diagnostico_FE(
                                         objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion,
                                         objDetalle.IdPaciente, objDetalle.EpisodioClinico, objDetalle.Secuencia, objDetalle.FechaRegistro,
                                         objDetalle.IdDiagnostico, objDetalle.IdDiagnosticoValoracion, objDetalle.DeterminacionDiagnostica,
                                         objDetalle.IdDiagnosticoPrincipal, objDetalle.GradoAfeccion, objDetalle.Observacion,
                                         objDetalle.IndicadorAntecedente, objDetalle.TipoAntecedente, objDetalle.IndicadorPreExistencia,
                                         objDetalle.IndicadorCronico, objDetalle.IndicadorNuevo, objDetalle.DetalleDiagnostico,
                                         objDetalle.Estado, objDetalle.UsuarioCreacion, objDetalle.FechaCreacion,
                                         objDetalle.UsuarioModificacion, objDetalle.FechaModificacion,
                                         objDetalle.Accion, objDetalle.Version).SingleOrDefault();
                                    valorRetorno = objDetalle.Secuencia;
                                    #region AuditoriaUpdate
                                    using (var contextEnty = new WEB_ERPSALUDEntities())
                                    {
                                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                                        dynamic DataKey;
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objDetalle.UnidadReplicacion,
                                            IdEpisodioAtencion = objDetalle.IdEpisodioAtencion,
                                            EpisodioClinico = objDetalle.EpisodioClinico,
                                            IdPaciente = objDetalle.IdPaciente,
                                            Secuencia = objDetalle.Secuencia
                                        };

                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Diagnostico_FE(), new SS_HC_Diagnostico_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Diagnostico_FE";
                                        objAudit.Type = objDetalle.Accion.Substring(0, 1);
                                        objAudit.Accion = objDetalle.Accion;
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    #endregion
                                }

                            }
                        }

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

        public SS_HC_Diagnostico_FE obtenerPorId(SS_HC_Diagnostico_FE objSC)
        {
            SS_HC_Diagnostico_FE objResult = null;
            try
            {
                using (var context = new ModelFormularios())
                {
                    SS_HC_Diagnostico_FE objConsulta = (from t in context.SS_HC_Diagnostico_FE
                                                        where
                                                        t.UnidadReplicacion == objSC.UnidadReplicacion
                                                        && t.IdPaciente == objSC.IdPaciente
                                                        && t.EpisodioClinico == objSC.EpisodioClinico
                                                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                        && t.Secuencia == objSC.Secuencia
                                                        orderby t.Secuencia descending
                                                        select t).SingleOrDefault();

                    if (objConsulta != null)
                    {
                        objResult = objConsulta;
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return objResult;
        }


         
        public SS_HC_Epicrisis_3_Diagnostico obtenerPorIdALTA(SS_HC_Epicrisis_3_Diagnostico objSC)
        {
            SS_HC_Epicrisis_3_Diagnostico objResult = null;
            try
            {
                using (var context = new ModelFormularios())
                {
                    SS_HC_Epicrisis_3_Diagnostico objConsulta = (from t in context.SS_HC_Epicrisis_3_Diagnostico
                                                                 where
                                                                 t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                 && t.IdPaciente == objSC.IdPaciente
                                                                 && t.EpisodioClinico == objSC.EpisodioClinico
                                                                 && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                 && t.Secuencia == objSC.Secuencia
                                                                 orderby t.Secuencia descending
                                                                 select t).SingleOrDefault();

                    if (objConsulta != null)
                    {
                        objResult = objConsulta;
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return objResult;
        }



        public SS_HC_Epicrisis_3_Diag_Principal obtenerPorIdALTAEXAMEN(SS_HC_Epicrisis_3_Diag_Principal objSC)
        {
            SS_HC_Epicrisis_3_Diag_Principal objResult = null;
            try
            {
                using (var context = new ModelFormularios())
                {
                    SS_HC_Epicrisis_3_Diag_Principal objConsulta = (from t in context.SS_HC_Epicrisis_3_Diag_Principal
                                                                    where
                                                                    t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                    && t.IdPaciente == objSC.IdPaciente
                                                                    && t.EpisodioClinico == objSC.EpisodioClinico
                                                                    && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                    && t.IdEpicrisis3 == 10
                                                                    && t.Secuencia == objSC.Secuencia
                                                                    orderby t.Secuencia descending
                                                                    select t).SingleOrDefault();

                    if (objConsulta != null)
                    {
                        objResult = objConsulta;
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return objResult;
        }




        public virtual String XMLString(List<SS_HC_Diagnostico_FE> obPadre, String TablaID)
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
