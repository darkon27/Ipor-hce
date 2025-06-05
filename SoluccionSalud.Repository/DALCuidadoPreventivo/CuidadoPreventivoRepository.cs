using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALCuidadoPreventivo
{
    public class CuidadoPreventivoRepository : AuditGenerico<SS_HC_CuidadoPreventivo, SS_HC_CuidadoPreventivo> 
    {
        public List<SS_HC_CuidadoPreventivo> listarCuidadoPreventivo(SS_HC_CuidadoPreventivo objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_CuidadoPreventivo> objLista = new List<SS_HC_CuidadoPreventivo>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_CuidadoPreventivoListar(objSC.IdCuidadoPreventivo, objSC.IdCuidadoPreventivoPadre,
                    objSC.CodigoCuidadoPreventivo, objSC.CodigoCuidadoPreventivoPadre, 
                    objSC.IdTipoCuidadoPreventivo,objSC.IdTipoPeriodicidad,objSC.Descripcion,objSC.DescripcionExtranjera,
                    objSC.Nivel,objSC.UltimoNivelFlag,objSC.CadenaRecursiva,
                    objSC.Orden, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.NombreTabla, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();

                DataKey = new
                {
                    IdCuidadoPreventivo = objSC.IdCuidadoPreventivo,
                    CodigoCuidadoPreventivo = objSC.CodigoCuidadoPreventivo,
                    Descripcion = objSC.Descripcion,
                    Estado = objSC.Estado
                };
                /*
                foreach (SS_HC_CuidadoPreventivo objNew in objLista)
                {
                    objSC = objNew;
                    objSC.SS_HC_CuidadoPreventivo1 = null;
                    objSC.SS_HC_CuidadoPreventivo2 = null;
                }*/
               // SS_HC_CuidadoPreventivo nuevo = new SS_HC_CuidadoPreventivo();
                //objSC.SS_HC_CuidadoPreventivo1 = null;
                //objSC.SS_HC_CuidadoPreventivo2 = null;
                
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_CuidadoPreventivo>(), "SS_HC_CuidadoPreventivo");
               // String xlmIn = "";
                objAudit = AddAudita(new SS_HC_CuidadoPreventivo(), new SS_HC_CuidadoPreventivo(), DataKey, "L");
                objAudit.TableName = "SS_HC_CuidadoPreventivo";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }
        public int setMantenimiento(SS_HC_CuidadoPreventivo objSC)
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
                        SS_HC_CuidadoPreventivo objAnterior = new SS_HC_CuidadoPreventivo();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_CuidadoPreventivo
                                           where t.IdCuidadoPreventivo == objSC.IdCuidadoPreventivo
                                           orderby t.IdCuidadoPreventivo descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_CuidadoPreventivo(
                            objSC.IdCuidadoPreventivo, objSC.IdCuidadoPreventivoPadre,
                            objSC.CodigoCuidadoPreventivo, objSC.CodigoCuidadoPreventivoPadre,
                            objSC.IdTipoCuidadoPreventivo, objSC.IdTipoPeriodicidad, objSC.Descripcion, objSC.DescripcionExtranjera,
                            objSC.Nivel, objSC.UltimoNivelFlag, objSC.CadenaRecursiva,
                            objSC.Orden, objSC.Estado, objSC.UsuarioCreacion,
                            objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                            objSC.NombreTabla, objSC.Accion, objSC.Version).SingleOrDefault();

                        //*  Registra Audit/
                        DataKey = new
                        {
                            IdCuidadoPreventivo = objSC.IdCuidadoPreventivo
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_CuidadoPreventivo();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_CuidadoPreventivo";
                        objAudit.Type = objSC.Accion.Substring(0, 1);                

                    //*/
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
                                dbContextTransaction.Commit();
                            }
                        }
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
