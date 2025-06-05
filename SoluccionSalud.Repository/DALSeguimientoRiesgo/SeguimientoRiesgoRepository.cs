using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALSeguimientoRiesgo
{
    public class SeguimientoRiesgoRepository : AuditGenerico<SS_HC_SeguimientoRiesgo, SS_HC_SeguimientoRiesgoDetalle> 
    {

        public List<SS_HC_SeguimientoRiesgo> listarSeguimientoRiesgo(SS_HC_SeguimientoRiesgo objSC)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_SeguimientoRiesgo> objLista = new List<SS_HC_SeguimientoRiesgo>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista=  context.USP_SS_HC_SeguimientoRiesgoListar(objSC.UnidadReplicacion,objSC.IdEpisodioAtencion, 
                 objSC.IdPaciente,objSC.EpisodioClinico,objSC.IdTipoCuidadoPreventivo,
                objSC.FechaSeguimiento,objSC.Estado,objSC.UsuarioCreacion,objSC.FechaCreacion,
                objSC.UsuarioModificacion,objSC.FechaModificacion,objSC.Accion, objSC.Version).ToList();

                // Audit
                DataKey = new
                {
                    IdPaciente = objSC.IdPaciente,
                    IdEpisodioAtencion = objSC.IdEpisodioAtencion,
                    EpisodioClinico = objSC.EpisodioClinico,
                    UnidadReplicacion = objSC.UnidadReplicacion
                };

                String xlmIn = XMLString(objLista, new List<SS_HC_SeguimientoRiesgoDetalle>(), "SS_HC_SeguimientoRiesgo");
                objAudit = AddAudita(new SS_HC_SeguimientoRiesgo(), objSC, DataKey, "L");
                objAudit.TableName = "SS_HC_SeguimientoRiesgo";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }
            return objLista;
        }
        public int setMantenimiento(SS_HC_SeguimientoRiesgo objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_SeguimientoRiesgo(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                 objSC.IdPaciente, objSC.EpisodioClinico, objSC.IdTipoCuidadoPreventivo,
                objSC.FechaSeguimiento, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }

        /*****************************************/
        public int setMantenimiento(SS_HC_SeguimientoRiesgo ObjTraces, List<SS_HC_SeguimientoRiesgo> listaCabecera,
     List<SS_HC_SeguimientoRiesgoDetalle> listaDetalle)
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
                        foreach (var ObjTrace in listaCabecera)
                        {
                            var InformacionObj = (from t in context.SS_HC_SeguimientoRiesgo
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  && t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_SeguimientoRiesgo();

                            iReturnValue = context.USP_SS_HC_SeguimientoRiesgo(
                                ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                                 ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.IdTipoCuidadoPreventivo,
                                ObjTrace.FechaSeguimiento, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
                                ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
                            ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());


                            /***  Registra Audit  */
                            DataKey = new
                            {
                                UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                IdPaciente = ObjTrace.IdPaciente,
                                EpisodioClinico = ObjTrace.EpisodioClinico,
                                IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion                             
                            };
                            objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_SeguimientoRiesgo";
                            objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                            context.Entry(objAudit).State = EntityState.Added;
                            /******/

                            //detalle
                            foreach (var obj in listaDetalle)
                            {
                                var InformacionObjDet = (from t in context.SS_HC_SeguimientoRiesgoDetalle
                                                         where t.IdPaciente == obj.IdPaciente
                                                      && t.EpisodioClinico == obj.EpisodioClinico
                                                      && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
                                                      && t.UnidadReplicacion == obj.UnidadReplicacion
                                                      && t.Secuencia == obj.Secuencia
                                                      orderby t.IdEpisodioAtencion descending
                                                      select t).SingleOrDefault();
                                if (InformacionObjDet == null) InformacionObjDet = new SS_HC_SeguimientoRiesgoDetalle();

                                iReturnValue = context.USP_SS_HC_SeguimientoRiesgoDetalle(
                                    obj.UnidadReplicacion, obj.IdEpisodioAtencion,
                                 obj.IdPaciente, obj.EpisodioClinico, obj.Secuencia,
                                obj.IdCuidadoPreventivo, obj.Comentario, obj.Accion, obj.Version
                                ).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                /***  Registra Audit  */
                                DataKey = new
                                {
                                    UnidadReplicacion = obj.UnidadReplicacion,
                                    IdPaciente = obj.IdPaciente,
                                    EpisodioClinico = obj.EpisodioClinico,
                                    IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                    Secuencia = obj.Secuencia
                                };
                                objAudit = AddAudita(InformacionObjDet, obj, DataKey, obj.Accion.Substring(0, 1));
                                objAudit.TableName = "SS_HC_SeguimientoRiesgoDetalle";
                                objAudit.Type = obj.Accion.Substring(0, 1);
                                if (objAudit.Type != "L")
                                {
                                    context.Entry(objAudit).State = EntityState.Added;
                                    context.SaveChanges();
                                }
                                
                                /******/
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
            return valorRetorno;
        }						
    }
}
