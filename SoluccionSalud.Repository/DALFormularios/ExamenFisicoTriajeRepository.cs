using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace SoluccionSalud.Repository.DALFormularios
{

    public class ExamenFisicoTriajeRepository : AuditGenerico<SS_HC_ExamenFisico_Triaje, SS_HC_ExamenFisico_Triaje> 
    {
        public int setMantenimiento(SS_HC_ExamenFisico_Triaje ObjTrace)
        {
            //  Aquiles MH  : 09/07/2015
            //  Eventos     : Transacciones
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                         var InformacionObj = (from t in context.SS_HC_ExamenFisico_Triaje
                                                          where t.IdPaciente == ObjTrace.IdPaciente
                                                          && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                          && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                          orderby t.IdEpisodioAtencion descending
                                                     select t).SingleOrDefault();
                                if (InformacionObj ==null) InformacionObj = new SS_HC_ExamenFisico_Triaje();

                          iReturnValue = context.USP_ExamenFisico_Triaje(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                           ObjTrace.EpisodioClinico, ObjTrace.PresionMinima, ObjTrace.PresionMaxima, ObjTrace.FrecuenciaRespiratoria,
                           ObjTrace.FrecuenciaCardiaca, ObjTrace.Temperatura, ObjTrace.Peso, ObjTrace.Talla, ObjTrace.IndiceMasaCorporal,
                           ObjTrace.IdEstadoGeneral, ObjTrace.IdNutricion, ObjTrace.IdHidratacion, ObjTrace.IdColaboracion, ObjTrace.ObservacionesAdicionales,
                           ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                           ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();

                        //*  Registra Audit/
                          DataKey = new {
                              UnidadReplicacion = ObjTrace.UnidadReplicacion, 
                              IdPaciente = ObjTrace.IdPaciente, 
                              EpisodioClinico = ObjTrace.EpisodioClinico, 
                              IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion 
                          };
                          objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                          objAudit.TableName = "SS_HC_ExamenFisico_Triaje";
                          objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                          context.Entry(objAudit).State = EntityState.Added;
                        //*
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

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

        public int setExamenFisicoRegional(SS_HC_ExamenFisico_Regional ObjTrace)
        {
            //  Aquiles MH  : 09/07/2015
            //  Eventos     : Transacciones

            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        var InformacionObj = (from t in context.SS_HC_ExamenFisico_Regional
                                              where t.IdPaciente == ObjTrace.IdPaciente
                                              && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                              && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                              orderby t.IdEpisodioAtencion descending
                                              select t).SingleOrDefault();
                        if (InformacionObj == null) InformacionObj = new SS_HC_ExamenFisico_Regional();

                        iReturnValue = context.USP_ExamenFisicoRegional(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                        ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.IdCuerpoHumano, ObjTrace.Comentarios, ObjTrace.Estado,
                        ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                        ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        //*  Registra Audit/
                        DataKey = new { IdPaciente = ObjTrace.IdPaciente, EpisodioClinico = ObjTrace.EpisodioClinico, IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion };
                        objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_ExamenFisico_Regional";
                        objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                        context.Entry(objAudit).State = EntityState.Added;
                        //*
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

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
 
        
        public List<SS_HC_ExamenFisico_Triaje> ExamenFisicoTriajeListar(SS_HC_ExamenFisico_Triaje ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_ExamenFisico_Triaje> objLista = new List<SS_HC_ExamenFisico_Triaje>();
            try
            {
                using (var context = new WEB_ERPSALUDEntities())
                {
                    objLista= context.USP_ExamenFisicoTriajeListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                        ObjTrace.EpisodioClinico, ObjTrace.PresionMinima, ObjTrace.PresionMaxima, ObjTrace.FrecuenciaRespiratoria,
                        ObjTrace.FrecuenciaCardiaca, ObjTrace.Temperatura, ObjTrace.Peso, ObjTrace.Talla, ObjTrace.IndiceMasaCorporal,
                        ObjTrace.IdEstadoGeneral, ObjTrace.IdNutricion, ObjTrace.IdHidratacion, ObjTrace.IdColaboracion, ObjTrace.ObservacionesAdicionales,
                        ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                        ObjTrace.Accion, ObjTrace.Version).ToList();
                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdPaciente = ObjTrace.IdPaciente,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion

                    };
                    objAudit.Type = "V";
                    if (objLista.Count > 1) objAudit.Type = "L";
                    objAudit = AddAudita(new SS_HC_ExamenFisico_Triaje(), new SS_HC_ExamenFisico_Triaje(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, new List<SS_HC_ExamenFisico_Triaje>(), "SS_HC_ExamenFisico_Triaje");
                    objAudit.TableName = "SS_HC_ExamenFisico_Triaje";
                    objAudit.Type = "V";
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();
                }
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }	
        }

        public int setMantenimiento(SS_HC_ExamenFisico_Regional ObjTraces, List<SS_HC_ExamenFisico_Regional> listaCabecera,
            List<SS_HC_ExamenFisico_Regional> listaDetalle)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {

                        foreach (var obj in listaDetalle)
                        {
                            var InformacionObj = (from t in context.SS_HC_ExamenFisico_Regional
                                                  where t.IdPaciente == obj.IdPaciente
                                                  && t.EpisodioClinico == obj.EpisodioClinico
                                                  && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
                                                  && t.Secuencia == obj.Secuencia
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_ExamenFisico_Regional();

                            iReturnValue = context.USP_ExamenFisicoRegional(obj.UnidadReplicacion, obj.IdEpisodioAtencion,
                            obj.IdPaciente, obj.EpisodioClinico, obj.Secuencia, obj.IdCuerpoHumano, obj.Comentarios, obj.Estado,
                            obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion,
                            obj.FechaModificacion, obj.Accion, obj.Version).SingleOrDefault();

                            //*  Registra Audit   * /
                            DataKey = new {
                                IdPaciente = obj.IdPaciente, 
                                EpisodioClinico = obj.EpisodioClinico, 
                                IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                Secuencia = obj.Secuencia 
                            };
                            objAudit = AddAudita(InformacionObj, obj, DataKey, obj.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_ExamenFisico_Regional";
                            objAudit.Type = obj.Accion.Substring(0, 1);
                            context.Entry(objAudit).State = EntityState.Added;
                            //*/
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

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
    }
}
