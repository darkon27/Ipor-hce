using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALProcMedico
{
    public class ProcMedRepository : AuditGenerico<SS_GE_ProcedimientoMedico, SS_GE_ProcedimientoMedico> 
    {
        public List<SS_GE_ProcedimientoMedico> listarProcMedico(SS_GE_ProcedimientoMedico objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_GE_ProcedimientoMedico> objLista = new List<SS_GE_ProcedimientoMedico>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_GE_ProcedimientoMedicoListar(
                    objSC.IdProcedimiento, objSC.CodigoProcedimiento, objSC.CodigoPadre, objSC.Nombre, objSC.Descripcion,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.IdProcedimientoPadre, objSC.Orden, objSC.CadenaRecursividad, objSC.Nivel,objSC.DiagnosticoSiteds, 
                    objSC.IndicadorPermitido, objSC.tipofolder, objSC.NombreTabla, objSC.Accion, objSC.CodigoSegus
                    , inicio
                    , final).ToList();
                DataKey = new
                {
                    IdProcedimientoDos = objSC.IdProcedimiento
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_GE_ProcedimientoMedico>(), "SS_GE_ProcedimientoMedico");
                objAudit = AddAudita(new SS_GE_ProcedimientoMedico(), new SS_GE_ProcedimientoMedico(), DataKey, "L");
                objAudit.TableName = "SS_GE_ProcedimientoMedico";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        public int setMantenimiento(SS_GE_ProcedimientoMedico objSC)
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
                        SS_GE_ProcedimientoMedico objAnterior = new SS_GE_ProcedimientoMedico();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_GE_ProcedimientoMedico
                                           where t.IdProcedimiento == objSC.IdProcedimiento
                                           orderby t.IdProcedimiento descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_GE_ProcedimientoMedico(
                            objSC.IdProcedimiento, objSC.CodigoProcedimiento, objSC.CodigoPadre, objSC.Nombre, objSC.Descripcion,
                            objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                            objSC.IdProcedimientoPadre, objSC.Orden, objSC.CadenaRecursividad, objSC.Nivel,objSC.DiagnosticoSiteds, 
                            objSC.IndicadorPermitido, objSC.tipofolder, objSC.NombreTabla, objSC.Accion, objSC.CodigoSegus).SingleOrDefault();
                        //*  Registra Audit/
                        DataKey = new
                        {
                            IdProcedimiento = objSC.IdProcedimiento
                        };
                        if (objAnterior == null) objAnterior = new SS_GE_ProcedimientoMedico();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_GE_ProcedimientoMedico";
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
