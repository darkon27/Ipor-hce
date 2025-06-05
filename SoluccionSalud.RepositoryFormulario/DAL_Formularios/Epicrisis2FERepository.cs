using Newtonsoft.Json;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.ModelERP_FORM;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class Epicrisis2FERepository
    {

        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public int setMantenimiento(SS_HC_Epicrisis_2_FE objSC, List<SS_HC_Epicrisis_2_Detalle_FE> detalle0)
        {
            int valorRetorno = -1; //ERROR
           // int Id = objSC.IdEpicr;
            SS_HC_Epicrisis_2_FE obj_epicrisis = new SS_HC_Epicrisis_2_FE();
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                        #region cabecera


                        if (objSC != null)
                        {
                            int objCountCab = 0;



                            if (objCountCab == 0)
                            {

                                if (objSC.Accion == "UPDATE")
                                {



                                    context.Entry(objSC).State = EntityState.Modified;
                                }


                            }
                            //else
                            //{
                                if (objSC.Accion == "NUEVO")
                                {
                                    //if (objSC.IdEpicrisis3 == 0)
                                    //{
                                    //    Id = context.SS_HC_Epicrisis_3
                                    //          .DefaultIfEmpty().Max(t => t == null ? 0 : t.IdEpicrisis3) + 1;

                                    //    objSC.IdEpicrisis3 = Id;
                                    //}

                                    context.USP_SS_HC_Epicrisis_2_FE(objSC.UnidadReplicacion, Convert.ToInt32(objSC.IdEpisodioAtencion), objSC.IdPaciente, objSC.EpisodioClinico,
                                       objSC.Complicaciones, objSC.Pronostico, objSC.TipoAlta, objSC.CondicionEgreso, objSC.CausaMuerte,
                                        objSC.PlanAlta, objSC.Necropsia, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                                        objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version);
                                }
                            //}

                            obj_epicrisis = objSC;
                            context.SaveChanges();


                        }


                        #endregion

                        #region detalle0

                        if (detalle0 != null)
                        {

                            int contadorDet1 = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax1 = context.SS_HC_InformeAlta_Diagnostico_FE
                                    .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_Epicrisis_2_Detalle_FE objDet = null;
                            foreach (SS_HC_Epicrisis_2_Detalle_FE objDetalle0 in detalle0)
                            {
                                objDet = new SS_HC_Epicrisis_2_Detalle_FE();
                                Nullable<int> secuenciaAux = objDetalle0.Secuencia;
                                objDet.IdPaciente = objDetalle0.IdPaciente;
                                objDet.EpisodioClinico = objDetalle0.EpisodioClinico;
                                objDet.UnidadReplicacion = objDetalle0.UnidadReplicacion;
                                objDet.IdEpisodioAtencion = objDetalle0.IdEpisodioAtencion;
                                objDet.Codigo = objDetalle0.Codigo;
                                objDet.DiagnosticoDescripcion = objDetalle0.DiagnosticoDescripcion;
                                objDet.FechaCreacion = DateTime.Now;
                                objDet.Accion = objDetalle0.Accion;
                                //objDet.IdEpicrisis2 = Id;
                                objDet.Secuencia = Convert.ToInt32(objDetalle0.Secuencia);
                               // objDet.SS_HC_Epicrisis_3 = obj_epicrisis;
                                if (objDet.Accion == "DETALLE") // Insertar Detalle
                                {
                                    contadorDet1++;
                                    objDet.Secuencia = secuenciaMax1 + contadorDet1;
                                    objDet.Accion = "NUEVO";
                                    try
                                    {
                                        //context.USP_SS_HC_Epicrisis_2_FE(objDet.UnidadReplicacion, Convert.ToInt32(objDet.IdEpisodioAtencion), objDet.IdPaciente, objDet.EpisodioClinico,
                                        //    objDet.Secuencia, objDet.IdEpicrisis2, objDet.DiagnosticoDescripcion, objDet.Codigo, 1, objDet.UsuarioCreacion, objDet.FechaCreacion,
                                        //    objDet.UsuarioModificacion, objDet.FechaModificacion, objDet.Accion, objDet.Version);
                                        //context.SaveChanges();
                                    }
                                    catch { 
                                    
                                    }
                                }
                                else if (objDet.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    SS_HC_Epicrisis_2_Detalle_FE objAnterior = null;
                                    //context.USP_SS_HC_Epicrisis_2_FE(objDet.UnidadReplicacion, Convert.ToInt32(objDet.IdEpisodioAtencion), objDet.IdPaciente, objDet.EpisodioClinico,
                                    //    objDet.Secuencia, objDet.IdEpicrisis2, objDet.DiagnosticoDescripcion, objDet.Codigo, 1, objDet.UsuarioCreacion, objDet.FechaCreacion,
                                    //    objDet.UsuarioModificacion, objDet.FechaModificacion, objDet.Accion, objDet.Version);
                                    //context.SaveChanges();
                                }
                                else if (objDet.Accion == "DELETE")  // Eliminar Detalle
                                {
                                    //context.USP_SS_HC_Epicrisis_2_FE(objDet.UnidadReplicacion, Convert.ToInt32(objDet.IdEpisodioAtencion), objDet.IdPaciente, objDet.EpisodioClinico,
                                    //    objDet.Secuencia, objDet.IdEpicrisis2, objDet.DiagnosticoDescripcion, objDet.Codigo, 1, objDet.UsuarioCreacion, objDet.FechaCreacion,
                                    //    objDet.UsuarioModificacion, objDet.FechaModificacion, objDet.Accion, objDet.Version);
                                    //context.SaveChanges();
                                    //** Agregado auditoria --> Eliminar
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
                                            IdPaciente = objSC.IdPaciente
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Epicrisis_2_Detalle_FE(), new SS_HC_Epicrisis_2_Detalle_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Epicrisis_2_Detalle_FE";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }
                            }
                        }

                        #endregion

                        //context.SaveChanges();
                        dbContextTransaction.Commit();
                        valorRetorno = 1;

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


        public List<SS_HC_Epicrisis_2_FE> Lista_Cabecera(SS_HC_Epicrisis_2_FE ObjSC)
        {

            List<SS_HC_Epicrisis_2_FE> objCabecera = null;
            using (var context = new ModelFormularios())
            {

                objCabecera = context.SS_HC_Epicrisis_2_FE.Where(
                                                        t => t.EpisodioClinico == ObjSC.EpisodioClinico
                                                            && t.UnidadReplicacion == ObjSC.UnidadReplicacion
                                                            && t.IdPaciente == ObjSC.IdPaciente
                                                            && t.IdEpisodioAtencion == ObjSC.IdEpisodioAtencion
                    //&& t.IdEpicrisis3 == ObjSC.IdEpicrisis3
                                                               ).ToList();

            }

            //Agregado auditoria --> N° 2
            using (var contextEnty = new WEB_ERPSALUDEntities())
            {
                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                dynamic DataKey;
                DataKey = new
                {
                    UnidadReplicacion = ObjSC.UnidadReplicacion,
                    IdEpisodioAtencion = ObjSC.IdEpisodioAtencion,
                    EpisodioClinico = ObjSC.EpisodioClinico,
                    IdPaciente = ObjSC.IdPaciente,
                };

                if (objCabecera.Count > 1)
                {
                    objAudit.Type = "L";
                }
                else
                {
                    objAudit.Type = "V";
                }

                string tempType = objAudit.Type;
                objAudit = Control.AddAudita(new SS_HC_Epicrisis_2_FE(), new SS_HC_Epicrisis_2_FE(), DataKey, objAudit.Type);
                String xlmIn = XMLString(objCabecera, "SS_HC_Epicrisis_2_FE");
                objAudit.TableName = "SS_HC_Epicrisis_2_FE";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                objAudit.Accion = ObjSC.Accion;
                contextEnty.Entry(objAudit).State = EntityState.Added;
                contextEnty.SaveChanges();
            }
            //--
            return objCabecera;
        }



        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Epicrisis_2_FE> obPadre, String TablaID)
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
