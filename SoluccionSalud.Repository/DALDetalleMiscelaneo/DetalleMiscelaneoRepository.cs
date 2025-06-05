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
    public class DetalleMiscelaneoRepository : AuditGenerico<MA_MiscelaneosDetalle, MA_MiscelaneosDetalle> 
    {
        public List<MA_MiscelaneosDetalle> listarDetalleMiscelaneo(MA_MiscelaneosDetalle objSC,
    int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_DetalleMiscelaneos_Lista(
                objSC.AplicacionCodigo,
                objSC.CodigoTabla,
                objSC.Compania,
                objSC.CodigoElemento,
                objSC.DescripcionLocal,
                objSC.DescripcionExtranjera,
                objSC.ValorNumerico,
                objSC.ValorCodigo1,
                objSC.ValorCodigo2,
                objSC.ValorCodigo3,
                objSC.ValorCodigo4,
                objSC.ValorCodigo5,
                objSC.ValorFecha,
                objSC.Estado,
                objSC.UltimoUsuario,
                objSC.UltimaFechaModif,
                objSC.Timestamp,
                objSC.ACCION,
                objSC.RowID,
                objSC.ValorEntero1,
                objSC.ValorEntero2,
                objSC.ValorEntero3,
                objSC.ValorEntero4,
                objSC.ValorEntero5,

                objSC.ValorCodigo6,
                objSC.ValorCodigo7,
                objSC.ValorEntero6,
                objSC.ValorEntero7,

                  inicio,
                  final).ToList();
            }
        }

        public int setMantenimiento(MA_MiscelaneosDetalle objSC)
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
                        MA_MiscelaneosDetalle objAnterior = new MA_MiscelaneosDetalle();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.MA_MiscelaneosDetalle
                                           where t.CodigoTabla == objSC.CodigoTabla
                                           && t.AplicacionCodigo == objSC.AplicacionCodigo
                                           && t.Compania == objSC.Compania
                                           && t.CodigoElemento == objSC.CodigoElemento
                                           orderby t.CodigoElemento descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_DetalleMiscelaneos(
                objSC.AplicacionCodigo,
                objSC.CodigoTabla,
                objSC.Compania,
                objSC.CodigoElemento,
                objSC.DescripcionLocal,
                objSC.DescripcionExtranjera,
                objSC.ValorNumerico,
                objSC.ValorCodigo1,
                objSC.ValorCodigo2,
                objSC.ValorCodigo3,
                objSC.ValorCodigo4,
                objSC.ValorCodigo5,
                objSC.ValorFecha,
                objSC.Estado,
                objSC.UltimoUsuario,
                objSC.UltimaFechaModif,
                objSC.Timestamp,
                objSC.ACCION,
                objSC.RowID,
                objSC.ValorEntero1,
                objSC.ValorEntero2,
                objSC.ValorEntero3,
                objSC.ValorEntero4,
                objSC.ValorEntero5,

                objSC.ValorCodigo6,
                objSC.ValorCodigo7,
                objSC.ValorEntero6,
                objSC.ValorEntero7
                ).SingleOrDefault();
                //*  Registra Audit/
                DataKey = new
                {
                    AplicacionCodigo = objSC.AplicacionCodigo,
                    CodigoTabla = objSC.CodigoTabla,
                    Compania = objSC.Compania,
                    CodigoElemento = objSC.CodigoElemento
                };
                if (objAnterior == null) objAnterior = new MA_MiscelaneosDetalle();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                objAudit.TableName = "MA_MiscelaneosDetalle";
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

