using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;


namespace SoluccionSalud.Repository.DALProcedimiento
{
    public class ProcedimientoRepository : AuditGenerico<SS_HC_Procedimiento, SS_HC_Procedimiento> 
    {
        public List<SS_HC_Procedimiento> listarProcedimiento(SS_HC_Procedimiento objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_Procedimiento> objLista = new List<SS_HC_Procedimiento>();


            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_ProcedimientoListar(objSC.IdProcedimiento, objSC.IdProcedimientoPadre,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.Nivel, objSC.UltimoNivelFlag,
                    objSC.CadenaRecursiva, objSC.Orden, objSC.Icono, objSC.NombreInterfaz, objSC.CodigoProcedimiento,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.Accion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.Version, objSC.Estado
                    , inicio
                    , final).ToList();

                DataKey = new
                {
                    IdProcedimiento = objSC.IdProcedimiento
                };
                
                /*foreach(SS_HC_Procedimiento objNew in objLista)
                {
                    objSC = objNew;
                    objSC.SS_HC_Procedimiento1 = null;
                    objSC.SS_HC_Procedimiento2 = null;
                }
                SS_HC_Procedimiento nuevo = new SS_HC_Procedimiento();
                nuevo.SS_HC_Procedimiento1 = null;
                nuevo.SS_HC_Procedimiento2 = null;*/
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_Procedimiento>(), "SS_HC_Procedimiento");

                objAudit = AddAudita(new SS_HC_Procedimiento(), new SS_HC_Procedimiento(), DataKey, "L");
                objAudit.TableName = "SS_HC_Procedimiento";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }
        public int setMantenimiento(SS_HC_Procedimiento objSC)
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
                        SS_HC_Procedimiento objAnterior = new SS_HC_Procedimiento();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_Procedimiento
                                           where t.IdProcedimiento == objSC.IdProcedimiento
                                           orderby t.IdProcedimiento descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SS_HC_Procedimiento(objSC.IdProcedimiento, objSC.IdProcedimientoPadre,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.Nivel, objSC.UltimoNivelFlag,
                    objSC.CadenaRecursiva, objSC.Orden, objSC.Icono, objSC.NombreInterfaz, objSC.CodigoProcedimiento,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.Version, objSC.Estado).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdProcedimiento = objSC.IdProcedimiento
                };
                if (objAnterior == null) objAnterior = new SS_HC_Procedimiento();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_HC_Procedimiento";
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
