using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALDetalleMiscelaneo
{
    public class MiscelaneoHeaderRepository : AuditGenerico<MA_MiscelaneosHeader, MA_MiscelaneosHeader> 
    {
        public List<MA_MiscelaneosHeader> listarHeaderMiscelaneo(MA_MiscelaneosHeader objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_HeaderMiscelaneos_Lista(
                objSC.AplicacionCodigo,
                objSC.CodigoTabla,
                objSC.Compania,
                objSC.DescripcionLocal,
                objSC.DescripcionExtranjera,
                objSC.Estado,
                objSC.UltimoUsuario,
                objSC.UltimaFechaModif,
                objSC.Timestamp,
                objSC.ACCION,

                  inicio,
                  final).ToList();
            }
        }

        public int setMantenimiento(MA_MiscelaneosHeader objSC)
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
                        MA_MiscelaneosHeader objAnterior = new MA_MiscelaneosHeader();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.MA_MiscelaneosHeader
                                           where t.CodigoTabla == objSC.CodigoTabla
                                           orderby t.CodigoTabla descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_HeaderMiscelaneos(
                objSC.AplicacionCodigo,
                objSC.CodigoTabla,
                objSC.Compania,
                objSC.DescripcionLocal,
                objSC.DescripcionExtranjera,
                objSC.Estado,
                objSC.UltimoUsuario,
                objSC.UltimaFechaModif,
                objSC.Timestamp,
                objSC.ACCION
                ).SingleOrDefault();
                //*  Registra Audit/
                DataKey = new
                {
                    AplicacionCodigo = objSC.AplicacionCodigo,
                    CodigoTabla = objSC.CodigoTabla,
                    Compania = objSC.Compania
                };
                if (objAnterior == null) objAnterior = new MA_MiscelaneosHeader();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                objAudit.TableName = "MA_MiscelaneosHeader";
                objAudit.Type = objSC.ACCION.Substring(0, 1);
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
