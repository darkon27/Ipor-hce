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

    public class ProximaAtencionRepository : AuditGenerico<SS_HC_ProximaAtencion, SS_HC_ProximaAtencion> 
    {
        public int ProximaAtencion(SS_HC_ProximaAtencion ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                try
                {
                    iReturnValue = context.USP_ProximaAtencion(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                        ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.ProximaAtencionFlag,
                        ObjTrace.FechaSolicitada, ObjTrace.FechaPlaneada, ObjTrace.IdEspecialidad, ObjTrace.IdEstablecimientoSalud,
                        ObjTrace.IdTipoInterConsulta, ObjTrace.IdTipoReferencia, ObjTrace.Observacion, ObjTrace.IdProcedimiento,
                        ObjTrace.CodigoComponente, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS, ObjTrace.Estado,
                        ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                        ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPersonalSalud,
                        ObjTrace.IdDiagnostico, ObjTrace.ProcedimientoText, ObjTrace.DiagnosticoText).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }
        public List<SS_HC_ProximaAtencion> ProximaAtencionListar(SS_HC_ProximaAtencion ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_ProximaAtencion> objLista = new List<SS_HC_ProximaAtencion>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_ProximaAtencionListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.ProximaAtencionFlag,
                    ObjTrace.FechaSolicitada, ObjTrace.FechaPlaneada, ObjTrace.IdEspecialidad, ObjTrace.IdEstablecimientoSalud,
                    ObjTrace.IdTipoInterConsulta, ObjTrace.IdTipoReferencia, ObjTrace.Observacion, ObjTrace.IdProcedimiento,
                    ObjTrace.CodigoComponente, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS, ObjTrace.Estado,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                    ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPersonalSalud,
                    ObjTrace.IdDiagnostico, ObjTrace.ProcedimientoText, ObjTrace.DiagnosticoText).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    Secuencia = ObjTrace.Secuencia
                };

                objAudit.Type = "V";
                if (objLista.Count > 1) objAudit.Type = "L";
                string tempType = objAudit.Type;
                objAudit = AddAudita(new SS_HC_ProximaAtencion(), new SS_HC_ProximaAtencion(), DataKey, objAudit.Type);
                String xlmIn = XMLString(objLista, new List<SS_HC_ProximaAtencion>(), "SS_HC_ProximaAtencion");
                objAudit.TableName = "SS_HC_ProximaAtencion";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;

        }

        public int setMantenimiento(SS_HC_ProximaAtencion ObjTrace, List<SS_HC_ProximaAtencion> listaDetalle, List<SS_HC_ProximaAtencionDiagnostico> listaDetalleDiag)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            SS_HC_ProximaAtencionDiagnostico objDetalle;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (ObjTrace != null)
                        {
                            var InformacionObj = (from t in context.SS_HC_ProximaAtencion
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  && t.Secuencia == ObjTrace.Secuencia
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_ProximaAtencion();

                            iReturnValue = context.USP_ProximaAtencion(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                                ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.ProximaAtencionFlag,
                                ObjTrace.FechaSolicitada, ObjTrace.FechaPlaneada, ObjTrace.IdEspecialidad, ObjTrace.IdEstablecimientoSalud,
                                ObjTrace.IdTipoInterConsulta, ObjTrace.IdTipoReferencia, ObjTrace.Observacion, ObjTrace.IdProcedimiento,
                                ObjTrace.CodigoComponente, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS, ObjTrace.Estado,
                                ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                                ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdPersonalSalud,
                                ObjTrace.IdDiagnostico, ObjTrace.ProcedimientoText, ObjTrace.DiagnosticoText).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());                            //detalle
                            int secuenciaReg = Convert.ToInt32(iReturnValue.ToString().Trim());                            //detalle
                            DataKey = new
                            {
                                UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                EpisodioClinico = ObjTrace.EpisodioClinico,
                                IdPaciente = ObjTrace.IdPaciente,
                                Secuencia = ObjTrace.Secuencia,
                                ProximaAtencionFlag = ObjTrace.ProximaAtencionFlag
                            };
                            // Audit

                            objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_ProximaAtencion";
                            objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                            context.Entry(objAudit).State = EntityState.Added;


                            if (listaDetalle!=null)
                            {
                                foreach (var obj in listaDetalle)
                                {
                                    int tempoCod = 0;
                                    if (obj.Version!= null) tempoCod =Convert.ToInt32(obj.Version.Trim());

                                    var InformacionObjDell = (from t in context.SS_HC_ProximaAtencionDiagnostico
                                                              where t.IdPaciente == obj.IdPaciente
                                                              && t.EpisodioClinico == obj.EpisodioClinico
                                                              && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
                                                              && t.Secuencia == obj.Secuencia
                                                              && t.SecuenciaProximaAtencion == tempoCod
                                                              orderby t.IdEpisodioAtencion descending
                                                              select t).SingleOrDefault();
                                    if (InformacionObjDell == null) InformacionObjDell = new SS_HC_ProximaAtencionDiagnostico();

                                    objDetalle = new SS_HC_ProximaAtencionDiagnostico();
                                    objDetalle.UnidadReplicacion = obj.UnidadReplicacion;
                                    objDetalle.IdPaciente = obj.IdPaciente;
                                    objDetalle.EpisodioClinico = obj.EpisodioClinico;
                                    objDetalle.IdEpisodioAtencion = obj.IdEpisodioAtencion;
                                    objDetalle.Secuencia = obj.Secuencia;
                                    objDetalle.SecuenciaProximaAtencion = tempoCod;
                                    objDetalle.UnidadReplicacion = obj.UnidadReplicacion;
                                    objDetalle.IdDiagnostico = obj.IdProcedimiento;

                                    obj.Secuencia = secuenciaReg;
                                    iReturnValue = context.USP_ProximaAtencion(obj.UnidadReplicacion, obj.IdEpisodioAtencion,
                                        obj.IdPaciente, obj.EpisodioClinico, obj.Secuencia, obj.ProximaAtencionFlag,
                                        obj.FechaSolicitada, obj.FechaPlaneada, obj.IdEspecialidad, obj.IdEstablecimientoSalud,
                                        obj.IdTipoInterConsulta, obj.IdTipoReferencia, obj.Observacion, obj.IdProcedimiento,
                                        obj.CodigoComponente, obj.TipoOrdenAtencion, obj.IndicadorEPS, obj.Estado,
                                        obj.UsuarioCreacion, obj.FechaCreacion, obj.UsuarioModificacion, obj.FechaModificacion,
                                        obj.Accion, obj.Version, ObjTrace.IdPersonalSalud,
                                        obj.IdDiagnostico, obj.ProcedimientoText, obj.DiagnosticoText).SingleOrDefault();
                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());   
                                    //detalle
                                    DataKey = new
                                    {
                                        UnidadReplicacion = obj.UnidadReplicacion,
                                        IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                        EpisodioClinico = obj.EpisodioClinico,
                                        IdPaciente = obj.IdPaciente,
                                        Secuencia = obj.Secuencia,
                                        SecuenciaProximaAtencion = tempoCod
                                    };
                                    // Audit
                                    if (obj.Accion == "DETALLE") obj.Accion = "N";
                                    objAudit = AddAudita(InformacionObjDell, objDetalle, DataKey, obj.Accion.Substring(0, 1));
                                    objAudit.TableName = "SS_HC_ProximaAtencionDiagnostico";
                                    objAudit.Type = obj.Accion.Substring(0, 1);
                                    context.Entry(objAudit).State = EntityState.Added;
                                }
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

    }
}
