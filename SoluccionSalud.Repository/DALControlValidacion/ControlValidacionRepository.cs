using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALControlValidacion
{
    public class ControlValidacionRepository : AuditGenerico<SS_HC_ControlValidacion, SS_HC_ControlValidacion> 
    {
        public List<SS_HC_ControlValidacion> listarControlValidacion(SS_HC_ControlValidacion objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_ControlValidacion_Lista(
                    objSC.IdFormato, objSC.SecuenciaCampo, objSC.SecuenciaValidacion, objSC.IdComponente,
                    objSC.IdAtributo, objSC.Idioma, objSC.TipoValidacion, objSC.FlagTipoDato, objSC.ValorTexto,
                    objSC.ValorNumerico, objSC.ValorDate, objSC.SecuenciaValidacionRef, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.Accion, objSC.Version, objSC.IdSeccionFormato
                    , inicio
                    , final).ToList();
            }
        }
        public int setMantenimiento(SS_HC_ControlValidacion objSC)
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
                        SS_HC_ControlValidacion objAnterior = new SS_HC_ControlValidacion();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_ControlValidacion
                                           where t.IdFormato == objSC.IdFormato
                                           && t.SecuenciaCampo == objSC.SecuenciaCampo
                                           && t.SecuenciaValidacion == objSC.SecuenciaValidacion
                                           orderby t.IdFormato descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SS_HC_ControlValidacion(
                    objSC.IdFormato, objSC.SecuenciaCampo, objSC.SecuenciaValidacion, objSC.IdComponente,
                    objSC.IdAtributo, objSC.Idioma, objSC.TipoValidacion, objSC.FlagTipoDato, objSC.ValorTexto,
                    objSC.ValorNumerico, objSC.ValorDate, objSC.SecuenciaValidacionRef, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.Accion, objSC.Version, objSC.IdSeccionFormato).SingleOrDefault();
                
                        DataKey = new
                        {
                            IdFormato = objSC.IdFormato,
                            SecuenciaCampo = objSC.SecuenciaCampo,
                            SecuenciaValidacion = objSC.SecuenciaValidacion
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_ControlValidacion();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_ControlValidacion";
                        objAudit.Type = objSC.Accion.Substring(0, 1);
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
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
