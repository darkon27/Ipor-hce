using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALProcedimientoEjecucion
{
    public class ProcedimientoEjecucionRepository : AuditGenerico<SS_HC_ProcedimientoEjecucion, SS_HC_ProcedimientoEjecucion> 
    {
        public List<SS_HC_ProcedimientoEjecucion> listarSS_HC_ProcedimientoEjecucion(SS_HC_ProcedimientoEjecucion objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_ProcedimientoEjecucion> objLista = new List<SS_HC_ProcedimientoEjecucion>();


            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_ProcedimientoEjecucionListar(
                    objSC.UnidadReplicacion
                    ,objSC.IdEpisodioAtencion
                    ,objSC.IdPaciente
                    ,objSC.EpisodioClinico
                    ,objSC.Secuencia
                    ,objSC.UnidadReplicacionSolicitado
                    ,objSC.IdEpisodioAtencionSolicitado
                    ,objSC.IdPacienteSolicitado
                    ,objSC.EpisodioClinicoSolicitado
                    ,objSC.SecuenciaSolicitado
                    ,objSC.IdProcedimiento
                    ,objSC.CodigoComponente
                    ,objSC.FechaSolicitud
                    ,objSC.FechaProcedimiento
                    ,objSC.FechaInicio
                    ,objSC.FechaFin
                    ,objSC.FechaInforme
                    ,objSC.IndicadorPreparacion
                    ,objSC.IndicadorAutorizacion
                    ,objSC.Medico
                    ,objSC.Observacion
                    ,objSC.TipoAlta
                    ,objSC.FechaAlta
                    ,objSC.IdMedicoAutoriza
                    ,objSC.ObservacionAlta
                    ,objSC.UsuarioCreacion
                    ,objSC.FechaCreacion
                    ,objSC.UsuarioModificacion
                    ,objSC.FechaModificacion                                        
                    ,objSC.TipoCodigo
                    , inicio
                    , final
                    ,objSC.ACCION).ToList();
                /*
                DataKey = new
                {
                    Secuencia = objSC.Secuencia
                };
                String xlmIn = XMLString(objLista, new List<SS_HC_ProcedimientoEjecucion>(), "SS_HC_ProcedimientoEjecucion");

                objAudit = AddAudita(new SS_HC_ProcedimientoEjecucion(), new SS_HC_ProcedimientoEjecucion(), DataKey, "L");
                objAudit.TableName = "SS_HC_Procedimiento";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
                */
            }

            return objLista;
        }

        public long setMantenimientoDetalle(SS_HC_EpisodioAtencion objSC, List<SS_HC_ProcedimientoEjecucion> listaExamenes)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<long> iReturnValue;
            long valorRetornoEpiAtencion = 0; 
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_EpisodioAtencion objAnterior = new SS_HC_EpisodioAtencion();
                        if (objSC.Accion != "EPISODIOCLINICO")
                        {
                            objAnterior = (from t in context.SS_HC_EpisodioAtencion
                                           where t.UnidadReplicacion == objSC.UnidadReplicacion
                                           && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                          && t.EpisodioClinico == objSC.EpisodioClinico
                                          && t.IdPaciente == objSC.IdPaciente
                                           orderby t.IdEpisodioAtencion descending
                                           select t).SingleOrDefault();
                        }

                        iReturnValue = context.USP_SS_HC_EpisodioAtencion(
                            objSC.UnidadReplicacion
                            , objSC.IdEpisodioAtencion
                            , objSC.UnidadReplicacionEC
                            , objSC.IdPaciente
                            , objSC.EpisodioClinico
                            , objSC.IdEstablecimientoSalud
                            , objSC.IdUnidadServicio
                            , objSC.IdPersonalSalud
                            , null
                            , objSC.EpisodioAtencion
                            , objSC.FechaRegistro
                            , objSC.FechaAtencion
                            , objSC.TipoAtencion
                            , objSC.IdOrdenAtencion
                            , objSC.LineaOrdenAtencion
                            , objSC.TipoOrdenAtencion
                            , objSC.Estado
                            , objSC.UsuarioCreacion
                            , objSC.FechaCreacion
                            , objSC.UsuarioModificacion
                            , objSC.FechaModificacion
                            , objSC.IdEspecialidad
                            , objSC.CodigoOA
                            , objSC.ProximaAtencionFlag
                            , objSC.IdEspecialidadProxima
                            , objSC.IdEstablecimientoSaludProxima
                            , objSC.IdTipoInterConsulta
                            , objSC.IdTipoReferencia
                            , objSC.ObservacionProxima
                            , objSC.DescansoMedico
                            , objSC.DiasDescansoMedico
                            , objSC.FechaInicioDescansoMedico
                            , objSC.FechaFinDescansoMedico
                            , objSC.FechaOrden
                            , objSC.IdProcedimiento
                            , objSC.ObservacionOrden
                            , objSC.IdTipoOrden
                            , objSC.Version
                            , objSC.FlagFirma
                            , objSC.FechaFirma
                            , objSC.idMedicoFirma
                            , objSC.ObservacionFirma
                            , objSC.KeyPrivada
                            , objSC.KeyPublica
                            , objSC.TipoTrabajador
                            , objSC.TipoEpisodio
                            , objSC.TipoUbicacion
                            , objSC.IdUbicacion
                            , objSC.Accion
                            ).SingleOrDefault();
                        valorRetornoEpiAtencion = Convert.ToInt64(iReturnValue);
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString());
                        var IdEpisodioAtencionAux = iReturnValue;
                        if (objSC.Accion != "EPISODIOCLINICO")
                        {
                            //*  Registra Audit/
                            DataKey = new
                            {
                                UnidadReplicacion = objSC.UnidadReplicacion,
                                IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                IdPaciente = objSC.IdPaciente,
                                EpisodioClinico = objSC.EpisodioClinico
                            };
                            if (objAnterior == null) objAnterior = new SS_HC_EpisodioAtencion();
                            objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_EpisodioAtencion";
                            if (objSC.Accion == "INSERT" || objSC.Accion == "CONTINUAR")
                            {
                                objAudit.Type = "I";
                            }
                            else
                            {
                                objAudit.Type = "U";
                            }
                            if (valorRetorno > 0)
                            {
                                if (objAudit.Type != "L")
                                {
                                    context.Entry(objAudit).State = EntityState.Added;
                                    context.SaveChanges();
                                }
                            }
                        } 

                        /*********/
                        if (valorRetorno>0)
                        {                            
                            if (listaExamenes!=null)
                            {
                                foreach (var objExamen in listaExamenes)
                                {
                                    objExamen.IdEpisodioAtencion = Convert.ToInt64(IdEpisodioAtencionAux);
                                    SS_HC_ProcedimientoEjecucion objAnteriorDet = new SS_HC_ProcedimientoEjecucion();
                                    if ((objExamen.ACCION.Substring(0, 1) != "I") || (objExamen.ACCION.Substring(0, 1) != "N"))
                                    {
                                        objAnteriorDet = (from t in context.SS_HC_ProcedimientoEjecucion
                                                       where
                                                       t.UnidadReplicacion == objExamen.UnidadReplicacion
                                                       && t.EpisodioClinico == objExamen.EpisodioClinico
                                                       && t.IdEpisodioAtencion == objExamen.IdEpisodioAtencion
                                                       && t.IdPaciente == objExamen.IdPaciente
                                                       && t.Secuencia == objExamen.Secuencia
                                                       orderby t.Secuencia descending
                                                       select t).SingleOrDefault();
                                    }
                                    iReturnValue = context.USP_SS_HC_ProcedimientoEjecucion(
                                            objExamen.UnidadReplicacion
                                            , objExamen.IdEpisodioAtencion
                                            , objExamen.IdPaciente
                                            , objExamen.EpisodioClinico
                                            , objExamen.Secuencia
                                            , objExamen.UnidadReplicacionSolicitado
                                            , objExamen.IdEpisodioAtencionSolicitado
                                            , objExamen.IdPacienteSolicitado
                                            , objExamen.EpisodioClinicoSolicitado
                                            , objExamen.SecuenciaSolicitado
                                            , objExamen.IdProcedimiento
                                            , objExamen.CodigoComponente
                                            , objExamen.FechaSolicitud
                                            , objExamen.FechaProcedimiento
                                            , objExamen.FechaInicio
                                            , objExamen.FechaFin
                                            , objExamen.FechaInforme
                                            , objExamen.IndicadorPreparacion
                                            , objExamen.IndicadorAutorizacion
                                            , objExamen.Medico
                                            , objExamen.Observacion
                                            , objExamen.TipoAlta
                                            , objExamen.FechaAlta
                                            , objExamen.IdMedicoAutoriza
                                            , objExamen.ObservacionAlta
                                            , objExamen.UsuarioCreacion
                                            , objExamen.FechaCreacion
                                            , objExamen.UsuarioModificacion
                                            , objExamen.FechaModificacion
                                            , objExamen.TipoCodigo
                                            , objExamen.ACCION

                                        ).SingleOrDefault();

                                    //*  Registra Audit/
                                    DataKey = new
                                    {
                                        UnidadReplicacion = objExamen.UnidadReplicacion,
                                        IdEpisodioAtencion = objExamen.IdEpisodioAtencion,
                                        IdPaciente = objExamen.IdPaciente,
                                        EpisodioClinico = objExamen.EpisodioClinico,
                                        Secuencia = objExamen.Secuencia
                                    };
                                    if (objAnteriorDet == null) objAnteriorDet = new SS_HC_ProcedimientoEjecucion();
                                    objAudit = AddAudita(objAnteriorDet, objExamen, DataKey, objExamen.ACCION.Substring(0, 1));
                                    objAudit.TableName = "SS_HC_ProcedimientoEjecucion";
                                    objAudit.Type = objExamen.ACCION.Substring(0, 1);
                                    if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                                    {
                                        if (objAudit.Type != "L")
                                        {
                                            context.Entry(objAudit).State = EntityState.Added;
                                            context.SaveChanges();
                                        }
                                    }

                                    //*/
                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                }
                            }
                        }        

                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetornoEpiAtencion;
        }
        public int setMantenimiento(SS_HC_ProcedimientoEjecucion objSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_ProcedimientoEjecucion objAnterior = new SS_HC_ProcedimientoEjecucion();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_ProcedimientoEjecucion
                                           where
                                           t.UnidadReplicacion == objSC.UnidadReplicacion
                                           && t.EpisodioClinico == objSC.EpisodioClinico
                                           && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                           && t.IdPaciente == objSC.IdPaciente
                                           && t.Secuencia == objSC.Secuencia


                                           orderby t.Secuencia descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_ProcedimientoEjecucion(                            
                                objSC.UnidadReplicacion
                                ,objSC.IdEpisodioAtencion
                                ,objSC.IdPaciente
                                ,objSC.EpisodioClinico
                                ,objSC.Secuencia
                                ,objSC.UnidadReplicacionSolicitado
                                ,objSC.IdEpisodioAtencionSolicitado
                                ,objSC.IdPacienteSolicitado
                                ,objSC.EpisodioClinicoSolicitado
                                ,objSC.SecuenciaSolicitado
                                ,objSC.IdProcedimiento
                                ,objSC.CodigoComponente
                                ,objSC.FechaSolicitud
                                ,objSC.FechaProcedimiento
                                ,objSC.FechaInicio
                                ,objSC.FechaFin
                                ,objSC.FechaInforme
                                ,objSC.IndicadorPreparacion
                                ,objSC.IndicadorAutorizacion
                                ,objSC.Medico
                                ,objSC.Observacion
                                ,objSC.TipoAlta
                                ,objSC.FechaAlta
                                ,objSC.IdMedicoAutoriza
                                ,objSC.ObservacionAlta
                                ,objSC.UsuarioCreacion
                                ,objSC.FechaCreacion
                                ,objSC.UsuarioModificacion
                                ,objSC.FechaModificacion
                                , objSC.TipoCodigo
                                ,objSC.ACCION
                            
                            ).SingleOrDefault();

                        //*  Registra Audit/
                        DataKey = new
                        {
                            UnidadReplicacion = objSC.UnidadReplicacion,
                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                            IdPaciente = objSC.IdPaciente,
                            EpisodioClinico = objSC.EpisodioClinico,
                            Secuencia = objSC.Secuencia
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_ProcedimientoEjecucion();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                        objAudit.TableName = "SS_HC_ProcedimientoEjecucion";
                        objAudit.Type = objSC.ACCION.Substring(0, 1);
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
                            }
                        }

                        //*/
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
    }
}
