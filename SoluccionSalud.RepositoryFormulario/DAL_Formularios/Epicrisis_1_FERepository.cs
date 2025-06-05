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
    public class Epicrisis_1_FERepository
    {
        Repository.DALAuditoria.AuditoriaRepository Control = new Repository.DALAuditoria.AuditoriaRepository();  //Agregado auditoria --> N° 1
        public int setMantenimiento(SS_HC_Epicrisis_1_FE objSC, List<SS_HC_Epicrisis_3_Diagnostico> detalle0, List<SS_HC_Epicrisis_3_Diag_Principal> detalle1, List<SS_HC_Epicrisis_3_Diag_Secundaria> detalle2, List<SS_HC_InterConsulta_Epricrisis3_FE> detalle3)
        {
            int valorRetorno = -1; //ERROR
            int Id = 0;
            SS_HC_Epicrisis_1_FE obj_epicrisis = new SS_HC_Epicrisis_1_FE();
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Nullable<int> iReturnValue;
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
                                iReturnValue = context.SP_SS_HC_Epicrisis_1_FE(objSC.UnidadReplicacion, Convert.ToInt32(objSC.IdEpisodioAtencion),
                                    objSC.IdPaciente, objSC.EpisodioClinico,
                                    objSC.IdMedico, objSC.ManejoConjunto, objSC.Especificar, objSC.Redacta, objSC.FechaIngreso, objSC.HoraIngreso,
                                    objSC.FechaEgreso, objSC.HoraEgreso,
                                    objSC.DiasHospitalizacion, objSC.EnfermedadActual, objSC.Antecedentes, objSC.ExamenFisico, objSC.Evolucion,
                                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();
                            }
                            //}

                            obj_epicrisis = objSC;
                            // context.SaveChanges();
                        }

                        #endregion

                        #region detalle0

                        if (detalle0.Count > 0)
                        {
                            int contadorDet1 = 0;
                            /**obtener la última secuencia*/
                            var secuenciaMax1 = context.SS_HC_Epicrisis_3_Diagnostico
                                .Where(t =>
                                        t.IdPaciente == objSC.IdPaciente
                                        && t.UnidadReplicacion == objSC.UnidadReplicacion
                                        && t.EpisodioClinico == objSC.EpisodioClinico
                                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_Epicrisis_3_Diagnostico objDetalle0 in detalle0)
                            {

                                objDetalle0.Version = "CCEPF200D";
                                Nullable<int> secuenciaAux = objDetalle0.Secuencia;
                                objDetalle0.IdEpicrisis3 = 1;
                                if (objDetalle0.Accion == "NUEVO") // Insertar Detalle
                                {
                                    contadorDet1++;
                                    objDetalle0.Secuencia = secuenciaMax1 + contadorDet1;
                                    objDetalle0.FechaCreacion = DateTime.Now;

                                    objDetalle0.Accion = "NUEVO";
                                    try
                                    {
                                        context.SP_SS_HC_Epicrisis_Diagnostico_Insert(objDetalle0.UnidadReplicacion, Convert.ToInt32(objDetalle0.IdEpisodioAtencion), objDetalle0.IdPaciente, objDetalle0.EpisodioClinico,
                                            objDetalle0.Secuencia, objDetalle0.IdEpicrisis3, objDetalle0.DiagnosticoDescripcion, objDetalle0.Codigo, 1, objDetalle0.UsuarioCreacion, objDetalle0.FechaCreacion,
                                            objDetalle0.UsuarioModificacion, objDetalle0.FechaModificacion, objDetalle0.Accion, objDetalle0.Version);
                                        context.SaveChanges();
                                    }
                                    catch (Exception ex)
                                    {
                                        dbContextTransaction.Rollback();
                                        throw ex;
                                    }
                                }
                                else if (objDetalle0.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    SS_HC_Epicrisis_3_Diagnostico objAnterior = null;


                                    context.SP_SS_HC_Epicrisis_Diagnostico_Insert(objDetalle0.UnidadReplicacion, Convert.ToInt32(objDetalle0.IdEpisodioAtencion), objDetalle0.IdPaciente, objDetalle0.EpisodioClinico,
                                        objDetalle0.Secuencia, objDetalle0.IdEpicrisis3, objDetalle0.DiagnosticoDescripcion, objDetalle0.Codigo, 1, objDetalle0.UsuarioCreacion, objDetalle0.FechaCreacion,
                                        objDetalle0.UsuarioModificacion, objDetalle0.FechaModificacion, objDetalle0.Accion, objDetalle0.Version);
                                    context.SaveChanges();
                                }
                                else if (objDetalle0.Accion == "DELETE")  // Eliminar Detalle
                                {

                                    context.SP_SS_HC_Epicrisis_Diagnostico_Insert(objDetalle0.UnidadReplicacion, Convert.ToInt32(objDetalle0.IdEpisodioAtencion), objDetalle0.IdPaciente, objDetalle0.EpisodioClinico,
                                        objDetalle0.Secuencia, objDetalle0.IdEpicrisis3, objDetalle0.DiagnosticoDescripcion, objDetalle0.Codigo, 1, objDetalle0.UsuarioCreacion, objDetalle0.FechaCreacion,
                                        objDetalle0.UsuarioModificacion, objDetalle0.FechaModificacion, objDetalle0.Accion, objDetalle0.Version);
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

                        if (detalle1.Count > 0)
                        {

                            int contadorDet1 = 0;
                            /**obtener la última secuencia*/
                            //var secuenciaMax1 = context.SS_HC_InformeAlta_Diagnostico_FE
                            //        .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);


                            var secuenciaMax1 = context.SS_HC_Epicrisis_3_Diag_Principal
                             .Where(t =>
                                     t.IdPaciente == objSC.IdPaciente
                                     && t.UnidadReplicacion == objSC.UnidadReplicacion
                                     && t.EpisodioClinico == objSC.EpisodioClinico
                                     && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                             ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_Epicrisis_3_Diag_Principal objDetalle1 in detalle1)
                            {

                                objDetalle1.Version = "CCEPF200EX";
                                Nullable<int> secuenciaAux = objDetalle1.Secuencia;
                                objDetalle1.IdEpicrisis3 = 10;


                                if (objDetalle1.Accion == "NUEVO") // Insertar Detalle
                                {

                                    contadorDet1++;
                                    objDetalle1.Secuencia = secuenciaMax1 + contadorDet1;
                                    objDetalle1.FechaCreacion = DateTime.Now;
                                    objDetalle1.Accion = "NUEVO";

                                    //context.Entry(objDet1).State = EntityState.Added;
                                    context.SP_SS_HC_Epicrisis_Principal_Insert(objDetalle1.UnidadReplicacion, Convert.ToInt32(objDetalle1.IdEpisodioAtencion), objDetalle1.IdPaciente, objDetalle1.EpisodioClinico,
                                       objDetalle1.Secuencia, objDetalle1.IdEpicrisis3, objDetalle1.DiagnosticoDescripcion, objDetalle1.Codigo, 1, objDetalle1.UsuarioCreacion, objDetalle1.FechaCreacion,
                                       objDetalle1.UsuarioModificacion, objDetalle1.FechaModificacion, objDetalle1.Accion, objDetalle1.Version);
                                    context.SaveChanges();
                                }
                                else if (objDetalle1.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    SS_HC_Epicrisis_3_Diag_Principal objAnterior = null;

                                    context.SP_SS_HC_Epicrisis_Principal_Insert(objDetalle1.UnidadReplicacion, Convert.ToInt32(objDetalle1.IdEpisodioAtencion), objDetalle1.IdPaciente, objDetalle1.EpisodioClinico,
                                       objDetalle1.Secuencia, objDetalle1.IdEpicrisis3, objDetalle1.DiagnosticoDescripcion, objDetalle1.Codigo, 1, objDetalle1.UsuarioCreacion, objDetalle1.FechaCreacion,
                                       objDetalle1.UsuarioModificacion, objDetalle1.FechaModificacion, objDetalle1.Accion, objDetalle1.Version);
                                    context.SaveChanges();

                                }
                                else if (objDetalle1.Accion == "DELETE")  // Eliminar Detalle
                                {

                                    context.SP_SS_HC_Epicrisis_Principal_Insert(objDetalle1.UnidadReplicacion, Convert.ToInt32(objDetalle1.IdEpisodioAtencion), objDetalle1.IdPaciente, objDetalle1.EpisodioClinico,
                            objDetalle1.Secuencia, objDetalle1.IdEpicrisis3, objDetalle1.DiagnosticoDescripcion, objDetalle1.Codigo, 1, objDetalle1.UsuarioCreacion, objDetalle1.FechaCreacion,
                            objDetalle1.UsuarioModificacion, objDetalle1.FechaModificacion, objDetalle1.Accion, objDetalle1.Version);

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

                        if (detalle2.Count > 0)
                        {
                            int contadorDet2 = 0;
                            /**obtener la última secuencia*/
                            //var secuenciaMax2 = context.SS_HC_InformeAlta_Examen_FE
                            //        .DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            var secuenciaMax2 = context.SS_HC_Epicrisis_3_Diag_Secundaria
                             .Where(t =>
                                     t.IdPaciente == objSC.IdPaciente
                                     && t.UnidadReplicacion == objSC.UnidadReplicacion
                                     && t.EpisodioClinico == objSC.EpisodioClinico
                                     && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                             ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_Epicrisis_3_Diag_Secundaria objDetalle2 in detalle2)
                            {

                                Nullable<int> secuenciaAux = objDetalle2.Secuencia;
                                if (objDetalle2.Accion == "NUEVO") // Insertar Detalle
                                {

                                    contadorDet2++;
                                    objDetalle2.Secuencia = secuenciaMax2 + contadorDet2;
                                    objDetalle2.FechaCreacion = DateTime.Now;
                                    objDetalle2.IdEpicrisis3 = Id;
                                    objDetalle2.Accion = "NUEVO";


                                    context.SP_SS_HC_Epicrisis_Secundario_Insert(objDetalle2.UnidadReplicacion, Convert.ToInt32(objDetalle2.IdEpisodioAtencion), objDetalle2.IdPaciente, objDetalle2.EpisodioClinico,
                                     objDetalle2.Secuencia, objDetalle2.IdEpicrisis3, objDetalle2.DiagnosticoDescripcion, objDetalle2.Codigo, 1, objDetalle2.UsuarioCreacion, objDetalle2.FechaCreacion,
                                     objDetalle2.UsuarioModificacion, objDetalle2.FechaModificacion, objDetalle2.Accion, objDetalle2.Version);
                                    context.SaveChanges();
                                }

                                else if (objDetalle2.Accion == "UPDATE") // Actualizar Detalle
                                {

                                    context.SP_SS_HC_Epicrisis_Secundario_Insert(objDetalle2.UnidadReplicacion, Convert.ToInt32(objDetalle2.IdEpisodioAtencion), objDetalle2.IdPaciente, objDetalle2.EpisodioClinico,
                                    objDetalle2.Secuencia, objDetalle2.IdEpicrisis3, objDetalle2.DiagnosticoDescripcion, objDetalle2.Codigo, 1, objDetalle2.UsuarioCreacion, objDetalle2.FechaCreacion,
                                    objDetalle2.UsuarioModificacion, objDetalle2.FechaModificacion, objDetalle2.Accion, objDetalle2.Version);
                                    context.SaveChanges();

                                }
                                else if (objDetalle2.Accion == "DELETE")  // Eliminar Detalle
                                {

                                    context.SP_SS_HC_Epicrisis_Secundario_Insert(objDetalle2.UnidadReplicacion, Convert.ToInt32(objDetalle2.IdEpisodioAtencion), objDetalle2.IdPaciente, objDetalle2.EpisodioClinico,
                                    objDetalle2.Secuencia, objDetalle2.IdEpicrisis3, objDetalle2.DiagnosticoDescripcion, objDetalle2.Codigo, 1, objDetalle2.UsuarioCreacion, objDetalle2.FechaCreacion,
                                    objDetalle2.UsuarioModificacion, objDetalle2.FechaModificacion, objDetalle2.Accion, objDetalle2.Version);
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

                         
                        /*********GUARDAR DETALLE 4 INTERCONSULTA ***************/
                        if (detalle3 != null)
                        {
                            var contadorDetDos = 0;

                            /**obtener la última secuencia*/
                            var secuenciaMaxDos = context.SS_HC_InterConsulta_Epricrisis3_FE
                                    .Where(t =>
                                            t.IdPaciente == objSC.IdPaciente
                                            && t.UnidadReplicacion == objSC.UnidadReplicacion
                                            && t.EpisodioClinico == objSC.EpisodioClinico
                                            && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                    ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                            foreach (SS_HC_InterConsulta_Epricrisis3_FE objDetalleUsoEquip in detalle3)
                            {
                                //int secuenciaAuxDos = objDetalleDos.Secuencia;
                                if (objDetalleUsoEquip.Accion == "NUEVO") // Insertar Detalle
                                {

                                    contadorDetDos++;
                                    objDetalleUsoEquip.Secuencia = secuenciaMaxDos + contadorDetDos;
                                    context.Entry(objDetalleUsoEquip).State = EntityState.Added;
                                    context.SaveChanges();
                                }
                                else if (objDetalleUsoEquip.Accion == "UPDATE") // Actualizar Detalle
                                {
                                    context.Entry(objDetalleUsoEquip).State = EntityState.Modified;
                                    context.SaveChanges();
                                    //mapSecuencia.Add("" + secuenciaAuxDos, objDetalleDos.Secuencia);

                                }
                                else if (objDetalleUsoEquip.Accion == "DELETE")  // Eliminar Detalle
                                {
                                    context.Entry(objDetalleUsoEquip).State = EntityState.Deleted;
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
                                        objAudit = Control.AddAudita(new SS_HC_InterConsulta_Epricrisis3_FE(), new SS_HC_InterConsulta_Epricrisis3_FE(), DataKey, objAudit.Type);
                                        objAudit.TableName = "SS_HC_InterConsulta_Epricrisis3_FE ";
                                        objAudit.Type = "D";
                                        objAudit.Accion = "DELETEDETALLE";
                                        contextEnty.Entry(objAudit).State = EntityState.Added;
                                        contextEnty.SaveChanges();
                                    }
                                    //**
                                }

                            }

                        }





                        context.SaveChanges();
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
        public List<SS_HC_Epicrisis_1_FE> listarEntidad(SS_HC_Epicrisis_1_FE objSC)
        {
            List<SS_HC_Epicrisis_1_FE> objLista = new List<SS_HC_Epicrisis_1_FE>();
            using (var context = new ModelFormularios())
            {

                List<SS_HC_Epicrisis_1_FE> objConsultas = (from t in context.SS_HC_Epicrisis_1_FE
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
                        IdPaciente = objSC.IdPaciente

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
                    objAudit = Control.AddAudita(new SS_HC_Epicrisis_1_FE(), new SS_HC_Epicrisis_1_FE(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, "SS_HC_Epicrisis_1_FE");
                    objAudit.TableName = "SS_HC_Referencia_FE";
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

        //public int setMantenimiento(SS_HC_Referencia_FE objSC, List<SS_HC_ReferenciaDetalle_FE> Detalle)
        //{

        //    int valorRetorno = -1; //ERROR
        //    using (var context = new ModelFormularios())
        //    {
        //        using (var dbContextTransaction = context.Database.BeginTransaction())
        //        {
        //            try
        //            {
        //                Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
        //                if (objSC != null)
        //                {

        //                    SS_HC_Referencia_FE objAnterior = null;
        //                    if (objSC.Accion == null) objSC.Accion = "X";
        //                    if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
        //                    {
        //                        objAnterior = (from t in context.SS_HC_Referencia_FE
        //                                       where
        //                                       t.UnidadReplicacion == objSC.UnidadReplicacion
        //                                       && t.IdPaciente == objSC.IdPaciente
        //                                       && t.EpisodioClinico == objSC.EpisodioClinico
        //                                       && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                                       orderby t.IdEpisodioAtencion descending
        //                                       select t).SingleOrDefault();
        //                    }
        //                    /**TRANSACCIÓN*/
        //                    if (objAnterior != null)
        //                    {
        //                        objSC.IdReferencia = objAnterior.IdReferencia;
        //                        if (objSC.Accion == "UPDATE")
        //                        {
        //                            context.Entry(objSC).State = EntityState.Modified;
        //                        }
        //                    }
        //                    else
        //                    {
        //                        if (objSC.Accion == "NUEVO")
        //                        {
        //                            var Result = from item in context.SS_HC_Referencia_FE select item.IdReferencia;
        //                            int strMaxValueId = 1;
        //                            if (Result.Count() > 0)
        //                            {
        //                                strMaxValueId = (Result.Max() + 1);
        //                            }
        //                            string strNewValueId = strMaxValueId.ToString().PadLeft(4, '0');
        //                            //int maxAge = context.SS_HC_Referencia_FE.Max(p => p.IdReferencia);

        //                            objSC.IdReferencia = strMaxValueId;
        //                            objSC.NroReferencia = strNewValueId;
        //                            context.Entry(objSC).State = EntityState.Added;
        //                        }

        //                    }
        //                    valorRetorno = 1;
        //                }
        //                else
        //                {
        //                    //valorRetorno = -1;
        //                }


        //                /*********GUARDAR DETALLE***************/
        //                if (Detalle.Count > 0)
        //                {
        //                    int contadorDet = 0;
        //                    /**obtener la última secuencia*/
        //                    var secuenciaMax = context.SS_HC_ReferenciaDetalle_FE
        //                            .Where(t =>
        //                                    t.IdPaciente == objSC.IdPaciente
        //                                    && t.UnidadReplicacion == objSC.UnidadReplicacion
        //                                    && t.EpisodioClinico == objSC.EpisodioClinico
        //                                    && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
        //                                    && t.IdReferencia == objSC.IdReferencia
        //                            ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

        //                    foreach (SS_HC_ReferenciaDetalle_FE objDetalle in Detalle)
        //                    {
        //                        objDetalle.IdReferencia = objSC.IdReferencia;
        //                        int secuenciaAux = objDetalle.Secuencia;
        //                        if (objDetalle.Accion == "NUEVO") // Insertar Detalle
        //                        {
        //                            contadorDet++;
        //                            objDetalle.Secuencia = secuenciaMax + contadorDet;
        //                            context.Entry(objDetalle).State = EntityState.Added;
        //                        }
        //                        else if (objDetalle.Accion == "UPDATEDETALLE") // Actualizar Detalle
        //                        {
        //                            context.Entry(objDetalle).State = EntityState.Modified;
        //                            mapSecuencia.Add("" + secuenciaAux, objDetalle.Secuencia);
        //                        }
        //                        else if (objDetalle.Accion == "DELETEDETALLE")  // Eliminar Detalle
        //                        {
        //                            context.Entry(objDetalle).State = EntityState.Deleted;
        //                        }

        //                    }

        //                }

        //                //** Agregado auditoria --> N° 3
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
        //                    objAudit = Control.AddAudita(new SS_HC_Referencia_FE(), new SS_HC_Referencia_FE(), DataKey, objAudit.Type);
        //                    objAudit.TableName = "SS_HC_Referencia_FE ";
        //                    objAudit.Type = objSC.Accion.Substring(0, 1);
        //                    objAudit.Accion = objSC.Accion;
        //                    contextEnty.Entry(objAudit).State = EntityState.Added;
        //                    contextEnty.SaveChanges();
        //                }
        //                //**

        //                /*******************************/

        //                context.SaveChanges();
        //                dbContextTransaction.Commit();


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

        public int setMantenimientoCabecera(SS_HC_Referencia_FE objSC)
        {
            int valorRetorno = -1; //ERROR
            using (var context = new ModelFormularios())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuencia = new Dictionary<String, int>();
                        if (objSC != null)
                        {

                            SS_HC_Referencia_FE objAnterior = null;
                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objAnterior = (from t in context.SS_HC_Referencia_FE
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
                                    context.Entry(objSC).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    objSC.IdReferencia = 1;
                                    context.Entry(objSC).State = EntityState.Added;
                                }

                            }
                            valorRetorno = 1;
                        }
                        else
                        {
                            //valorRetorno = -1;
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

        //Agregado auditoria --> N° 4
        public virtual String XMLString(List<SS_HC_Epicrisis_1_FE> obPadre, String TablaID)
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
