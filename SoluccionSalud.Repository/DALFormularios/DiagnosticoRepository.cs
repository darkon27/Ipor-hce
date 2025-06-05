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
    public class DiagnosticoRepository :AuditGenerico<SS_HC_Diagnostico, SS_HC_Diagnostico> 
    {
        public int setMantenimiento(SS_HC_Diagnostico ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                try {
                    iReturnValue = context.USP_Diagnostico(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                       ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.FechaRegistro,
                       ObjTrace.IdDiagnostico, ObjTrace.IdDiagnosticoValoracion, ObjTrace.DeterminacionDiagnostica,
                       ObjTrace.IdDiagnosticoPrincipal, ObjTrace.GradoAfeccion, ObjTrace.Observacion,
                       ObjTrace.IndicadorAntecedente, ObjTrace.TipoAntecedente, ObjTrace.IndicadorPreExistencia,
                       ObjTrace.IndicadorCronico, ObjTrace.IndicadorNuevo, ObjTrace.DetalleDiagnostico,
                       ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
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
        public List<SS_HC_Diagnostico> DiagnosticoListar(SS_HC_Diagnostico ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<SS_HC_Diagnostico> objLista = new List<SS_HC_Diagnostico>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista= context.USP_DiagnosticoListar(
                    ObjTrace.UnidadReplicacion,	ObjTrace.IdEpisodioAtencion,	
                    ObjTrace.IdPaciente,	ObjTrace.EpisodioClinico,	ObjTrace.Secuencia,	ObjTrace.FechaRegistro,	
                    ObjTrace.IdDiagnostico,	ObjTrace.IdDiagnosticoValoracion,	ObjTrace.DeterminacionDiagnostica,	
                    ObjTrace.IdDiagnosticoPrincipal,	ObjTrace.GradoAfeccion,	ObjTrace.Observacion,	
                    ObjTrace.IndicadorAntecedente,	ObjTrace.TipoAntecedente,	ObjTrace.IndicadorPreExistencia,	
                    ObjTrace.IndicadorCronico,	ObjTrace.IndicadorNuevo,	ObjTrace.DetalleDiagnostico,	
                    ObjTrace.Estado,	ObjTrace.UsuarioCreacion,	ObjTrace.FechaCreacion,	ObjTrace.UsuarioModificacion,	
                    ObjTrace.FechaModificacion,	ObjTrace.Accion,	ObjTrace.Version
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
                objAudit = AddAudita(new SS_HC_Diagnostico(), new SS_HC_Diagnostico(), DataKey, objAudit.Type);
                String xlmIn = XMLString(objLista, new List<SS_HC_Diagnostico>(), "SS_HC_Diagnostico");
                objAudit.TableName = "SS_HC_Diagnostico";
                objAudit.Type = tempType;
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;

        }

        public int setMantenimiento(SS_HC_Diagnostico ObjTraces, List<SS_HC_Diagnostico> listaCabecera,
     List<SS_HC_Diagnostico> listaDetalle)
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
                        foreach (var obj in listaDetalle)
                        {

                            var InformacionObj = (from t in context.SS_HC_Diagnostico
                                                  where t.IdPaciente == obj.IdPaciente
                                                  && t.EpisodioClinico == obj.EpisodioClinico
                                                  && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
                                                  && t.Secuencia == obj.Secuencia
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_Diagnostico();

                            iReturnValue = context.USP_Diagnostico(
                                obj.UnidadReplicacion, obj.IdEpisodioAtencion,
                                obj.IdPaciente, obj.EpisodioClinico, obj.Secuencia, obj.FechaRegistro,
                                obj.IdDiagnostico, obj.IdDiagnosticoValoracion, obj.DeterminacionDiagnostica,
                                obj.IdDiagnosticoPrincipal, obj.GradoAfeccion, obj.Observacion,
                                obj.IndicadorAntecedente, obj.TipoAntecedente, obj.IndicadorPreExistencia,
                                obj.IndicadorCronico, obj.IndicadorNuevo, obj.DetalleDiagnostico,
                                obj.Estado, obj.UsuarioCreacion, obj.FechaCreacion,
                                obj.UsuarioModificacion,
                                obj.FechaModificacion, obj.Accion, obj.Version
                            ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                            DataKey = new
                            {
                                UnidadReplicacion = obj.UnidadReplicacion,
                                IdEpisodioAtencion = obj.IdEpisodioAtencion,
                                EpisodioClinico = obj.EpisodioClinico,
                                IdPaciente = obj.IdPaciente,
                                Secuencia = obj.Secuencia
                            };
                            // Audit

                            objAudit = AddAudita(InformacionObj, obj, DataKey, obj.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_Diagnostico";
                            objAudit.Type = obj.Accion.Substring(0, 1);
                            context.Entry(objAudit).State = EntityState.Added;

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

        public SS_HC_Diagnostico obtenerPorId(SS_HC_Diagnostico objSC)
        {
            SS_HC_Diagnostico objResult = null;
            try
            {                
                using (var context = new WEB_ERPSALUDEntities())
                {
                    SS_HC_Diagnostico objConsulta = (from t in context.SS_HC_Diagnostico
                                                     where
                                                     t.UnidadReplicacion == objSC.UnidadReplicacion
                                                     && t.IdPaciente == objSC.IdPaciente
                                                     && t.EpisodioClinico == objSC.EpisodioClinico
                                                     && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                     && t.Secuencia == objSC.Secuencia
                                                     orderby t.Secuencia descending
                                                     select t).SingleOrDefault();

                    if (objConsulta != null)
                    {
                        objResult = objConsulta;
                    }
                }
            } catch(Exception ex){
            }    
            return objResult;
        }

    }

}
