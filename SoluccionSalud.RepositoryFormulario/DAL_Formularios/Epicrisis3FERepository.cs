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
    public class Epicrisis3FERepository
    {

        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1

        public int setMantenimiento(SS_HC_Epicrisis_3 objSC, List<SS_HC_Epicrisis_3_Diagnostico> detalle0, List<SS_HC_Epicrisis_3_Diag_Principal> detalle1, List<SS_HC_Epicrisis_3_Diag_Secundaria> detalle2, List<SS_HC_Medicamento_FE_Epi2> detalle3)
        {
            int valorRetorno = -1; //ERROR
            int Id = objSC.IdEpicrisis3;
            SS_HC_Epicrisis_3 obj_epicrisis = new SS_HC_Epicrisis_3();
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
                                if (objSC.IdEpicrisis3 == 0)
                                {
                                    Id = context.SS_HC_Epicrisis_3
                                          .DefaultIfEmpty().Max(t => t == null ? 0 : t.IdEpicrisis3) + 1;

                                    objSC.IdEpicrisis3 = Id;
                                }

                                context.SP_SS_HC_Epicrisis_Insert(objSC.UnidadReplicacion, Convert.ToInt32(objSC.IdEpisodioAtencion), objSC.IdPaciente, objSC.EpisodioClinico,
                                    objSC.IdEpicrisis3, objSC.Complicaciones, objSC.Pronostico, objSC.TipoAlta, objSC.CondicionEgreso, objSC.CausaMuerte,
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
                            var secuenciaMax1 = context.SS_HC_Epicrisis_3_Diagnostico
                                    .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_Epicrisis_3_Diagnostico objDet = null;

                            foreach (SS_HC_Epicrisis_3_Diagnostico objDetalle0 in detalle0)
                            {
                                objDet = new SS_HC_Epicrisis_3_Diagnostico();
                                objDet.IdEpicrisis3 = 2;

                                Nullable<int> secuenciaAux = objDetalle0.Secuencia;

                                objDet.IdPaciente = objDetalle0.IdPaciente;
                                objDet.EpisodioClinico = objDetalle0.EpisodioClinico;
                                objDet.UnidadReplicacion = objDetalle0.UnidadReplicacion;
                                objDet.IdEpisodioAtencion = objDetalle0.IdEpisodioAtencion;
                                objDet.Codigo = objDetalle0.Codigo;
                                objDet.DiagnosticoDescripcion = objDetalle0.DiagnosticoDescripcion;
                                objDet.FechaCreacion = DateTime.Now;
                                objDet.Accion = objDetalle0.Accion;



                                objDet.Secuencia = Convert.ToInt32(objDetalle0.Secuencia);
                                // objDet.SS_HC_Epicrisis_3 = obj_epicrisis;

                                if (objDet.Accion == "NUEVO") // Insertar Detalle
                                {
                                    contadorDet1++;
                                    objDet.Secuencia = secuenciaMax1 + contadorDet1;
                                    objDet.Accion = "NUEVO";

                                    try
                                    {
                                        context.SP_SS_HC_Epicrisis_Diagnostico_Insert(objDet.UnidadReplicacion, Convert.ToInt32(objDet.IdEpisodioAtencion), objDet.IdPaciente, objDet.EpisodioClinico,
                                            objDet.Secuencia, objDet.IdEpicrisis3, objDet.DiagnosticoDescripcion, objDet.Codigo, 1, objDet.UsuarioCreacion, objDet.FechaCreacion,
                                            objDet.UsuarioModificacion, objDet.FechaModificacion, objDet.Accion, objDet.Version);
                                        context.SaveChanges();
                                    }
                                    catch { }

                                }
                                else if (objDet.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    SS_HC_Epicrisis_3_Diagnostico objAnterior = null;


                                    context.SP_SS_HC_Epicrisis_Diagnostico_Insert(objDet.UnidadReplicacion, Convert.ToInt32(objDet.IdEpisodioAtencion), objDet.IdPaciente, objDet.EpisodioClinico,
                                        objDet.Secuencia, objDet.IdEpicrisis3, objDet.DiagnosticoDescripcion, objDet.Codigo, 1, objDet.UsuarioCreacion, objDet.FechaCreacion,
                                        objDet.UsuarioModificacion, objDet.FechaModificacion, objDet.Accion, objDet.Version);
                                    context.SaveChanges();

                                }
                                else if (objDet.Accion == "DELETE")  // Eliminar Detalle
                                {

                                    context.SP_SS_HC_Epicrisis_Diagnostico_Insert(objDet.UnidadReplicacion, Convert.ToInt32(objDet.IdEpisodioAtencion), objDet.IdPaciente, objDet.EpisodioClinico,
                                        objDet.Secuencia, objDet.IdEpicrisis3, objDet.DiagnosticoDescripcion, objDet.Codigo, 1, objDet.UsuarioCreacion, objDet.FechaCreacion,
                                        objDet.UsuarioModificacion, objDet.FechaModificacion, objDet.Accion, objDet.Version);
                                    context.SaveChanges();


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
                                        objAudit = Control.AddAudita(new SS_HC_Epicrisis_3_Diagnostico(), new SS_HC_Epicrisis_3_Diagnostico(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Epicrisis_3_Diagnostico";
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


                        #region detalle1

                        if (detalle1 != null)
                        {

                            int contadorDet1 = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax1 = context.SS_HC_Epicrisis_3_Diag_Principal
                                    .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_Epicrisis_3_Diag_Principal objDet1 = null;

                            foreach (SS_HC_Epicrisis_3_Diag_Principal objDetalle1 in detalle1)
                            {
                                objDet1 = new SS_HC_Epicrisis_3_Diag_Principal();

                                Nullable<int> secuenciaAux = objDetalle1.Secuencia;

                                objDet1.IdPaciente = objDetalle1.IdPaciente;
                                objDet1.EpisodioClinico = objDetalle1.EpisodioClinico;
                                objDet1.UnidadReplicacion = objDetalle1.UnidadReplicacion;
                                objDet1.IdEpisodioAtencion = objDetalle1.IdEpisodioAtencion;
                                objDet1.IdEpicrisis3 = Id;
                                objDet1.Codigo = objDetalle1.Codigo;
                                objDet1.DiagnosticoDescripcion = objDetalle1.DiagnosticoDescripcion;
                                objDet1.FechaCreacion = DateTime.Now;
                                objDet1.Accion = objDetalle1.Accion;
                                //   objDet1.SS_HC_Epicrisis_3 = obj_epicrisis;

                                objDet1.Secuencia = Convert.ToInt32(objDetalle1.Secuencia);

                                if (objDet1.Accion == "NUEVO") // Insertar Detalle
                                {
                                    contadorDet1++;
                                    objDet1.Secuencia = secuenciaMax1 + contadorDet1;
                                    objDet1.Accion = "NUEVO";

                                    //context.Entry(objDet1).State = EntityState.Added;
                                    context.SP_SS_HC_Epicrisis_Principal_Insert(objDet1.UnidadReplicacion, Convert.ToInt32(objDet1.IdEpisodioAtencion), objDet1.IdPaciente, objDet1.EpisodioClinico,
                                       objDet1.Secuencia, objDet1.IdEpicrisis3, objDet1.DiagnosticoDescripcion, objDet1.Codigo, 1, objDet1.UsuarioCreacion, objDet1.FechaCreacion,
                                       objDet1.UsuarioModificacion, objDet1.FechaModificacion, objDet1.Accion, objDet1.Version);
                                    context.SaveChanges();
                                }
                                else if (objDet1.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    SS_HC_Epicrisis_3_Diag_Principal objAnterior = null;

                                    context.SP_SS_HC_Epicrisis_Principal_Insert(objDet1.UnidadReplicacion, Convert.ToInt32(objDet1.IdEpisodioAtencion), objDet1.IdPaciente, objDet1.EpisodioClinico,
                                       objDet1.Secuencia, objDet1.IdEpicrisis3, objDet1.DiagnosticoDescripcion, objDet1.Codigo, 1, objDet1.UsuarioCreacion, objDet1.FechaCreacion,
                                       objDet1.UsuarioModificacion, objDet1.FechaModificacion, objDet1.Accion, objDet1.Version);
                                    context.SaveChanges();

                                }
                                else if (objDet1.Accion == "DELETE")  // Eliminar Detalle
                                {

                                    context.SP_SS_HC_Epicrisis_Principal_Insert(objDet1.UnidadReplicacion, Convert.ToInt32(objDet1.IdEpisodioAtencion), objDet1.IdPaciente, objDet1.EpisodioClinico,
                            objDet1.Secuencia, objDet1.IdEpicrisis3, objDet1.DiagnosticoDescripcion, objDet1.Codigo, 1, objDet1.UsuarioCreacion, objDet1.FechaCreacion,
                            objDet1.UsuarioModificacion, objDet1.FechaModificacion, objDet1.Accion, objDet1.Version);
                                    context.SaveChanges();



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
                                        objAudit = Control.AddAudita(new SS_HC_Epicrisis_3_Diag_Principal(), new SS_HC_Epicrisis_3_Diag_Principal(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Epicrisis_3_Diag_Principal ";
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


                        #region detalle2

                        if (detalle2 != null)
                        {
                            int contadorDet2 = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax2 = context.SS_HC_Epicrisis_3_Diag_Secundaria
                                    .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            SS_HC_Epicrisis_3_Diag_Secundaria objDet2 = null;

                            foreach (SS_HC_Epicrisis_3_Diag_Secundaria objDetalle2 in detalle2)
                            {
                                objDet2 = new SS_HC_Epicrisis_3_Diag_Secundaria();

                                Nullable<int> secuenciaAux = objDetalle2.Secuencia;

                                objDet2.IdPaciente = objDetalle2.IdPaciente;
                                objDet2.EpisodioClinico = objDetalle2.EpisodioClinico;
                                objDet2.UnidadReplicacion = objDetalle2.UnidadReplicacion;
                                objDet2.IdEpisodioAtencion = objDetalle2.IdEpisodioAtencion;
                                objDet2.IdEpicrisis3 = Id;
                                objDet2.Codigo = objDetalle2.Codigo;
                                objDet2.DiagnosticoDescripcion = objDetalle2.DiagnosticoDescripcion;
                                objDet2.FechaCreacion = DateTime.Now;
                                objDet2.Accion = objDetalle2.Accion;
                                //   objDet2.SS_HC_Epicrisis_3 = obj_epicrisis;
                                //objDet.UsuarioCreacion=

                                objDet2.Secuencia = Convert.ToInt32(objDetalle2.Secuencia);

                                if (objDet2.Accion == "NUEVO") // Insertar Detalle
                                {
                                    contadorDet2++;
                                    objDet2.Secuencia = secuenciaMax2 + contadorDet2;

                                    //objDetalle2.Accion = "NUEVO";
                                    //COrresponde al código CPT

                                    //context.Entry(objDet2).State = EntityState.Added;
                                    context.SP_SS_HC_Epicrisis_Secundario_Insert(objDet2.UnidadReplicacion, Convert.ToInt32(objDet2.IdEpisodioAtencion), objDet2.IdPaciente, objDet2.EpisodioClinico,
                                     objDet2.Secuencia, objDet2.IdEpicrisis3, objDet2.DiagnosticoDescripcion, objDet2.Codigo, 1, objDet2.UsuarioCreacion, objDet2.FechaCreacion,
                                     objDet2.UsuarioModificacion, objDet2.FechaModificacion, objDet2.Accion, objDet2.Version);
                                    context.SaveChanges();
                                }

                                else if (objDet2.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    SS_HC_Epicrisis_3_Diag_Secundaria objAnterior2 = null;

                                    //objAnterior2 = (from t in context.SS_HC_Epicrisis_3_Diag_Secundaria
                                    //               where
                                    //               t.UnidadReplicacion == objSC.UnidadReplicacion
                                    //               && t.IdPaciente == objSC.IdPaciente
                                    //               && t.EpisodioClinico == objSC.EpisodioClinico
                                    //               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    //               && t.IdEpicrisis3 == objSC.IdEpicrisis3
                                    //               orderby t.IdEpisodioAtencion descending
                                    //               select t).SingleOrDefault();



                                    //context.Entry(objDet2).State = EntityState.Modified;
                                    context.SP_SS_HC_Epicrisis_Secundario_Insert(objDet2.UnidadReplicacion, Convert.ToInt32(objDet2.IdEpisodioAtencion), objDet2.IdPaciente, objDet2.EpisodioClinico,
                                    objDet2.Secuencia, objDet2.IdEpicrisis3, objDet2.DiagnosticoDescripcion, objDet2.Codigo, 1, objDet2.UsuarioCreacion, objDet2.FechaCreacion,
                                    objDet2.UsuarioModificacion, objDet2.FechaModificacion, objDet2.Accion, objDet2.Version);
                                    context.SaveChanges();
                                    //mapSecuencia.Add("" + secuenciaAux, objDet2.Secuencia);
                                    //context.SaveChanges();
                                }
                                else if (objDet2.Accion == "DELETE")  // Eliminar Detalle
                                {
                                    //context.Entry(objDet2).State = EntityState.Deleted;
                                    context.SP_SS_HC_Epicrisis_Secundario_Insert(objDet2.UnidadReplicacion, Convert.ToInt32(objDet2.IdEpisodioAtencion), objDet2.IdPaciente, objDet2.EpisodioClinico,
                                    objDet2.Secuencia, objDet2.IdEpicrisis3, objDet2.DiagnosticoDescripcion, objDet2.Codigo, 1, objDet2.UsuarioCreacion, objDet2.FechaCreacion,
                                    objDet2.UsuarioModificacion, objDet2.FechaModificacion, objDet2.Accion, objDet2.Version);
                                    context.SaveChanges();



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
                                        objAudit = Control.AddAudita(new SS_HC_Epicrisis_3_Diag_Secundaria(), new SS_HC_Epicrisis_3_Diag_Secundaria(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Epicrisis_3_Diag_Secundaria ";
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

                        #region detalle3
                        if (detalle3 != null)
                        {
                            var contadorDetDos = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMaxDos = context.SS_HC_Medicamento_FE_Epi2
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);



                            //iReturnValue = context.SP_SS_GE_Medicamento_FE_Epi2(
                            //   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdPaciente,
                            //   ObjTrace.EpisodioClinico,
                            //   ObjTrace.IdEpisodioAtencion,
                            //   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                            //   ObjTrace.Linea.Trim(), ObjTrace.Familia.Trim(), ObjTrace.SubFamilia.Trim(),
                            //   ObjTrace.TipoComponente,
                            //   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, 
                            //   ObjTrace.DiasTratamiento,
                            //   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, 
                            //   ObjTrace.TipoReceta,
                            //   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, 
                            //   ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                            //   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma,
                            //   ObjTrace.Presentacion, ObjTrace.Hora,
                            //   ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                            //   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
                            //   ObjTrace.UsuarioModificacion,
                            //   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version,
                            //   ObjTrace.IdPadreNutriente, ObjTrace.IdHijoNutriente
                            //   //, ObjTrace.SecuencialHCE, ObjTrace.CodAlmacen
                            //).SingleOrDefault();


                            foreach (SS_HC_Medicamento_FE_Epi2 ObjTrace in detalle3)
                            {

                                //int secuenciaAuxDos = ObjTrace.Secuencia;

                                if (ObjTrace.Accion == "NUEVO") // Insertar Detalle
                                {

                                    contadorDetDos++;
                                    ObjTrace.Secuencia = secuenciaMaxDos + contadorDetDos;
                                    context.Entry(ObjTrace).State = EntityState.Added;

                                    context.SaveChanges();
                                }
                                else if (ObjTrace.Accion == "UPDATEINDIV") // Actualizar Detalle
                                {
                                    context.Entry(ObjTrace).State = EntityState.Modified;
                                    //mapSecuencia.Add("" + secuenciaAuxDos, ObjTrace.Secuencia);
                                    context.SaveChanges();
                                }
                                else if (ObjTrace.Accion == "DELETEINDIV")  // Eliminar Detalle
                                {
                                    context.Entry(ObjTrace).State = EntityState.Deleted;

                                    context.SaveChanges();

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
                                            IdPaciente = objSC.IdPaciente
                                            //,
                                            //  IdGinecoobstetricos = objSC.IdGinecoobstetricos
                                        };
                                        string tempType = objAudit.Type;
                                        objAudit = Control.AddAudita(new SS_HC_Medicamento_FE_Epi2(), new SS_HC_Medicamento_FE_Epi2(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_Medicamento_FE_Epi2 ";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
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



        public int setMantenimientoMedicamento(SS_HC_InformeAlta_FE objSC, List<SS_HC_MedicamentoAlta_FE> detalle1, List<SS_HC_InformeAltaProxCita_FE> detalle2)
        {
            dynamic DataKey = null;
            int valorRetorno = -1; //ERROR
            System.Nullable<int> iReturnValue;
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

                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {

                                objCountCab = context.SS_HC_InformeAlta_FE
                                    .Where(t =>
                                          t.IdPaciente == objSC.IdPaciente
                                          && t.UnidadReplicacion == objSC.UnidadReplicacion
                                          && t.EpisodioClinico == objSC.EpisodioClinico
                                          && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                      )
                                     .DefaultIfEmpty()
                                    .Count();
                            }

                            if (objCountCab > 0)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    //objAnterior.Resumen = objSC.Resumen;
                                    //objAnterior.Motivo = objSC.Motivo;
                                    //objAnterior.Accion = objSC.Accion;
                                    //context.Entry(objAnterior).State = EntityState.Modified;


                                    context.Entry(objSC).State = EntityState.Modified;
                                }


                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    //objSC.Accion = objSC.Version;
                                    context.Entry(objSC).State = EntityState.Added;
                                }
                            }
                            //context.SaveChanges();
                            //dbContextTransaction.Commit();
                            valorRetorno = 1;



                        }


                        #endregion


                        #region detalle1

                        if (detalle1 != null)
                        {

                            foreach (var ObjTrace in detalle1)
                            {
                                var InformacionObj = (from t in context.SS_HC_MedicamentoAlta_FE
                                                      where t.IdPaciente == ObjTrace.IdPaciente
                                                      && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                      && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                      && t.Secuencia == ObjTrace.Secuencia
                                                      orderby t.IdEpisodioAtencion descending
                                                      select t).SingleOrDefault();
                                if (InformacionObj == null) InformacionObj = new SS_HC_MedicamentoAlta_FE();

                                var secuenciaCabPrevia = ObjTrace.Secuencia;
                                iReturnValue = context.SP_SS_GE_MedicamentoAlta_FE(
                                   ObjTrace.UnidadReplicacion.Trim(),
                                   ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.Secuencia,
                                   ObjTrace.TipoMedicamento,
                                   ObjTrace.IdUnidadMedida,
                                   ObjTrace.Linea.Trim(),
                                   ObjTrace.Familia.Trim(),
                                   ObjTrace.SubFamilia.Trim(),
                                   ObjTrace.TipoComponente,
                                   ObjTrace.CodigoComponente,
                                   ObjTrace.IdVia,
                                   ObjTrace.Dosis,
                                   ObjTrace.DiasTratamiento,
                                   ObjTrace.Frecuencia,
                                   ObjTrace.Cantidad,
                                   ObjTrace.IndicadorEPS,
                                   ObjTrace.TipoReceta,
                                   ObjTrace.Forma,
                                   ObjTrace.GrupoMedicamento,
                                   ObjTrace.Comentario,
                                   ObjTrace.IndicadorAuditoria,
                                   ObjTrace.UsuarioAuditoria,
                                   ObjTrace.TipoComida,
                                   ObjTrace.VolumenDia,
                                   ObjTrace.FrecuenciaToma,
                                   ObjTrace.Presentacion,
                                   ObjTrace.Hora,
                                   ObjTrace.Periodo,
                                   ObjTrace.UnidadTiempo,
                                   ObjTrace.Indicacion,
                                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version,null
                                ).SingleOrDefault();

                                int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                /*  DataKey = new
                                  {
                                      UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                      IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                      EpisodioClinico = ObjTrace.EpisodioClinico,
                                      IdPaciente = ObjTrace.IdPaciente,
                                      Secuencia = ObjTrace.Secuencia,
                                      TipoMedicamento = ObjTrace.TipoMedicamento
                                  };*/

                            }




                        }

                        #endregion


                        #region detalle2

                        if (detalle2 != null)
                        {
                            foreach (var ObjTrace in detalle2)
                            {
                                iReturnValue = context.SP_SS_HC_InformeAltaProxCita_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,

                                   ObjTrace.Secuencia,
                                   ObjTrace.FechaCita,
                                   ObjTrace.IdEspecialidad,
                                   ObjTrace.Observacion,
                                   ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                                ).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            }

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

        public List<SS_HC_Epicrisis_3> Lista_Cabecera(SS_HC_Epicrisis_3 ObjSC)
        {

            List<SS_HC_Epicrisis_3> objCabecera = null;
            using (var context = new ModelFormularios())
            {

                objCabecera = context.SS_HC_Epicrisis_3.Where(
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
                objAudit = Control.AddAudita(new SS_HC_Epicrisis_3(), new SS_HC_Epicrisis_3(), DataKey, objAudit.Type);
                String xlmIn = XMLString(objCabecera, "SS_HC_Epicrisis_3");
                objAudit.TableName = "SS_HC_Epicrisis_3";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                objAudit.Accion = ObjSC.Accion;
                contextEnty.Entry(objAudit).State = EntityState.Added;
                contextEnty.SaveChanges();
            }
            //--
            return objCabecera;
        }

        public List<SS_HC_InformeAlta_Diagnostico_FE> Lista_Diagnostico(SS_HC_InformeAlta_Diagnostico_FE obj)
        {


            List<SS_HC_InformeAlta_Diagnostico_FE> objDiagnostico = null;

            using (var context = new ModelFormularios())
            {

                objDiagnostico = context.SS_HC_InformeAlta_Diagnostico_FE.Where(
                                    t => t.UnidadReplicacion == obj.UnidadReplicacion
                                        && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
                                        && t.EpisodioClinico == obj.EpisodioClinico
                                        && t.IdPaciente == obj.IdPaciente
                    ).ToList();


            }


            return objDiagnostico;
        }

        public List<SS_HC_InformeAlta_Examen_FE> Lista_Examen(SS_HC_InformeAlta_Examen_FE obj)
        {

            List<SS_HC_InformeAlta_Examen_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SS_HC_InformeAlta_Examen_FE.Where(
                                     t => t.UnidadReplicacion == obj.UnidadReplicacion
                                        && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
                                        && t.EpisodioClinico == obj.EpisodioClinico
                                        && t.IdPaciente == obj.IdPaciente
                                        ).ToList();
            }
            return objExamen;

        }


        public List<SS_HC_InformeAltaAPD_FE> Listar_Examenes(SS_HC_InformeAltaAPD_FE obj)
        {

            List<SS_HC_InformeAltaAPD_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_InformeAltaAPD_FE_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.Secuencia
                                     , obj.ExamenDescripcion
                                     , obj.CodigoSegus
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objExamen;

        }

        public List<SS_HC_MedicamentoAlta_FE> MedicamentoListar(SS_HC_MedicamentoAlta_FE ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_MedicamentoAlta_FE> objLista = new List<SS_HC_MedicamentoAlta_FE>();
            using (var context = new ModelFormularios())
            {
                objLista = context.SP_SS_GE_MedicamentoAlta_FEListar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                   ObjTrace.EpisodioClinico,
                   ObjTrace.IdEpisodioAtencion,
                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                   ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                   ObjTrace.Forma, ObjTrace.GrupoMedicamento, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                   ObjTrace.TipoComida, ObjTrace.VolumenDia, ObjTrace.FrecuenciaToma, ObjTrace.Presentacion, ObjTrace.Hora,
                    ObjTrace.Periodo, ObjTrace.UnidadTiempo, ObjTrace.Indicacion,
                   ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version,null,0).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    Secuencia = ObjTrace.Secuencia,
                    TipoMedicamento = ObjTrace.TipoMedicamento

                };

                //objAudit.Type = "V";
                //if (objLista.Count > 1) objAudit.Type = "L";
                //string tempType = objAudit.Type;
                //objAudit = AddAudita(new SS_HC_Medicamento(), new SS_HC_Medicamento(), DataKey, objAudit.Type);
                //String xlmIn = XMLString(objLista, new List<SS_HC_Medicamento>(), "SS_HC_Medicamento");
                //objAudit.TableName = "SS_HC_Medicamento";
                //objAudit.Type = tempType;
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();

                //Agregado auditoria --> N° 2
                /*   using (var contextEnty = new WEB_ERPSALUDEntities())
                   {
                       //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                       List<SS_HC_AuditRoyal> objAuditlista = new List<SS_HC_AuditRoyal>();
                       //dynamic DataKey;
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
                       objAudit = Control.AddAudita(new SS_HC_MedicamentoAlta_FE(), new SS_HC_MedicamentoAlta_FE(), DataKey, objAudit.Type);
                       String xlmIn = XMLString(objLista, "SS_HC_MedicamentoAlta_FE");
                       objAudit.TableName = "SS_HC_MedicamentoAlta_FE";
                       objAudit.Type = tempType;
                       objAudit.VistaData = xlmIn;
                       objAudit.Accion = ObjTrace.Accion;
                       contextEnty.Entry(objAudit).State = EntityState.Added;
                       contextEnty.SaveChanges();
                   }*/
                //--

            }
            return objLista;
        }


        public List<SS_HC_InformeAltaDiagIng_FE> Listar_DiagIngreso(SS_HC_InformeAltaDiagIng_FE obj)
        {

            List<SS_HC_InformeAltaDiagIng_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_InformeAltaDiagIng_FE_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.Secuencia
                                     , obj.DiagnosticoDescripcion
                                     , obj.Codigo
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objExamen;

        }

        public List<SS_HC_Epicrisis_3_Diag_Principal> Listar_Epicrisis_3_Principal(SS_HC_Epicrisis_3_Diag_Principal obj)
        {

            List<SS_HC_Epicrisis_3_Diag_Principal> objExamen = null;


            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_Epicrisis_3_Principal_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objExamen.OrderBy(e => e.FechaCreacion).ToList(); ;

        }


        public List<SS_HC_Epicrisis_3_Diag_Secundaria> Listar_Epicrisis_3_Secundario(SS_HC_Epicrisis_3_Diag_Secundaria obj)
        {

            List<SS_HC_Epicrisis_3_Diag_Secundaria> objExamen = null;


            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_Epicrisis_3_Secundario_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objExamen.OrderBy(e => e.FechaCreacion).ToList(); ;

        }

        public List<SS_HC_InformeAltaProxCita_FE> ProximaCitaListar(SS_HC_InformeAltaProxCita_FE obj)
        {

            List<SS_HC_InformeAltaProxCita_FE> objExamen = null;

            using (var context = new ModelFormularios())
            {

                objExamen = context.SP_SS_HC_InformeAltaProxCita_FE_Listar(
                                     obj.UnidadReplicacion
                                     , obj.IdEpisodioAtencion
                                     , obj.IdPaciente
                                     , obj.EpisodioClinico
                                     , obj.Secuencia
                                     , obj.FechaCita
                                     , obj.IdEspecialidad
                                     , obj.Observacion
                                     , obj.UsuarioCreacion
                                     , obj.FechaCreacion
                                     , obj.UsuarioModificacion
                                     , obj.FechaModificacion
                                     , obj.Accion
                                     , obj.Version
                                        ).ToList();
            }
            return objExamen;

        }

        public int setMantenimientoGrupo(SS_HC_InformeAlta_FE ObjTraces, List<SS_HC_InformeAltaDiagIng_FE> listaCabecera01, List<SS_HC_InformeAltaDiagAlt_FE> listaCabecera02, List<SS_HC_InformeAltaAPD_FE> listaCabecera03)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (ObjTraces != null)
                        {
                            iReturnValue = context.SP_SS_HC_InformeAlta_FE(
                                            ObjTraces.UnidadReplicacion.Trim(), ObjTraces.IdEpisodioAtencion, ObjTraces.IdPaciente,
                                            ObjTraces.EpisodioClinico, ObjTraces.IdMedico, ObjTraces.IdEspecialidad, ObjTraces.IdTipoAlta, ObjTraces.IdPronostico,
                                            ObjTraces.Procedimientos, ObjTraces.indigenerales, ObjTraces.actividafisica, ObjTraces.indidieta, ObjTraces.restricciones, ObjTraces.proximacitas,
                                            ObjTraces.UsuarioCreacion, ObjTraces.FechaCreacion, ObjTraces.UsuarioModificacion, ObjTraces.FechaModificacion, ObjTraces.Accion, ObjTraces.Version).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        }
                        if (listaCabecera01 != null)
                        {
                            foreach (var ObjTrace in listaCabecera01)
                            {

                                iReturnValue = context.SP_SS_HC_InformeAltaDiagIng_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,

                                   ObjTrace.Secuencia, ObjTrace.DiagnosticoDescripcion, ObjTrace.Codigo,
                                   ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                                ).SingleOrDefault();


                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());


                            }
                        }
                        if (listaCabecera02 != null)
                        {
                            foreach (var ObjTrace in listaCabecera02)
                            {
                                iReturnValue = context.SP_SS_HC_InformeAltaDiagAlt_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,

                                   ObjTrace.Secuencia, ObjTrace.DiagnosticoDescripcion, ObjTrace.Codigo,
                                   ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                                ).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            }
                        }
                        if (listaCabecera03 != null)
                        {
                            foreach (var ObjTrace in listaCabecera03)
                            {
                                iReturnValue = context.SP_SS_HC_InformeAltaAPD_FE(
                                   ObjTrace.UnidadReplicacion.Trim(), ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,

                                   ObjTrace.Secuencia, ObjTrace.ExamenDescripcion, ObjTrace.CodigoSegus,
                                   ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                                ).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            }
                        }
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



        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Epicrisis_3> obPadre, String TablaID)
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
