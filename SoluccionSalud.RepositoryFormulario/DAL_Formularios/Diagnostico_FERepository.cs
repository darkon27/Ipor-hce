using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.ModelERP_FORM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{

    public class Diagnostico_FERepository
    {

        //public int setMantenimiento(SS_HC_Diagnostico_FE ObjTrace)
        //{
        //    System.Nullable<int> iReturnValue;
        //    int valorRetorno = 0;
        //    using (var context = new WEB_ERPSALUDEntities())
        //    {
        //        try
        //        {
        //            iReturnValue = context.USP_Diagnostico(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
        //               ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.FechaRegistro,
        //               ObjTrace.IdDiagnostico, ObjTrace.IdDiagnosticoValoracion, ObjTrace.DeterminacionDiagnostica,
        //               ObjTrace.IdDiagnosticoPrincipal, ObjTrace.GradoAfeccion, ObjTrace.Observacion,
        //               ObjTrace.IndicadorAntecedente, ObjTrace.TipoAntecedente, ObjTrace.IndicadorPreExistencia,
        //               ObjTrace.IndicadorCronico, ObjTrace.IndicadorNuevo, ObjTrace.DetalleDiagnostico,
        //               ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
        //               ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
        //            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
        //        }
        //        catch (Exception ex)
        //        {
        //            throw ex;
        //        }

        //    }
        //    return valorRetorno;
        //}
    
        //public List<SS_HC_Diagnostico_FE> DiagnosticoListar(SS_HC_Diagnostico_FE ObjTrace)
        //{
        //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        //    dynamic DataKey;
        //    List<SS_HC_Diagnostico_FE> objLista = new List<SS_HC_Diagnostico_FE>();
        //    using (var context = new ModelFormularios())
        //    {
        //        objLista = context.USP_DiagnosticoListar_FE(
        //            ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
        //            ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.FechaRegistro,
        //            ObjTrace.IdDiagnostico, ObjTrace.IdDiagnosticoValoracion, ObjTrace.DeterminacionDiagnostica,
        //            ObjTrace.IdDiagnosticoPrincipal, ObjTrace.GradoAfeccion, ObjTrace.Observacion,
        //            ObjTrace.IndicadorAntecedente, ObjTrace.TipoAntecedente, ObjTrace.IndicadorPreExistencia,
        //            ObjTrace.IndicadorCronico, ObjTrace.IndicadorNuevo, ObjTrace.DetalleDiagnostico,
        //            ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
        //            ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version
        //            ).ToList();

        //        DataKey = new
        //        {
        //            UnidadReplicacion = ObjTrace.UnidadReplicacion,
        //            IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
        //            EpisodioClinico = ObjTrace.EpisodioClinico,
        //            IdPaciente = ObjTrace.IdPaciente,
        //            Secuencia = ObjTrace.Secuencia
        //        };

        //        //objAudit.Type = "V";
        //        //if (objLista.Count > 1) objAudit.Type = "L";
        //        //string tempType = objAudit.Type;
        //        //objAudit = AddAudita(new SS_HC_Diagnostico_FE(), new SS_HC_Diagnostico_FE(), DataKey, objAudit.Type);
        //        //String xlmIn = XMLString(objLista, new List<SS_HC_Diagnostico_FE>(), "SS_HC_Diagnostico_FE");
        //        //objAudit.TableName = "SS_HC_Diagnostico_FE";
        //        //objAudit.Type = tempType;
        //        //objAudit.VistaData = xlmIn;
        //        //context.Entry(objAudit).State = EntityState.Added;
        //        //context.SaveChanges();
        //    }
        //    return objLista;

        //}

        //public int setMantenimiento(SS_HC_Diagnostico_FE ObjTraces, List<SS_HC_Diagnostico_FE> listaCabecera, List<SS_HC_Diagnostico_FE> listaDetalle)
        //{
        //    System.Nullable<int> iReturnValue;
        //    int valorRetorno = 0;
        //    dynamic DataKey = null;
        //    SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();

        //    using (var context = new WEB_ERPSALUDEntities())
        //    {
        //        using (var dbContextTransaction = context.Database.BeginTransaction())
        //        {
        //            try
        //            {
        //                foreach (var obj in listaDetalle)
        //                {

        //                    var InformacionObj = (from t in context.SS_HC_Diagnostico_FE
        //                                          where t.IdPaciente == obj.IdPaciente
        //                                          && t.EpisodioClinico == obj.EpisodioClinico
        //                                          && t.IdEpisodioAtencion == obj.IdEpisodioAtencion
        //                                          && t.Secuencia == obj.Secuencia
        //                                          orderby t.IdEpisodioAtencion descending
        //                                          select t).SingleOrDefault();
        //                    if (InformacionObj == null) InformacionObj = new SS_HC_Diagnostico_FE();

        //                    iReturnValue = context.USP_Diagnostico(
        //                        obj.UnidadReplicacion, obj.IdEpisodioAtencion,
        //                        obj.IdPaciente, obj.EpisodioClinico, obj.Secuencia, obj.FechaRegistro,
        //                        obj.IdDiagnostico, obj.IdDiagnosticoValoracion, obj.DeterminacionDiagnostica,
        //                        obj.IdDiagnosticoPrincipal, obj.GradoAfeccion, obj.Observacion,
        //                        obj.IndicadorAntecedente, obj.TipoAntecedente, obj.IndicadorPreExistencia,
        //                        obj.IndicadorCronico, obj.IndicadorNuevo, obj.DetalleDiagnostico,
        //                        obj.Estado, obj.UsuarioCreacion, obj.FechaCreacion,
        //                        obj.UsuarioModificacion,
        //                        obj.FechaModificacion, obj.Accion, obj.Version
        //                    ).SingleOrDefault();
        //                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

        //                    DataKey = new
        //                    {
        //                        UnidadReplicacion = obj.UnidadReplicacion,
        //                        IdEpisodioAtencion = obj.IdEpisodioAtencion,
        //                        EpisodioClinico = obj.EpisodioClinico,
        //                        IdPaciente = obj.IdPaciente,
        //                        Secuencia = obj.Secuencia
        //                    };
        //                    // Audit

        //                    objAudit = AddAudita(InformacionObj, obj, DataKey, obj.Accion.Substring(0, 1));
        //                    objAudit.TableName = "SS_HC_Diagnostico_FE";
        //                    objAudit.Type = obj.Accion.Substring(0, 1);
        //                    context.Entry(objAudit).State = EntityState.Added;

        //                }
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
  
    
    }
}
