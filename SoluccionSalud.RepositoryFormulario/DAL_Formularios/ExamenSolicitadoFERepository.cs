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
    public class ExamenSolicitadoFERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public int setMantenimiento(SS_HC_ExamenSolicitadoFE objSC, List<SS_HC_ExamenSolicitadoFE> Detalle, List<SS_HC_DescansoMedico_FE> Detalle1)
        {

            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    SS_HC_Apoyo_Diagnostico_FE objDesMedDiag;
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


                                objCountCab = context.SS_HC_ExamenSolicitadoFE
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
                                    context.Entry(objSC).State = EntityState.Modified;
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

                                objSC.Accion = "NUEVO";
                                if (objSC.Accion == "NUEVO")
                                {
                                    iReturnValue = context.USP_ExamenSolicitadoFE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion, objSC.IdPaciente,
                                        objSC.EpisodioClinico, Convert.ToInt32(objSC.SecuenciaCab), objSC.IdProcedimientoCab, objSC.IdEspecialidadCab,
                                         null, objSC.FechaSolitadaCab, objSC.EspecificacionesCab, objSC.CodigoComponenteCab, objSC.ObservacionCab, null, objSC.IndicadorEPSCab,
                                         objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.TipoCodigoCab, objSC.CodigoSegusCab, objSC.Version,
                                         objSC.CantidadCab, objSC.Resumen, objSC.Motivo, objSC.TipoExamen, objSC.Accion, objSC.IdDiagnostico).SingleOrDefault();

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

                        if (Detalle != null)
                        {
                            int contadorDet = 0;
                            /**obtener la última secuencia*/

                            SS_HC_ExamenSolicitadoDet_FE objDet = new SS_HC_ExamenSolicitadoDet_FE();
                            Nullable<int> iReturnValue;
                            foreach (SS_HC_ExamenSolicitadoFE objDetalle in Detalle)
                            {                               
                                Nullable<int> secuenciaAux = objDetalle.SecuenciaCab;
                                iReturnValue = context.USP_ExamenSolicitadoFE(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente,
                                    objDetalle.EpisodioClinico, Convert.ToInt32(objDetalle.SecuenciaCab), objDetalle.IdProcedimientoCab, objDetalle.IdEspecialidadCab,
                                     null, objDetalle.FechaSolitadaCab, objDetalle.EspecificacionesCab, objDetalle.CodigoComponenteCab, objDetalle.ObservacionCab, null, 
                                     objDetalle.IndicadorEPSCab, objDetalle.UsuarioCreacion, objDetalle.FechaCreacion, objDetalle.UsuarioModificacion, objDetalle.FechaModificacion, 
                                     objDetalle.TipoCodigoCab, objDetalle.CodigoSegusCab, objDetalle.Version, objDetalle.CantidadCab, objDetalle.Resumen, objDetalle.Motivo, 
                                     objDetalle.TipoExamen, objDetalle.Accion, objDetalle.IdDiagnostico).SingleOrDefault();

                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                //if (objDetalle.Accion == "DETALLE")
                                //{
                                //    iReturnValue = context.USP_ExamenSolicitadoFE(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente,
                                //        objDetalle.EpisodioClinico, Convert.ToInt32(objDetalle.SecuenciaCab), objDetalle.IdProcedimientoCab, objDetalle.IdEspecialidadCab,
                                //         null, objDetalle.FechaSolitadaCab, objDetalle.EspecificacionesCab, objDetalle.CodigoComponenteCab, objDetalle.ObservacionCab, null, objDetalle.IndicadorEPSCab,
                                //         objDetalle.UsuarioCreacion, objDetalle.FechaCreacion, objDetalle.UsuarioModificacion, objDetalle.FechaModificacion, objDetalle.TipoCodigoCab, objDetalle.CodigoSegusCab, objDetalle.Version,
                                //         objDetalle.CantidadCab, objDetalle.Resumen, objDetalle.Motivo, objDetalle.TipoExamen, objDetalle.Accion, objDetalle.IdDiagnostico).SingleOrDefault();

                                //    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                //}
                              
                                //else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
                                //{
                                //    iReturnValue = context.USP_ExamenSolicitadoFE(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente,
                                //        objDetalle.EpisodioClinico, Convert.ToInt32(objDetalle.SecuenciaCab), objDetalle.IdProcedimientoCab, objDetalle.IdEspecialidadCab,
                                //         null, objDetalle.FechaSolitadaCab, objDetalle.EspecificacionesCab, objDetalle.CodigoComponenteCab, objDetalle.ObservacionCab, null, objDetalle.IndicadorEPSCab,
                                //         objDetalle.UsuarioCreacion, objDetalle.FechaCreacion, objDetalle.UsuarioModificacion, objDetalle.FechaModificacion, objDetalle.TipoCodigoCab, objDetalle.CodigoSegusCab, objDetalle.Version,
                                //         objDetalle.CantidadCab, objDetalle.Resumen, objDetalle.Motivo, objDetalle.TipoExamen, objDetalle.Accion, objDetalle.IdDiagnostico).SingleOrDefault();
                                //    valorRetorno = Convert.ToInt32(objDetalle.SecuenciaCab);
                                  
                                //}
                                //else if (objDetalle.Accion == "DELETE")  // Eliminar Detalle
                                //{
                                //    iReturnValue = context.USP_ExamenSolicitadoFE(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente,
                                //        objDetalle.EpisodioClinico, Convert.ToInt32(objDetalle.SecuenciaCab), objDetalle.IdProcedimientoCab, objDetalle.IdEspecialidadCab,
                                //         null, objDetalle.FechaSolitadaCab, objDetalle.EspecificacionesCab, objDetalle.CodigoComponenteCab, objDetalle.ObservacionCab, null, objDetalle.IndicadorEPSCab,
                                //         objDetalle.UsuarioCreacion, objDetalle.FechaCreacion, objDetalle.UsuarioModificacion, objDetalle.FechaModificacion, objDetalle.TipoCodigoCab, objDetalle.CodigoSegusCab, objDetalle.Version,
                                //         objDetalle.CantidadCab, objDetalle.Resumen, objDetalle.Motivo, objDetalle.TipoExamen, objDetalle.Accion, objDetalle.IdDiagnostico).SingleOrDefault();
                                //    valorRetorno = Convert.ToInt32(objDetalle.SecuenciaCab);
                                //}
                            }
                        }
                        #endregion


                        #region Detalle1


                        if (Detalle1!=null)
                        {
                            foreach (SS_HC_DescansoMedico_FE ObjTraceDell in Detalle1)
                            {

                                var virtualObj = (from t in context.SS_HC_Apoyo_Diagnostico_FE
                                                  where t.IdPaciente == ObjTraceDell.IdPaciente
                                                 && t.EpisodioClinico == ObjTraceDell.EpisodioClinico
                                                 && t.IdEpisodioAtencion == ObjTraceDell.IdEpisodioAtencion
                                                 && t.Secuencia == ObjTraceDell.IdFormaInicio
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();


                                if (virtualObj == null && ObjTraceDell.Accion != "DELETE")
                                {
                                    ObjTraceDell.Accion = "INSERTDETALLE";
                                }


                                objDesMedDiag = new SS_HC_Apoyo_Diagnostico_FE();
                                objDesMedDiag.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
                                objDesMedDiag.IdPaciente = ObjTraceDell.IdPaciente;
                                objDesMedDiag.EpisodioClinico = ObjTraceDell.EpisodioClinico;
                                objDesMedDiag.IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion;
                                if (ObjTraceDell.IdFormaInicio != null) objDesMedDiag.Secuencia = (int)ObjTraceDell.IdFormaInicio;
                                objDesMedDiag.IdDiagnostico = (int)ObjTraceDell.IdDiagnostico;

                                context.SP_Apoyo_Diagnostico_FE(objDesMedDiag.UnidadReplicacion, objDesMedDiag.IdEpisodioAtencion,
                                    objDesMedDiag.IdPaciente, objDesMedDiag.EpisodioClinico, ObjTraceDell.Accion,
                                    objDesMedDiag.IdDiagnostico, ObjTraceDell.IdFormaInicio).SingleOrDefault();


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
                            objAudit = Control.AddAudita(new SS_HC_ExamenSolicitadoFE(), new SS_HC_ExamenSolicitadoFE(), DataKey, objAudit.Type);

                            objAudit.TableName = "SS_HC_ExamenSolicitadoFE ";
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
                        objCountDet = context.SS_HC_ExamenSolicitadoDet_FE
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
                            context.Entry(objSC).State = EntityState.Deleted;
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


        //public int setMantenimiento(SS_HC_ExamenSolicitadoFE objSC, List<SS_HC_ExamenSolicitadoFE> Detalle, List<SS_HC_DescansoMedico_FE> Detalle1)
        //{

        //    int valorRetorno = -1; //ERROR
        //    using (var context = new ModelFormularios())
        //    {
        //        using (var dbContextTransaction = context.Database.BeginTransaction())
        //        {
        //            SS_HC_Apoyo_Diagnostico_FE objDesMedDiag;
        //            SS_HC_DescansoMedico_Diagnostico_FE InforDetalleObj = new SS_HC_DescansoMedico_Diagnostico_FE();
        //            InforDetalleObj.SS_HC_DescansoMedico_FE = null;
        //            try
        //            {

        //                Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
        //                #region Cabecerra

        //                if (objSC != null)
        //                {
        //                    int objCountCab = 0;
        //                    //SS_HC_ExamenSolicitadoFE objAnterior = null;
        //                    if (objSC.Accion == null) objSC.Accion = "X";
        //                    if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
        //                    {
        //                        //objAnterior = (from t in context.SS_HC_ExamenSolicitadoFE
        //                        //               where
        //                        //               t.UnidadReplicacion == objSC.UnidadReplicacion
        //                        //               && t.IdPaciente == objSC.IdPaciente
        //                        //               && t.EpisodioClinico == objSC.EpisodioClinico
        //                        //               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                        //               orderby t.IdEpisodioAtencion descending
        //                        //               select t).SingleOrDefault();


        //                        objCountCab = context.SS_HC_ExamenSolicitadoFE
        //                          .Where(t =>
        //                                t.IdPaciente == objSC.IdPaciente
        //                                && t.UnidadReplicacion == objSC.UnidadReplicacion
        //                                && t.EpisodioClinico == objSC.EpisodioClinico
        //                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                            ).Count();
        //                        // .DefaultIfEmpty()

        //                    }
        //                    /**TRANSACCIÓN*/
        //                    //if (objAnterior != null)
        //                    if (objCountCab > 0)
        //                    {
        //                        if (objSC.Accion == "UPDATE")
        //                        {
        //                            //objAnterior.Resumen = objSC.Resumen;
        //                            //objAnterior.Motivo = objSC.Motivo;
        //                            //objAnterior.Accion = objSC.Accion;
        //                            //context.Entry(objAnterior).State = EntityState.Modified;

        //                            //objSC.UsuarioCreacion = objSC.UsuarioCreacion;
        //                            //objSC.FechaCreacion = objSC.FechaCreacion;
        //                            //objSC.Resumen = objSC.Resumen;
        //                            //objSC.Motivo = objSC.Motivo;
        //                            //objSC.Accion = objSC.Accion;
        //                            context.Entry(objSC).State = EntityState.Modified;
        //                        }
        //                    }
        //                    else
        //                    {
        //                        //   if (objSC.Accion == "NUEVO")
        //                        // {
        //                        //objSC.Accion = objSC.Version;
        //                        //     context.Entry(objSC).State = EntityState.Added;
        //                        // }


        //                        objSC.Accion = "NUEVO";
        //                        context.Entry(objSC).State = EntityState.Added;
        //                    }
        //                    //context.SaveChanges();
        //                    //dbContextTransaction.Commit();
        //                    valorRetorno = 1;
        //                }
        //                else
        //                {
        //                    //valorRetorno = -1;
        //                }

        //                #endregion

        //                /*********GUARDAR DETALLE***************/
        //                #region Detalle

        //                if (Detalle != null)
        //                {
        //                    int contadorDet = 0;
        //                    /**obtener la última secuencia*/


        //                    SS_HC_ExamenSolicitadoDet_FE objDet = new SS_HC_ExamenSolicitadoDet_FE();

        //                    foreach (SS_HC_ExamenSolicitadoFE objDetalle in Detalle)
        //                    {
        //                        objDet = new SS_HC_ExamenSolicitadoDet_FE();

        //                        Nullable<int> secuenciaAux = objDetalle.SecuenciaCab;

        //                        objDet.IdPaciente = objSC.IdPaciente;
        //                        objDet.UnidadReplicacion = objSC.UnidadReplicacion;
        //                        objDet.EpisodioClinico = objSC.EpisodioClinico;
        //                        objDet.IdEpisodioAtencion = objSC.IdEpisodioAtencion;
        //                        objDet.Version = objSC.Version;
        //                        objDet.Secuencia = Convert.ToInt32(objDetalle.SecuenciaCab);

        //                        objDet.IdProcedimiento = objDetalle.IdProcedimientoCab;
        //                        objDet.IdEspecialidad = objDetalle.IdEspecialidadCab;
        //                        objDet.FechaSolicitada = objDetalle.FechaSolitadaCab;
        //                        objDet.Cantidad = objDetalle.CantidadCab;
        //                        objDet.Observacion = objDetalle.ObservacionCab;
        //                        objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
        //                        objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
        //                        objDet.IndicadorEPS = objDetalle.IndicadorEPSCab;
        //                        objDet.TipoCodigo = objDetalle.TipoCodigoCab;
        //                        objDet.CodigoSegus = objDetalle.CodigoSegusCab;
        //                        objDet.CodigoComponente = objDetalle.CodigoComponenteCab;
        //                        objDet.Especificaciones = objDetalle.EspecificacionesCab;
        //                        objDet.Accion = objDetalle.Accion;
        //                        objDet.FechaModificacion = objDetalle.FechaModificacion;

        //                        if (objDetalle.Accion == "DETALLE") // Insertar Detalle
        //                        {
        //                            int objCount = context.SS_HC_ExamenSolicitadoDet_FE
        //                          .Where(t =>
        //                                t.IdPaciente == objDetalle.IdPaciente
        //                                && t.UnidadReplicacion == objDetalle.UnidadReplicacion
        //                                && t.EpisodioClinico == objDetalle.EpisodioClinico
        //                                && t.IdEpisodioAtencion == objDetalle.IdEpisodioAtencion
        //                                && t.CodigoSegus == objDetalle.CodigoSegusCab
        //                            ).Count();

        //                            if (objCount == 0)
        //                            {
        //                                var secuenciaMax = context.SS_HC_ExamenSolicitadoDet_FE
        //                                .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
        //                                contadorDet++;
        //                                objDet.Secuencia = secuenciaMax + contadorDet;
        //                                objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
        //                                objDet.FechaCreacion = objDetalle.FechaCreacion;
        //                                objDet.Accion = "NUEVO";
        //                                //COrresponde al código CPT
        //                                //if (objDet.CodigoComponente == null || objExamSol.CodigoComponenteCab == "")
        //                                //{
        //                                //    objDet.CodigoComponenteCab = objEntity.ValorCodigo7; //CASO SEGUS
        //                                //}
        //                                //objDet.Descripcion = objDetalle.DescripcionExtranjera;
        //                                context.Entry(objDet).State = EntityState.Added;
        //                            }
        //                        }
        //                        else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
        //                        {
        //                            SS_HC_ExamenSolicitadoFE objAnterior = null;

        //                            objAnterior = (from t in context.SS_HC_ExamenSolicitadoFE
        //                                           where
        //                                           t.UnidadReplicacion == objSC.UnidadReplicacion
        //                                           && t.IdPaciente == objSC.IdPaciente
        //                                           && t.EpisodioClinico == objSC.EpisodioClinico
        //                                           && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                                           orderby t.IdEpisodioAtencion descending
        //                                           select t).SingleOrDefault();

        //                            objDet.UsuarioCreacion = objAnterior.UsuarioCreacion;
        //                            objDet.FechaCreacion = objAnterior.FechaCreacion;

        //                            context.Entry(objDet).State = EntityState.Modified;
        //                            mapSecuencia.Add("" + secuenciaAux, objDet.Secuencia);
        //                        }
        //                        else if (objDetalle.Accion == "DELETE")  // Eliminar Detalle
        //                        {
        //                            context.Entry(objDet).State = EntityState.Deleted;

        //                            //** Agregado auditoria --> Eliminar
        //                            using (var contextEnty = new WEB_ERPSALUDEntities())
        //                            {
        //                                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //                                List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
        //                                dynamic DataKey;
        //                                DataKey = new
        //                                {
        //                                    UnidadReplicacion = objSC.UnidadReplicacion,
        //                                    IdEpisodioAtencion = objSC.IdEpisodioAtencion,
        //                                    EpisodioClinico = objSC.EpisodioClinico,
        //                                    IdPaciente = objSC.IdPaciente
        //                                };
        //                                string tempType = objAudit.Type;
        //                                objAudit = Control.AddAudita(new SS_HC_ExamenSolicitadoFE(), new SS_HC_ExamenSolicitadoFE(), DataKey, objAudit.Type);
        //                                objAudit.TableName = "SS_HC_ExamenSolicitadoFE ";
        //                                objAudit.Type = "D";
        //                                objAudit.Accion = "DELETE";
        //                                contextEnty.Entry(objAudit).State = EntityState.Added;
        //                                contextEnty.SaveChanges();
        //                            }
        //                            //**

        //                        }
        //                    }
        //                }
        //                #endregion


        //                #region Detalle1

        //                foreach (SS_HC_DescansoMedico_FE ObjTraceDell in Detalle1)
        //                {

        //                    var virtualObj = (from t in context.SS_HC_Apoyo_Diagnostico_FE
        //                                      where t.IdPaciente == ObjTraceDell.IdPaciente
        //                                     && t.EpisodioClinico == ObjTraceDell.EpisodioClinico
        //                                     && t.IdEpisodioAtencion == ObjTraceDell.IdEpisodioAtencion
        //                                     && t.Secuencia == ObjTraceDell.IdFormaInicio
        //                                      orderby t.IdEpisodioAtencion descending
        //                                      select t).SingleOrDefault();


        //                    if (virtualObj == null && ObjTraceDell.Accion != "DELETE") { ObjTraceDell.Accion = "INSERTDETALLE"; }


        //                    objDesMedDiag = new SS_HC_Apoyo_Diagnostico_FE();
        //                    objDesMedDiag.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
        //                    objDesMedDiag.IdPaciente = ObjTraceDell.IdPaciente;
        //                    objDesMedDiag.EpisodioClinico = ObjTraceDell.EpisodioClinico;
        //                    objDesMedDiag.IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion;
        //                    if (ObjTraceDell.IdFormaInicio != null) objDesMedDiag.Secuencia = (int)ObjTraceDell.IdFormaInicio;
        //                    objDesMedDiag.IdDiagnostico = (int)ObjTraceDell.IdDiagnostico;

        //                    context.SP_Apoyo_Diagnostico_FE(objDesMedDiag.UnidadReplicacion, objDesMedDiag.IdEpisodioAtencion,
        //                        objDesMedDiag.IdPaciente, objDesMedDiag.EpisodioClinico, ObjTraceDell.Accion,
        //                        objDesMedDiag.IdDiagnostico, ObjTraceDell.IdFormaInicio).SingleOrDefault();


        //                }
        //                #endregion

        //                //** Agregado auditoria --> N° 3
        //                #region Auditoria
        //                using (var contextEnty = new WEB_ERPSALUDEntities())
        //                {
        //                    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
        //                    dynamic DataKey;
        //                    DataKey = new
        //                    {
        //                        UnidadReplicacion = objSC.UnidadReplicacion,
        //                        IdEpisodioAtencion = objSC.IdEpisodioAtencion,
        //                        EpisodioClinico = objSC.EpisodioClinico,
        //                        IdPaciente = objSC.IdPaciente
        //                    };
        //                    string tempType = objAudit.Type;
        //                    objAudit = Control.AddAudita(new SS_HC_ExamenSolicitadoFE(), new SS_HC_ExamenSolicitadoFE(), DataKey, objAudit.Type);

        //                    objAudit.TableName = "SS_HC_ExamenSolicitadoFE ";
        //                    objAudit.Type = objSC.Accion.Substring(0, 1);
        //                    objAudit.Accion = objSC.Accion;
        //                    contextEnty.Entry(objAudit).State = EntityState.Added;
        //                    contextEnty.SaveChanges();
        //                }
        //                //**
        //                #endregion

        //                /*******************************/

        //                context.SaveChanges();
        //                //dbContextTransaction.Commit();

        //                #region ValidarDetalle
        //                int objCountDet = 0;
        //                objCountDet = context.SS_HC_ExamenSolicitadoDet_FE
        //                  .Where(t =>
        //                        t.IdPaciente == objSC.IdPaciente
        //                        && t.UnidadReplicacion == objSC.UnidadReplicacion
        //                        && t.EpisodioClinico == objSC.EpisodioClinico
        //                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                    )

        //                  .Count();
        //                if (objCountDet == 0)
        //                {
        //                    // Borrar Cabecerra
        //                    context.Entry(objSC).State = EntityState.Deleted;
        //                }

        //                context.SaveChanges();
        //                dbContextTransaction.Commit();
        //                #endregion

        //            }
        //            catch (Exception ex)
        //            {
        //                dbContextTransaction.Rollback();
        //                throw ex;
        //            }
        //        }
        //    }
        //    return valorRetorno;
        //}

        
        //public int setMantenimiento(SS_HC_ExamenSolicitadoFE objSC, List<SS_HC_ExamenSolicitadoFE> Detalle, List<SS_HC_DescansoMedico_FE> Detalle1)
        //{
        //    int valorRetorno = -1; //ERROR
        //    using (var context = new ModelFormularios())
        //    {
        //        using (var dbContextTransaction = context.Database.BeginTransaction())
        //        {
        //            SS_HC_Apoyo_Diagnostico_FE objDesMedDiag;
        //            SS_HC_DescansoMedico_Diagnostico_FE InforDetalleObj = new SS_HC_DescansoMedico_Diagnostico_FE();
        //            InforDetalleObj.SS_HC_DescansoMedico_FE = null;
        //            try
        //            {

        //                Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();

        //                #region Cabecerra
        //                if (objSC != null)
        //                {
        //                    Nullable<int> iReturnValue;
        //                    objSC.Accion = "NUEVO";
        //                    if (objSC.Accion == "NUEVO")
        //                    {
        //                        iReturnValue = context.USP_ExamenSolicitadoFE(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion, objSC.IdPaciente,
        //                            objSC.EpisodioClinico, Convert.ToInt32(objSC.SecuenciaCab), objSC.IdProcedimientoCab, objSC.IdEspecialidadCab,
        //                             null, objSC.FechaSolitadaCab, objSC.EspecificacionesCab, objSC.CodigoComponenteCab, objSC.ObservacionCab, null, objSC.IndicadorEPSCab,
        //                             objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.TipoCodigoCab, objSC.CodigoSegusCab, objSC.Version,
        //                             objSC.CantidadCab, objSC.Resumen, objSC.Motivo, objSC.TipoExamen, objSC.Accion, objSC.IdDiagnostico).SingleOrDefault();

        //                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
        //                    }
        //                }

        //                //valorRetorno = 1;

        //                #endregion
        //                /*********GUARDAR DETALLE***************/
        //                #region Detalle

        //                if (Detalle != null)
        //                {
        //                    int contadorDet = 0;
        //                    /**obtener la última secuencia*/
        //                    foreach (SS_HC_ExamenSolicitadoFE objDetalle in Detalle)
        //                    {
        //                        Nullable<int> iReturnValue;
        //                        //if (objDetalle.Accion == "DELETE")  // Eliminar Detalle
        //                        //{
        //                        //    //** Agregado auditoria --> Eliminar
        //                        //    using (var contextEnty = new WEB_ERPSALUDEntities())
        //                        //    {
        //                        //        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //                        //        List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
        //                        //        dynamic DataKey;
        //                        //        DataKey = new
        //                        //        {
        //                        //            UnidadReplicacion = objSC.UnidadReplicacion,
        //                        //            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
        //                        //            EpisodioClinico = objSC.EpisodioClinico,
        //                        //            IdPaciente = objSC.IdPaciente
        //                        //        };
        //                        //        string tempType = objAudit.Type;
        //                        //        objAudit = Control.AddAudita(new SS_HC_ExamenSolicitadoFE(), new SS_HC_ExamenSolicitadoFE(), DataKey, objAudit.Type);
        //                        //        objAudit.TableName = "SS_HC_ExamenSolicitadoFE ";
        //                        //        objAudit.Type = "D";
        //                        //        objAudit.Accion = "DELETE";
        //                        //        contextEnty.Entry(objAudit).State = EntityState.Added;
        //                        //        contextEnty.SaveChanges();
        //                        //    }
        //                        //    //**
        //                        //}

        //                        //iReturnValue = context.USP_ExamenSolicitadoFE(objDetalle.UnidadReplicacion, objDetalle.IdEpisodioAtencion, objDetalle.IdPaciente,
        //                        //        objDetalle.EpisodioClinico, Convert.ToInt32(objDetalle.SecuenciaCab), objDetalle.IdProcedimientoCab, objDetalle.IdEspecialidadCab,
        //                        //         null, objDetalle.FechaSolitadaCab, objDetalle.EspecificacionesCab, objDetalle.CodigoComponenteCab, objDetalle.ObservacionCab, null, objDetalle.IndicadorEPSCab,
        //                        //         objDetalle.UsuarioCreacion, objDetalle.FechaCreacion, objDetalle.UsuarioModificacion, objDetalle.FechaModificacion, objDetalle.TipoCodigoCab, objDetalle.CodigoSegusCab, objDetalle.Version,
        //                        //         objDetalle.CantidadCab, objDetalle.Resumen, objDetalle.Motivo, objDetalle.TipoExamen, objDetalle.Accion, objDetalle.IdDiagnostico).SingleOrDefault();
        //                        //valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

        //                        SS_HC_ExamenSolicitadoDet_FE objDet = new SS_HC_ExamenSolicitadoDet_FE();
        //                        Nullable<int> secuenciaAux = objDetalle.SecuenciaCab;

        //                        objDet.IdPaciente = objSC.IdPaciente;
        //                        objDet.UnidadReplicacion = objSC.UnidadReplicacion;
        //                        objDet.EpisodioClinico = objSC.EpisodioClinico;
        //                        objDet.IdEpisodioAtencion = objSC.IdEpisodioAtencion;
        //                        objDet.Version = objSC.Version;
        //                        objDet.Secuencia = Convert.ToInt32(objDetalle.SecuenciaCab);

        //                        objDet.IdProcedimiento = objDetalle.IdProcedimientoCab;
        //                        objDet.IdEspecialidad = objDetalle.IdEspecialidadCab;
        //                        objDet.FechaSolicitada = objDetalle.FechaSolitadaCab;
        //                        objDet.Cantidad = objDetalle.CantidadCab;
        //                        objDet.Observacion = objDetalle.ObservacionCab;
        //                        objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
        //                        objDet.UsuarioModificacion = objDetalle.UsuarioModificacion;
        //                        objDet.IndicadorEPS = objDetalle.IndicadorEPSCab;
        //                        objDet.TipoCodigo = objDetalle.TipoCodigoCab;
        //                        objDet.CodigoSegus = objDetalle.CodigoSegusCab;
        //                        objDet.CodigoComponente = objDetalle.CodigoComponenteCab;
        //                        objDet.Especificaciones = objDetalle.EspecificacionesCab;
        //                        objDet.Accion = objDetalle.Accion;
        //                        objDet.FechaModificacion = objDetalle.FechaModificacion;

        //                        if (objDetalle.Accion == "DETALLE") // Insertar Detalle
        //                        {
        //                            int objCount = context.SS_HC_ExamenSolicitadoDet_FE
        //                          .Where(t =>
        //                                t.IdPaciente == objDetalle.IdPaciente
        //                                && t.UnidadReplicacion == objDetalle.UnidadReplicacion
        //                                && t.EpisodioClinico == objDetalle.EpisodioClinico
        //                                && t.IdEpisodioAtencion == objDetalle.IdEpisodioAtencion
        //                                && t.CodigoSegus == objDetalle.CodigoSegusCab
        //                            ).Count();

        //                            if (objCount == 0)
        //                            {
        //                                var secuenciaMax = context.SS_HC_ExamenSolicitadoDet_FE
        //                                .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);
        //                                contadorDet++;
        //                                objDet.Secuencia = secuenciaMax + contadorDet;
        //                                objDet.UsuarioCreacion = objDetalle.UsuarioCreacion;
        //                                objDet.FechaCreacion = objDetalle.FechaCreacion;
        //                                objDet.Accion = "NUEVO";
        //                                //COrresponde al código CPT
        //                                //if (objDet.CodigoComponente == null || objExamSol.CodigoComponenteCab == "")
        //                                //{
        //                                //    objDet.CodigoComponenteCab = objEntity.ValorCodigo7; //CASO SEGUS
        //                                //}
        //                                //objDet.Descripcion = objDetalle.DescripcionExtranjera;
        //                                context.Entry(objDet).State = EntityState.Added;
        //                            }
        //                        }
        //                        else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
        //                        {
        //                            SS_HC_ExamenSolicitadoFE objAnterior = null;

        //                            objAnterior = (from t in context.SS_HC_ExamenSolicitadoFE
        //                                           where
        //                                           t.UnidadReplicacion == objSC.UnidadReplicacion
        //                                           && t.IdPaciente == objSC.IdPaciente
        //                                           && t.EpisodioClinico == objSC.EpisodioClinico
        //                                           && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                                           orderby t.IdEpisodioAtencion descending
        //                                           select t).SingleOrDefault();

        //                            objDet.UsuarioCreacion = objAnterior.UsuarioCreacion;
        //                            objDet.FechaCreacion = objAnterior.FechaCreacion;

        //                            context.Entry(objDet).State = EntityState.Modified;
        //                            mapSecuencia.Add("" + secuenciaAux, objDet.Secuencia);
        //                        }
        //                        else if (objDetalle.Accion == "DELETE")  // Eliminar Detalle
        //                        {
        //                            context.Entry(objDet).State = EntityState.Deleted;
        //                            //** Agregado auditoria --> Eliminar
        //                            using (var contextEnty = new WEB_ERPSALUDEntities())
        //                            {
        //                                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //                                List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
        //                                dynamic DataKey;
        //                                DataKey = new
        //                                {
        //                                    UnidadReplicacion = objSC.UnidadReplicacion,
        //                                    IdEpisodioAtencion = objSC.IdEpisodioAtencion,
        //                                    EpisodioClinico = objSC.EpisodioClinico,
        //                                    IdPaciente = objSC.IdPaciente
        //                                };
        //                                string tempType = objAudit.Type;
        //                                objAudit = Control.AddAudita(new SS_HC_ExamenSolicitadoFE(), new SS_HC_ExamenSolicitadoFE(), DataKey, objAudit.Type);
        //                                objAudit.TableName = "SS_HC_ExamenSolicitadoFE ";
        //                                objAudit.Type = "D";
        //                                objAudit.Accion = "DELETE";
        //                                contextEnty.Entry(objAudit).State = EntityState.Added;
        //                                contextEnty.SaveChanges();
        //                            }
        //                            //**
        //                        }
        //                    }
        //                }
        //                #endregion

        //                #region Detalle1

        //                foreach (SS_HC_DescansoMedico_FE ObjTraceDell in Detalle1)
        //                {

        //                    var virtualObj = (from t in context.SS_HC_Apoyo_Diagnostico_FE
        //                                      where t.IdPaciente == ObjTraceDell.IdPaciente
        //                                     && t.EpisodioClinico == ObjTraceDell.EpisodioClinico
        //                                     && t.IdEpisodioAtencion == ObjTraceDell.IdEpisodioAtencion
        //                                     && t.Secuencia == ObjTraceDell.IdFormaInicio
        //                                      orderby t.IdEpisodioAtencion descending
        //                                      select t).SingleOrDefault();


        //                    if (virtualObj == null && ObjTraceDell.Accion != "DELETE") { ObjTraceDell.Accion = "INSERTDETALLE"; }


        //                    objDesMedDiag = new SS_HC_Apoyo_Diagnostico_FE();
        //                    objDesMedDiag.UnidadReplicacion = ObjTraceDell.UnidadReplicacion;
        //                    objDesMedDiag.IdPaciente = ObjTraceDell.IdPaciente;
        //                    objDesMedDiag.EpisodioClinico = ObjTraceDell.EpisodioClinico;
        //                    objDesMedDiag.IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion;
        //                    if (ObjTraceDell.IdFormaInicio != null) objDesMedDiag.Secuencia = (int)ObjTraceDell.IdFormaInicio;
        //                    objDesMedDiag.IdDiagnostico = (int)ObjTraceDell.IdDiagnostico;

        //                    context.SP_Apoyo_Diagnostico_FE(objDesMedDiag.UnidadReplicacion, objDesMedDiag.IdEpisodioAtencion,
        //                        objDesMedDiag.IdPaciente, objDesMedDiag.EpisodioClinico, ObjTraceDell.Accion,
        //                        objDesMedDiag.IdDiagnostico, ObjTraceDell.IdFormaInicio).SingleOrDefault();


        //                }
        //                #endregion

        //                //** Agregado auditoria --> N° 3
        //                #region Auditoria
        //                using (var contextEnty = new WEB_ERPSALUDEntities())
        //                {
        //                    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //                    List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
        //                    dynamic DataKey;
        //                    DataKey = new
        //                    {
        //                        UnidadReplicacion = objSC.UnidadReplicacion,
        //                        IdEpisodioAtencion = objSC.IdEpisodioAtencion,
        //                        EpisodioClinico = objSC.EpisodioClinico,
        //                        IdPaciente = objSC.IdPaciente
        //                    };
        //                    string tempType = objAudit.Type;
        //                    objAudit = Control.AddAudita(new SS_HC_ExamenSolicitadoFE(), new SS_HC_ExamenSolicitadoFE(), DataKey, objAudit.Type);

        //                    objAudit.TableName = "SS_HC_ExamenSolicitadoFE ";
        //                    objAudit.Type = objSC.Accion.Substring(0, 1);
        //                    objAudit.Accion = objSC.Accion;
        //                    contextEnty.Entry(objAudit).State = EntityState.Added;
        //                    contextEnty.SaveChanges();
        //                }
        //                //**
        //                #endregion

        //                /*******************************/

        //                context.SaveChanges();
        //                //dbContextTransaction.Commit();

        //                #region ValidarDetalle
        //                int objCountDet = 0;
        //                objCountDet = context.SS_HC_ExamenSolicitadoDet_FE
        //                  .Where(t =>
        //                        t.IdPaciente == objSC.IdPaciente
        //                        && t.UnidadReplicacion == objSC.UnidadReplicacion
        //                        && t.EpisodioClinico == objSC.EpisodioClinico
        //                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                    )

        //                  .Count();
        //                if (objCountDet == 0)
        //                {
        //                    // Borrar Cabecerra
        //                    context.Entry(objSC).State = EntityState.Deleted;
        //                }

        //                context.SaveChanges();
        //                dbContextTransaction.Commit();
        //                #endregion


        //            }
        //            catch (Exception ex)
        //            {
        //                dbContextTransaction.Rollback();
        //                throw ex;
        //            }
        //        }
        //    }
        //    return valorRetorno;
        //}

        public List<SS_HC_ExamenSolicitadoFE> Examen_Listar(SS_HC_ExamenSolicitadoFE ObjTrace)
        {
            try
            {

                List<SS_HC_ExamenSolicitadoFE> objLista = new List<SS_HC_ExamenSolicitadoFE>();
                using (var context = new ModelFormularios())
                {


                    objLista = context.USP_ExamenSolicitadoListarFE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                            ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.SecuenciaCab, ObjTrace.IdProcedimientoCab,
                            ObjTrace.IdEspecialidadCab, ObjTrace.FechaSolitadaCab,
                            ObjTrace.CodigoComponenteCab, ObjTrace.ObservacionCab, ObjTrace.IndicadorEPSCab,
                            ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                            ObjTrace.TipoCodigoCab, ObjTrace.CodigoSegusCab,
                            ObjTrace.Version, ObjTrace.CantidadCab, ObjTrace.Accion, 0, 0).ToList();

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
                        objAudit = Control.AddAudita(new SS_HC_ExamenSolicitadoFE(), new SS_HC_ExamenSolicitadoFE(), DataKey, objAudit.Type);
                        String xlmIn = XMLString(objLista, "SS_HC_ExamenSolicitadoFE");
                        objAudit.TableName = "SS_HC_ExamenSolicitadoFE";
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

        ///
        public SS_HC_ExamenSolicitadoDet_FE ExamenSol_Listar(SS_HC_ExamenSolicitadoDet_FE ObjTrace)
        {
            SS_HC_ExamenSolicitadoDet_FE objResult = null;
            try
            {
                using (var context = new ModelFormularios())
                {
                    SS_HC_ExamenSolicitadoDet_FE objConsulta = (from t in context.SS_HC_ExamenSolicitadoDet_FE
                                where
                                t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                && t.IdPaciente == ObjTrace.IdPaciente
                                && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                && t.CodigoSegus == ObjTrace.CodigoSegus
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



        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_ExamenSolicitadoFE> obPadre, String TablaID)
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
