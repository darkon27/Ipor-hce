using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALEstablecimiento
{
    public class EstablecimientoRepository : AuditGenerico<CM_CO_Establecimiento, CM_CO_Establecimiento> 

    {
        public List<CM_CO_Establecimiento> listarEstablecimiento(CM_CO_Establecimiento objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<CM_CO_Establecimiento> objLista = new List<CM_CO_Establecimiento>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_CM_CO_ESTABLECIMIENTO_Lista(objSC.IdEstablecimiento, objSC.Codigo,
                  objSC.Nombre, objSC.Descripcion,
                  objSC.Observacion, objSC.Estado,
                  objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                  objSC.FechaModificacion, objSC.Sucursal, objSC.Compania, objSC.Direccion, objSC.Accion,
                  inicio,
                  final).ToList();

                DataKey = new
                {
                    IdEstablecimiento = objSC.IdEstablecimiento
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<CM_CO_Establecimiento>(), "CM_CO_Establecimiento");
                objAudit = AddAudita(new CM_CO_Establecimiento(), objSC, DataKey, "L");
                objAudit.TableName = "CM_CO_Establecimiento";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }

        public int setMantenimiento(CM_CO_Establecimiento objSC)
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
                        CM_CO_Establecimiento objAnterior = new CM_CO_Establecimiento();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.CM_CO_Establecimiento
                                           where t.IdEstablecimiento == objSC.IdEstablecimiento
                                           orderby t.IdEstablecimiento descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_CM_CO_ESTABLECIMIENTO(objSC.IdEstablecimiento, objSC.Codigo,
                  objSC.Nombre, objSC.Descripcion,
                  objSC.Observacion, objSC.Estado,
                  objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                  objSC.FechaModificacion, objSC.Sucursal, objSC.Compania, objSC.Direccion, objSC.Accion).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdEstablecimiento = objSC.IdEstablecimiento
                };
                if (objAnterior == null) objAnterior = new CM_CO_Establecimiento();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "CM_CO_Establecimiento";
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
