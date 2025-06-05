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
    public class ExamenSolicitadoRepository : AuditGenerico<SS_HC_ExamenSolicitado, SS_HC_ExamenSolicitado> 
    {
        public int setMantenimiento(SS_HC_ExamenSolicitado ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                try
                {
                    iReturnValue = context.USP_ExamenSolicitado(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                        ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.IdProcedimiento,
                        ObjTrace.IdEspecialidad, ObjTrace.IdTipoExamen, ObjTrace.FechaSolitada, ObjTrace.Conceptos,
                        ObjTrace.CodigoComponente, ObjTrace.Observacion, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS,
                        ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                        ObjTrace.TipoCodigo, ObjTrace.CodigoSegus,
                        ObjTrace.Version, ObjTrace.Cantidad,
                        ObjTrace.Accion                        
                        ).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }

        public List<SS_HC_ExamenSolicitado> MedicamentoListar(SS_HC_ExamenSolicitado ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_ExamenSolicitado> objLista = new List<SS_HC_ExamenSolicitado>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_ExamenSolicitadoListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.IdProcedimiento,
                ObjTrace.IdEspecialidad, ObjTrace.IdTipoExamen, ObjTrace.FechaSolitada, ObjTrace.Conceptos,
                ObjTrace.CodigoComponente, ObjTrace.Observacion, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS,
                ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                ObjTrace.TipoCodigo, ObjTrace.CodigoSegus,
                ObjTrace.Version, ObjTrace.Cantidad,
                ObjTrace.Accion ,0,0
                ).ToList();

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
                objAudit = AddAudita(new SS_HC_ExamenSolicitado(), new SS_HC_ExamenSolicitado(), DataKey, objAudit.Type);
                String xlmIn = XMLString(objLista, new List<SS_HC_ExamenSolicitado>(), "SS_HC_ExamenSolicitado");
                objAudit.TableName = "SS_HC_ExamenSolicitado";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        
        public int setMantenimiento(SS_HC_ExamenSolicitado objSC, List<SS_HC_ExamenSolicitado> listaDetalle)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (var ObjTrace in listaDetalle)
                        {
                            var InformacionObj = (from t in context.SS_HC_ExamenSolicitado
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  && t.Secuencia == ObjTrace.Secuencia
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_ExamenSolicitado();


                            iReturnValue = context.USP_ExamenSolicitado(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                                ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.IdProcedimiento,
                                ObjTrace.IdEspecialidad, ObjTrace.IdTipoExamen, ObjTrace.FechaSolitada, ObjTrace.Conceptos,
                                ObjTrace.CodigoComponente, ObjTrace.Observacion, ObjTrace.TipoOrdenAtencion, ObjTrace.IndicadorEPS,
                                ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion,
                                ObjTrace.TipoCodigo, ObjTrace.CodigoSegus,
                                ObjTrace.Version, ObjTrace.Cantidad,
                                ObjTrace.Accion                                
                                ).SingleOrDefault();

                                DataKey = new
                                {
                                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                    EpisodioClinico = ObjTrace.EpisodioClinico,
                                    IdPaciente = ObjTrace.IdPaciente,
                                    Secuencia = ObjTrace.Secuencia
                                };
                                // Audit

                                objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                                objAudit.TableName = "SS_HC_ExamenSolicitado";
                                objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                context.Entry(objAudit).State = EntityState.Added;

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

