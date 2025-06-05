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

    public class MedicamentoRepository : AuditGenerico<SS_HC_Medicamento, SS_HC_Medicamento> 
    {
        public int setMantenimiento(SS_HC_Medicamento ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                try
                {
                    iReturnValue = context.USP_SS_GE_Medicamento(
                        ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                       ObjTrace.EpisodioClinico,
                       ObjTrace.IdEpisodioAtencion,
                       ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                       ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                       ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                       ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                       ObjTrace.Forma,  ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                       ObjTrace.TipoComida, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                       ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return valorRetorno;
        }

        public List<SS_HC_Medicamento> MedicamentoListar(SS_HC_Medicamento ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Medicamento> objLista = new List<SS_HC_Medicamento>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                 objLista = context.USP_SS_GE_MedicamentoListar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico,
                    ObjTrace.IdEpisodioAtencion,
                    ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                    ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                    ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                    ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                    ObjTrace.Forma, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                    ObjTrace.TipoComida, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    Secuencia = ObjTrace.Secuencia,
                    TipoMedicamento = ObjTrace.TipoMedicamento

                };

                objAudit.Type = "V";
                if (objLista.Count > 1) objAudit.Type = "L";
                string tempType = objAudit.Type;
                objAudit = AddAudita(new SS_HC_Medicamento(), new SS_HC_Medicamento(), DataKey, objAudit.Type);
                String xlmIn = XMLString(objLista, new List<SS_HC_Medicamento>(), "SS_HC_Medicamento");
                objAudit.TableName = "SS_HC_Medicamento";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }
            return objLista;
        }
        public int MedicamentoIndicaciones(SS_HC_Indicaciones ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_Indicaciones(
                    ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.IdEpisodioAtencion, ObjTrace.SecuenciaMedicamento, ObjTrace.Secuencia, ObjTrace.TipoRegistro, ObjTrace.Correlativo, 
                    ObjTrace.IdTipoIndicacion, ObjTrace.Descripcion, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, 
                    ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }

            return valorRetorno;
        }

        public List<SS_HC_Indicaciones> MedicamentoIndicacionesListar(SS_HC_Indicaciones ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Indicaciones> objLista = new List<SS_HC_Indicaciones>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_IndicacionesListar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.IdEpisodioAtencion, ObjTrace.SecuenciaMedicamento, ObjTrace.Secuencia, ObjTrace.TipoRegistro, ObjTrace.Correlativo,
                    ObjTrace.IdTipoIndicacion, ObjTrace.Descripcion, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion,
                    ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();
                DataKey = new
                {
                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,
                    IdPaciente = ObjTrace.IdPaciente,
                    SecuenciaMedicamento = ObjTrace.SecuenciaMedicamento,
                    Secuencia = ObjTrace.Secuencia
                };
                SS_HC_Medicamento objFiltro= new SS_HC_Medicamento();
                objFiltro.UnidadReplicacion = ObjTrace.UnidadReplicacion;
                objFiltro.IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion;
                objFiltro.EpisodioClinico = ObjTrace.EpisodioClinico;
                objFiltro.IdPaciente = ObjTrace.IdPaciente;
                objFiltro.Secuencia = ObjTrace.SecuenciaMedicamento;
                List<SS_HC_Medicamento> listaFiltro = new List<SS_HC_Medicamento>();
                listaFiltro.Add(objFiltro);

                objAudit.Type = "V";
                if (objLista.Count > 1) objAudit.Type = "L";
                string tempType = objAudit.Type;
                objAudit = AddAudita(new SS_HC_Indicaciones(), new SS_HC_Indicaciones(), DataKey, objAudit.Type);
                String xlmIn = XMLString(listaFiltro, new List<SS_HC_Medicamento>(), "SS_HC_Indicaciones");
                objAudit.TableName = "SS_HC_Indicaciones";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }
            return objLista;
        }


        public int setMantenimiento(SS_HC_Medicamento ObjTraces, List<SS_HC_Medicamento> listaCabecera01,
            List<SS_HC_Medicamento> listaCabecera02,
            List<SS_HC_Indicaciones> listaTraceDetalle01, List<SS_HC_Indicaciones> listaDetalle01)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            //ADD PROVISIONALMENTE
            String FORMATO_ACTUAL = ENTITY_GLOBAL.Instance.CONCEPTO;

            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaCabecera01!=null)
                        {
                            foreach (var ObjTrace in listaCabecera01)
                            {
                                var InformacionObj = (from t in context.SS_HC_Medicamento
                                                      where t.IdPaciente == ObjTrace.IdPaciente
                                                      && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                      && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                      && t.Secuencia == ObjTrace.Secuencia
                                                      orderby t.IdEpisodioAtencion descending
                                                      select t).SingleOrDefault();
                                if (InformacionObj == null) InformacionObj = new SS_HC_Medicamento();

                                var secuenciaCabPrevia = ObjTrace.Secuencia;
                                iReturnValue = context.USP_SS_GE_Medicamento(
                                    ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                   ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                   ObjTrace.Forma, ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                   ObjTrace.TipoComida, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                   ObjTrace.FechaModificacion, ObjTrace.Accion, FORMATO_ACTUAL
                                ).SingleOrDefault();

                                int secuenciaMedico = Convert.ToInt32(iReturnValue.ToString().Trim());
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                                DataKey = new
                                {
                                    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                                    EpisodioClinico = ObjTrace.EpisodioClinico,
                                    IdPaciente = ObjTrace.IdPaciente,
                                    Secuencia = ObjTrace.Secuencia,
                                    TipoMedicamento = ObjTrace.TipoMedicamento
                                };
                                // Audit

                                objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                                objAudit.TableName = "SS_HC_Medicamento";
                                objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                                context.Entry(objAudit).State = EntityState.Added;

                                
                                //detalle
                                if (listaTraceDetalle01 != null)
                                {
                                    foreach (var ObjTraceDetalle01 in listaTraceDetalle01)
                                    {
                                        if (ObjTraceDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
                                        {
                                            var InformacionObjDell = (from t in context.SS_HC_Indicaciones
                                                                  where t.IdPaciente == ObjTraceDetalle01.IdPaciente
                                                                  && t.EpisodioClinico == ObjTraceDetalle01.EpisodioClinico
                                                                  && t.IdEpisodioAtencion == ObjTraceDetalle01.IdEpisodioAtencion
                                                                  && t.SecuenciaMedicamento == ObjTraceDetalle01.SecuenciaMedicamento
                                                                  && t.Secuencia == ObjTraceDetalle01.Secuencia

                                                                  orderby t.IdEpisodioAtencion descending
                                                                  select t).SingleOrDefault();
                                            if (InformacionObjDell == null) InformacionObjDell = new SS_HC_Indicaciones();
 
                                            ObjTraceDetalle01.SecuenciaMedicamento = secuenciaMedico;
                                            iReturnValue = context.USP_Indicaciones(
                                            ObjTraceDetalle01.UnidadReplicacion, ObjTraceDetalle01.IdPaciente,
                                            ObjTraceDetalle01.EpisodioClinico, ObjTraceDetalle01.IdEpisodioAtencion, ObjTraceDetalle01.SecuenciaMedicamento, ObjTraceDetalle01.Secuencia, ObjTraceDetalle01.TipoRegistro, ObjTraceDetalle01.Correlativo,
                                            ObjTraceDetalle01.IdTipoIndicacion, ObjTraceDetalle01.Descripcion, ObjTraceDetalle01.Estado, ObjTraceDetalle01.UsuarioCreacion, ObjTraceDetalle01.FechaCreacion,
                                            ObjTraceDetalle01.UsuarioModificacion, ObjTraceDetalle01.FechaModificacion, ObjTraceDetalle01.Accion, ObjTraceDetalle01.Version).SingleOrDefault();
                                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                            DataKey = new
                                            {
                                                UnidadReplicacion = ObjTraceDetalle01.UnidadReplicacion,
                                                IdEpisodioAtencion = ObjTraceDetalle01.IdEpisodioAtencion,
                                                EpisodioClinico = ObjTraceDetalle01.EpisodioClinico,
                                                IdPaciente = ObjTraceDetalle01.IdPaciente,
                                                SecuenciaMedicamento =  ObjTraceDetalle01.SecuenciaMedicamento,
                                                Secuencia = ObjTraceDetalle01.Secuencia
                                               

                                            };
                                            objAudit = AddAudita(InformacionObjDell, ObjTraceDetalle01, DataKey, ObjTraceDetalle01.Accion.Substring(0, 1));
                                            objAudit.TableName = "SS_HC_Indicaciones";
                                            objAudit.Type = ObjTraceDetalle01.Accion.Substring(0, 1);
                                            context.Entry(objAudit).State = EntityState.Added;
                                        }
                                    }
                                }
                                
                                if (listaDetalle01!=null)
                                {
                                    foreach (var objDetalle01 in listaDetalle01)
                                    {
                                        if (objDetalle01.SecuenciaMedicamento == secuenciaCabPrevia)
                                        {
                                            objDetalle01.SecuenciaMedicamento = secuenciaMedico;
                                            iReturnValue = context.USP_Indicaciones(
                                                objDetalle01.UnidadReplicacion, objDetalle01.IdPaciente,
                                                objDetalle01.EpisodioClinico, objDetalle01.IdEpisodioAtencion, objDetalle01.SecuenciaMedicamento, objDetalle01.Secuencia, objDetalle01.TipoRegistro, objDetalle01.Correlativo,
                                                objDetalle01.IdTipoIndicacion, objDetalle01.Descripcion, objDetalle01.Estado, objDetalle01.UsuarioCreacion, objDetalle01.FechaCreacion,
                                                objDetalle01.UsuarioModificacion, objDetalle01.FechaModificacion, objDetalle01.Accion, objDetalle01.Version).SingleOrDefault();
                                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());                                        
                                        }

                                    }
                                }
                            }
                        }
                        if (listaCabecera02!=null)
                        {
                            foreach (var ObjTrace in listaCabecera02)
                            {
                                iReturnValue = context.USP_SS_GE_Medicamento(
                                    ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente,
                                   ObjTrace.EpisodioClinico,
                                   ObjTrace.IdEpisodioAtencion,
                                   ObjTrace.Secuencia, ObjTrace.TipoMedicamento, ObjTrace.IdUnidadMedida,
                                   ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.TipoComponente,
                                   ObjTrace.CodigoComponente, ObjTrace.IdVia, ObjTrace.Dosis, ObjTrace.DiasTratamiento,
                                   ObjTrace.Frecuencia, ObjTrace.Cantidad, ObjTrace.IndicadorEPS, ObjTrace.TipoReceta,
                                   ObjTrace.Forma,  ObjTrace.Comentario, ObjTrace.IndicadorAuditoria, ObjTrace.UsuarioAuditoria,
                                   ObjTrace.TipoComida, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
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
    }
}


