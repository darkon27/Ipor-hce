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
    public class NotaIngresoFERepository
    {

        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1


        public List<SS_HC_Nota_Ingreso_FE> Lista_Cabecera(SS_HC_Nota_Ingreso_FE ObjSC)
        {

            try
            {
                List<SS_HC_Nota_Ingreso_FE> objLista = new List<SS_HC_Nota_Ingreso_FE>();
                using (var context = new ModelFormularios())
                {
                    objLista = context.USP_HC_Nota_Ingreso_FE(ObjSC.UnidadReplicacion,ObjSC.IdEpisodioAtencion,ObjSC.IdPaciente,ObjSC.EpisodioClinico,
                        ObjSC.Fecha,ObjSC.Hora,ObjSC.GradoAsistencia,ObjSC.MotivoIngreso,ObjSC.GradoAsistencia_Enfermedad,ObjSC.CursoEnfermedad, ObjSC.TiempoEnfermedad,
                        ObjSC.TiempoEnfermedadUnidad,ObjSC.RelatoCronologico,ObjSC.PresionArterialMSD1,ObjSC.PresionArterialMSD2,ObjSC.PresionArterialMSI,
                        ObjSC.PresionArterialMS2,ObjSC.FrecuenciaCardiaca,ObjSC.FrecuenciaRespiratoria,ObjSC.Temperatura,ObjSC.SaturacionOxigeno,
                        ObjSC.Fi02,ObjSC.FrecuenciaCardFetal_Flag,ObjSC.FrecuenciaCard_FetalAdd,ObjSC.Peso,ObjSC.Talla,ObjSC.IMC,ObjSC.Antecedentes_Importancia,
                        ObjSC.Examen_Fisico,ObjSC.Plantrabajo_Inicial,ObjSC.Cristerios_Hospitalizacion,ObjSC.Comentarios,ObjSC.Accion,ObjSC.Version,
                        ObjSC.Estado, ObjSC.UsuarioCreacion, ObjSC.FechaCreacion, ObjSC.UsuarioModificacion, ObjSC.FechaModificacion).ToList();

                    //Agregado auditoria --> N° 2
                    using (var contextEnty = new WEB_ERPSALUDEntities())
                    {
                        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                        dynamic DataKey;
                        DataKey = new
                        {
                            //UnidadReplicacion = objSC.IdEpisodioAtencion,
                            //IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                            //EpisodioClinico = objSC.EpisodioClinico,
                            //IdPaciente = objSC.IdPaciente
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
                        objAudit = Control.AddAudita(new SS_HC_Nota_Ingreso_FE(), new SS_HC_Nota_Ingreso_FE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_Nota_Ingreso_FE");
                        objAudit.TableName = "SS_HC_Nota_Ingreso_FE";
                        objAudit.Type = tempType;
                        objAudit.VistaData = xlmIn;
                        //objAudit.Accion = objSC.Accion;
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



        public int setMantenimiento(SS_HC_Nota_Ingreso_FE objSC, List<SS_HC_NotaIngreso_ExamenApoyo_FE> detalle0, List<SS_HC_NotaIngreso_Diagnostico_FE> detalle2)
        {
            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    SS_HC_NotaIngreso_Diagnostico_FE objDesMedDiag;
                    SS_HC_DescansoMedico_Diagnostico_FE InforDetalleObj = new SS_HC_DescansoMedico_Diagnostico_FE();
                    InforDetalleObj.SS_HC_DescansoMedico_FE = null;
                    try
                    {

                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                        #region Cabecerra

                        if (objSC != null)
                        {
                            int objCountCab = 0;
                            //SS_HC_ExamenSolicitadoFE objAnterior = null;
                            if (objSC.Accion == null) objSC.Accion = "X";

                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                //objAnterior = (from t in context.SS_HC_ExamenSolicitadoFE
                                //               where
                                //               t.UnidadReplicacion == objSC.UnidadReplicacion
                                //               && t.IdPaciente == objSC.IdPaciente
                                //               && t.EpisodioClinico == objSC.EpisodioClinico
                                //               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                //               orderby t.IdEpisodioAtencion descending
                                //               select t).SingleOrDefault();


                                objCountCab = context.SS_HC_Nota_Ingreso_FE
                                  .Where(t =>
                                        t.IdPaciente == objSC.IdPaciente
                                        && t.UnidadReplicacion == objSC.UnidadReplicacion
                                        && t.EpisodioClinico == objSC.EpisodioClinico
                                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    ).Count();
                                // .DefaultIfEmpty()

                            }
                            /**TRANSACCIÓN*/
                            //if (objAnterior != null)
                            if (objCountCab > 0)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    //objAnterior.Resumen = objSC.Resumen;
                                    //objAnterior.Motivo = objSC.Motivo;
                                    //objAnterior.Accion = objSC.Accion;
                                    //context.Entry(objAnterior).State = EntityState.Modified;

                                    //objSC.UsuarioCreacion = objSC.UsuarioCreacion;
                                    //objSC.FechaCreacion = objSC.FechaCreacion;
                                    //objSC.Resumen = objSC.Resumen;
                                    //objSC.Motivo = objSC.Motivo;
                                    //objSC.Accion = objSC.Accion;
                                   // context.Entry(objSC).State = EntityState.Modified;
                                    Nullable<int> iReturnValue;

                                    objSC.Accion = "UPDATE";
                                    iReturnValue = context.USP_HC_Nota_Ingreso_FE_Insert(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion, objSC.IdPaciente,
                                        objSC.EpisodioClinico, objSC.Fecha, objSC.Hora, objSC.GradoAsistencia,
                                         objSC.MotivoIngreso, objSC.GradoAsistencia_Enfermedad, objSC.CursoEnfermedad, objSC.TiempoEnfermedad, objSC.TiempoEnfermedadUnidad, objSC.RelatoCronologico,
                                         objSC.PresionArterialMSD1, objSC.PresionArterialMSD2, objSC.PresionArterialMSI, objSC.PresionArterialMS2, objSC.FrecuenciaCardiaca, objSC.FrecuenciaRespiratoria,
                                         objSC.Temperatura, objSC.SaturacionOxigeno, objSC.Fi02, objSC.FrecuenciaCardFetal_Flag, objSC.FrecuenciaCard_FetalAdd, objSC.Peso,
                                         objSC.Talla, objSC.IMC, objSC.Antecedentes_Importancia, objSC.Examen_Fisico, objSC.Plantrabajo_Inicial, objSC.Cristerios_Hospitalizacion,
                                         objSC.Comentarios, objSC.Accion, objSC.Version, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                                         objSC.FechaModificacion).SingleOrDefault();

                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                }
                            }
                            else
                            {
                                //   if (objSC.Accion == "NUEVO")
                                // {
                                //objSC.Accion = objSC.Version;
                                //     context.Entry(objSC).State = EntityState.Added;
                                // }
                                Nullable<int> iReturnValue;

                                objSC.Accion = "INSERT";
                                if (objSC.Accion == "INSERT")
                                {
                                    iReturnValue = context.USP_HC_Nota_Ingreso_FE_Insert(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion, objSC.IdPaciente,
                                        objSC.EpisodioClinico, Convert.ToDateTime(objSC.Fecha), Convert.ToDateTime(objSC.Hora), objSC.GradoAsistencia,
                                         objSC.MotivoIngreso, objSC.GradoAsistencia_Enfermedad, objSC.CursoEnfermedad, objSC.TiempoEnfermedad, objSC.TiempoEnfermedadUnidad, objSC.RelatoCronologico,
                                         objSC.PresionArterialMSD1,objSC.PresionArterialMSD2,objSC.PresionArterialMSI,objSC.PresionArterialMS2,objSC.FrecuenciaCardiaca,objSC.FrecuenciaRespiratoria,
                                         objSC.Temperatura,objSC.SaturacionOxigeno,objSC.Fi02,objSC.FrecuenciaCardFetal_Flag,objSC.FrecuenciaCard_FetalAdd,objSC.Peso,
                                         objSC.Talla,objSC.IMC,objSC.Antecedentes_Importancia,objSC.Examen_Fisico,objSC.Plantrabajo_Inicial,objSC.Cristerios_Hospitalizacion,
                                         objSC.Comentarios,objSC.Accion,objSC.Version,objSC.Estado,objSC.UsuarioCreacion,objSC.FechaCreacion,objSC.UsuarioModificacion,
                                         objSC.FechaModificacion).SingleOrDefault();

                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                }
                                //context.Entry(objSC).State = EntityState.Added;
                            }
                            //context.SaveChanges();
                            //dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                            //valorRetorno = -1;
                        }

                        #endregion

                        /*********GUARDAR DETALLE***************/
                        #region Detalle

                        if (detalle0 != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/

                            SS_HC_NotaIngreso_ExamenApoyo_FE objDet = new SS_HC_NotaIngreso_ExamenApoyo_FE();
                            Nullable<int> iReturnValue;
                            foreach (SS_HC_NotaIngreso_ExamenApoyo_FE objDetalle in detalle0)
                            {

                                if (objDetalle.Accion.Trim() != "INSERTADO")
                                {
                                    context.USp_HC_NotaIngreso_ExamenApoyo_FE_Insertar(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente,
                                    objDetalle.EpisodioClinico, Convert.ToInt32(objDetalle.Secuencia), objDetalle.CodigoSegus, objDetalle.TipoOrdenAtencion,
                                      objDetalle.IndicadorEPS, objDetalle.CodigoComponente, objDetalle.ExamenDescripcion, objDetalle.UsuarioCreacion,
                                     objDetalle.FechaCreacion, objDetalle.UsuarioModificacion, objDetalle.FechaModificacion, objDetalle.Accion, objDetalle.Version).SingleOrDefault();

                                }
                                else if (objDetalle.Accion.Trim() == "INSERTADO")
                                {

                                    var CheckPresseDelete = ENTITY_GLOBAL.Instance.CheckPresseDelete;

                              //      if (CheckPresseDelete)
                              //      {
                              //          var lstDiag = context.SS_HC_NotaIngreso_ExamenApoyo_FE
                              //.Where(t =>
                              //      t.IdPaciente == objSC.IdPaciente
                              //      && t.UnidadReplicacion == objSC.UnidadReplicacion
                              //      && t.EpisodioClinico == objSC.EpisodioClinico
                              //      && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                              //  ).ToList();


                              //          foreach (var item in lstDiag)
                              //          {
                              //              if (objDetalle.CodigoSegus.Trim() != item.CodigoSegus.Trim())
                              //              {
                              //                  objDetalle.Accion = "DELETE";

                              //                  context.USp_HC_NotaIngreso_ExamenApoyo_FE_Insertar(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente,
                              //                 objDetalle.EpisodioClinico, Convert.ToInt32(objDetalle.Secuencia), objDetalle.CodigoSegus, objDetalle.TipoOrdenAtencion,
                              //                   objDetalle.IndicadorEPS, objDetalle.CodigoComponente, objDetalle.ExamenDescripcion, objDetalle.UsuarioCreacion,
                              //                  objDetalle.FechaCreacion, objDetalle.UsuarioModificacion, objDetalle.FechaModificacion, objDetalle.Accion, objDetalle.Version).SingleOrDefault();

                              //              }
                              //          }
                              //      }
                                    
                                     

                                }

                                 
                              

                              
                            }
                            ENTITY_GLOBAL.Instance.CheckPresseDelete = false;
                        }
                        #endregion


                        #region Detalle1

                        foreach (SS_HC_NotaIngreso_Diagnostico_FE ObjTraceDell in detalle2)
                        {

                            var virtualObj = (from t in context.SS_HC_NotaIngreso_Diagnostico_FE
                                              where t.IdPaciente == ObjTraceDell.IdPaciente
                                             && t.EpisodioClinico == ObjTraceDell.EpisodioClinico
                                             && t.IdEpisodioAtencion == ObjTraceDell.IdEpisodioAtencion
                                             && t.Secuencia == ObjTraceDell.Secuencia
                                              orderby t.IdEpisodioAtencion descending
                                              select t).SingleOrDefault();


                            if (virtualObj == null && ObjTraceDell.Accion != "DELETE")
                            {
                                ObjTraceDell.Accion = "INSERTDETALLE";
                            }
                            objDesMedDiag = new SS_HC_NotaIngreso_Diagnostico_FE();
                            if (ObjTraceDell.Accion.Trim() == "NUEVO") { objDesMedDiag.Accion = "INSERTDETALLE"; }
                            if (ObjTraceDell.Accion.Trim() != "EXISTE_INSERTDETALLE")
                            {

                                if (ObjTraceDell.Accion == "NUEVO")
                                {
                                    ObjTraceDell.Accion = "INSERTDETALLE";
                                }

                                var cap = ObjTraceDell.Accion;

                                objDesMedDiag.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
                                objDesMedDiag.IdPaciente = ObjTraceDell.IdPaciente;
                                objDesMedDiag.EpisodioClinico = ObjTraceDell.EpisodioClinico;
                                objDesMedDiag.IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion;
                                if (ObjTraceDell.Secuencia != null) objDesMedDiag.Secuencia = (int)ObjTraceDell.Secuencia;


                                context.USP_HC_NotaIngreso_Diagnostico_FE_Insert(objDesMedDiag.UnidadReplicacion, objDesMedDiag.IdEpisodioAtencion,
                                    objDesMedDiag.IdPaciente, objDesMedDiag.EpisodioClinico,
                                    ObjTraceDell.Secuencia, ObjTraceDell.Codigo, ObjTraceDell.DiagnosticoDescripcion, ObjTraceDell.DeterminacionDiagnostica,
                                    ObjTraceDell.GradoAfeccion, ObjTraceDell.IdDiagnosticoPrincipal,
                                    ObjTraceDell.UsuarioCreacion, ObjTraceDell.FechaCreacion, ObjTraceDell.UsuarioModificacion,
                                    ObjTraceDell.FechaModificacion, ObjTraceDell.Accion, ObjTraceDell.Version).SingleOrDefault();

                            }

                          

                        }
                        #endregion

                        //** Agregado auditoria --> N° 3
                        #region Auditoria
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
                            objAudit = Control.AddAudita(new SS_HC_Nota_Ingreso_FE(), new SS_HC_Nota_Ingreso_FE(), DataKey, objAudit.Type);

                            objAudit.TableName = "SS_HC_Nota_Ingreso_FE ";
                            objAudit.Type = objSC.Accion.Substring(0, 1);
                            objAudit.Accion = objSC.Accion;
                            contextEnty.Entry(objAudit).State = EntityState.Added;
                            contextEnty.SaveChanges();
                        }
                        //**
                        #endregion

                        /*******************************/

                        context.SaveChanges();
                        //dbContextTransaction.Commit();

                        #region ValidarDetalle
                        int objCountDet = 0;
                        objCountDet = context.SS_HC_Nota_Ingreso_FE
                          .Where(t =>
                                t.IdPaciente == objSC.IdPaciente
                                && t.UnidadReplicacion == objSC.UnidadReplicacion
                                && t.EpisodioClinico == objSC.EpisodioClinico
                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                            )

                          .Count();
                        if (objCountDet == 0)
                        {
                            // Borrar Cabecerra
                           // context.Entry(objSC).State = EntityState.Deleted;
                        }

                        context.SaveChanges();

                        dbContextTransaction.Commit();
                        #endregion


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

        public virtual String XMLString(List<SS_HC_Nota_Ingreso_FE> obPadre, String TablaID)
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

        //Agregado auditoria --> N° 4


    }
}

