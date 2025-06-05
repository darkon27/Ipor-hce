using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALFormatoCampo
{
    public class FormatoCampoRepository : AuditGenerico<SS_HC_FormatoCampo, SS_HC_FormatoCampo> 
    {
        public List<SS_HC_FormatoCampo> listarFormatoCampo(SS_HC_FormatoCampo objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_FormatoCampo_Lista(objSC.IdFormato, objSC.SecuenciaCampo,
                    objSC.IdFavoritoTabla, objSC.IdCampo, objSC.IdSeccionFormato, objSC.TipoCampo,
                    objSC.ValorPorDefecto, objSC.IndicadorObligatorio, objSC.IndicadorCampoCalculado,
                    objSC.Formula, objSC.IndicadorValoresVarios, objSC.TablaValoresVarios, objSC.IndicadorRango,
                    objSC.RangoDesde, objSC.RangoHasta, objSC.IndicadorReglaNegocio,
                    objSC.ReglaNegocio, objSC.Observaciones, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version,
                    objSC.DescripcionLocal, objSC.DescripcionExtranjera, objSC.IdConcepto, objSC.IdAgrupadorNivel,
                    objSC.IdObjetoAgrupador,
                    objSC.IdColumna,
                    objSC.IdFila,
                    objSC.IdEvento,
                    objSC.IdParameterEnvio,
                    objSC.Orden,
                    objSC.IdAgrupadorNivelPadre
                    , inicio
                    , final).ToList();
            }
        }
      public int setMantenimiento(SS_HC_FormatoCampo objSC)
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
                        SS_HC_FormatoCampo objAnterior = new SS_HC_FormatoCampo();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_FormatoCampo
                                           where t.IdFormato == objSC.IdFormato
                                           && t.SecuenciaCampo == objSC.SecuenciaCampo
                                           orderby t.IdFormato descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SS_HC_FormatoCampo_Mantenimiento(objSC.IdFormato, objSC.SecuenciaCampo,
                    objSC.IdFavoritoTabla, objSC.IdCampo, objSC.IdSeccionFormato, objSC.TipoCampo,
                    objSC.ValorPorDefecto, objSC.IndicadorObligatorio, objSC.IndicadorCampoCalculado,
                    objSC.Formula, objSC.IndicadorValoresVarios, objSC.TablaValoresVarios, objSC.IndicadorRango,
                    objSC.RangoDesde, objSC.RangoHasta, objSC.IndicadorReglaNegocio,
                    objSC.ReglaNegocio, objSC.Observaciones, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version, objSC.DescripcionLocal,
                    objSC.DescripcionExtranjera,
                    objSC.IdConcepto,
                    objSC.IdAgrupadorNivel,
                    objSC.IdObjetoAgrupador,
                    objSC.IdColumna,
                    objSC.IdFila,
                    objSC.IdEvento,
                    objSC.IdParameterEnvio,
                    objSC.Orden,
                    objSC.IdAgrupadorNivelPadre).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdFormato = objSC.IdFormato,
                    SecuenciaCampo = objSC.SecuenciaCampo
                };
                if (objAnterior == null) objAnterior = new SS_HC_FormatoCampo();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_HC_FormatoCampo";
                objAudit.Type = objSC.Accion.Substring(0, 1);
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
