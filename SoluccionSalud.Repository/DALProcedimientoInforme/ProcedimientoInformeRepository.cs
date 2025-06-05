using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;
namespace SoluccionSalud.Repository.DALProcedimientoInforme
{
    public class ProcedimientoInformeRepository : AuditGenerico<SS_HC_ProcedimientoInforme, SS_HC_ProcedimientoInforme> 
    {
        public List<SS_HC_ProcedimientoInforme> listarSS_HC_ProcedimientoInforme(SS_HC_ProcedimientoInforme objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_ProcedimientoInforme> objLista = new List<SS_HC_ProcedimientoInforme>();


            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_ProcedimientoInformeListar(
                        objSC.UnidadReplicacion
                        ,objSC.IdEpisodioAtencion
                        ,objSC.IdPaciente
                        ,objSC.EpisodioClinico
                        ,objSC.Secuencia
                        ,objSC.SecuenciaInforme
                        ,objSC.Nombre
                        ,objSC.RutaInforme
                        ,objSC.Estado
                        ,objSC.UsuarioCreacion
                        ,objSC.FechaCreacion
                        ,objSC.UsuarioModificacion
                        ,objSC.FechaModificacion
                        ,inicio
                        ,final
                        ,objSC.ACCION
 
                    ).ToList();
                
                DataKey = new
                {
                    UnidadReplicacion = objSC.UnidadReplicacion,
                    IdPaciente = objSC.IdPaciente,
                    EpisodioClinico = objSC.EpisodioClinico,
                    IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                    Secuencia = objSC.Secuencia                    
                };
                String xlmIn = XMLString(objLista, new List<SS_HC_ProcedimientoInforme>(), "SS_HC_ProcedimientoInforme");

                objAudit = AddAudita(new SS_HC_ProcedimientoInforme(), new SS_HC_ProcedimientoInforme(), DataKey, "L");
                objAudit.TableName = "SS_HC_ProcedimientoInforme";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
                
            }

            return objLista;
        }

        public int setMantenimientoDetalle(SS_HC_ProcedimientoEjecucion objExamen, List<SS_HC_ProcedimientoInforme> listaInformes)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue=0;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (objExamen!=null)
                        {
                            SS_HC_ProcedimientoEjecucion objAnterior = new SS_HC_ProcedimientoEjecucion();
                            if ((objExamen.ACCION.Substring(0, 1) != "I") || (objExamen.ACCION.Substring(0, 1) != "N"))
                            {

                                objAnterior = (from t in context.SS_HC_ProcedimientoEjecucion
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
                            if (objAnterior == null) objAnterior = new SS_HC_ProcedimientoEjecucion();
                            objAudit = AddAudita(objAnterior, objExamen, DataKey, objExamen.ACCION.Substring(0, 1));
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
                        else
                        {
                            valorRetorno = 1;
                        }

                        /*********/
                        if (valorRetorno > 0)
                        {
                            if (listaInformes != null)
                            {
                                foreach (var objSC in listaInformes)
                                {

                                    SS_HC_ProcedimientoInforme objAnteriorDet = new SS_HC_ProcedimientoInforme();
                                    if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                                    {

                                        objAnteriorDet = (from t in context.SS_HC_ProcedimientoInforme
                                                          where
                                                          t.UnidadReplicacion == objSC.UnidadReplicacion
                                                          && t.EpisodioClinico == objSC.EpisodioClinico
                                                          && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                          && t.IdPaciente == objSC.IdPaciente
                                                          && t.Secuencia == objSC.Secuencia
                                                          && t.SecuenciaInforme == objSC.SecuenciaInforme
                                                          orderby t.SecuenciaInforme descending
                                                          select t).SingleOrDefault();
                                    }

                                        iReturnValue = context.USP_SS_HC_ProcedimientoInforme(
                                        objSC.UnidadReplicacion
                                        , objSC.IdEpisodioAtencion
                                        , objSC.IdPaciente
                                        , objSC.EpisodioClinico
                                        , objSC.Secuencia
                                        , objSC.SecuenciaInforme
                                        , objSC.Nombre
                                        , objSC.RutaInforme
                                        , objSC.Estado
                                        , objSC.UsuarioCreacion
                                        , objSC.FechaCreacion
                                        , objSC.UsuarioModificacion
                                        , objSC.FechaModificacion
                                        , objSC.ACCION
                                        ).SingleOrDefault();

                                        //*  Registra Audit/
                                        DataKey = new
                                        {
                                            UnidadReplicacion = objSC.UnidadReplicacion,
                                            IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                                            IdPaciente = objSC.IdPaciente,
                                            EpisodioClinico = objSC.EpisodioClinico,
                                            Secuencia = objSC.Secuencia,
                                            SecuenciaInforme = iReturnValue
                                        };
                                        if (objAnteriorDet == null) objAnteriorDet = new SS_HC_ProcedimientoInforme();
                                        objAudit = AddAudita(objAnteriorDet, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                                        objAudit.TableName = "SS_HC_ProcedimientoInforme";
                                        objAudit.Type = objSC.ACCION.Substring(0, 1);
                                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                                        {
                                            if (objAudit.Type != "L")
                                            {
                                                context.Entry(objAudit).State = EntityState.Added;
                                                context.SaveChanges();
                                            }
                                        }
                                    
                                }
                            }
                        }
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
