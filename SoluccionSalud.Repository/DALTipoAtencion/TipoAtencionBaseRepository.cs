using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALTipoAtencion
{
    public class TipoAtencionBaseRepository : AuditGenerico<SS_GE_TipoAtencion, SS_GE_TipoAtencion> 
    {
         public List<SS_GE_TipoAtencion> listarTipoAtencion(SS_GE_TipoAtencion objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_GE_TipoAtencion> objLista = new List<SS_GE_TipoAtencion>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_GE_TipoAtencionListar(objSC.IdTipoAtencion, objSC.Codigo, objSC.Nombre,
                    objSC.Descripcion, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.ClasificadorMovimiento, inicio, final, objSC.Accion, objSC.Version
                   ).ToList();
                DataKey = new
                {
                    IdTipoAtencion = objSC.IdTipoAtencion,
                    Descripcion = objSC.Descripcion
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_GE_TipoAtencion>(), "SS_GE_TipoAtencion");
                objAudit = AddAudita(new SS_GE_TipoAtencion(), new SS_GE_TipoAtencion(), DataKey, "L");
                objAudit.TableName = "SS_GE_TipoAtencion";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_GE_TipoAtencion objSC)
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
                        SS_GE_TipoAtencion objAnterior = new SS_GE_TipoAtencion();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_GE_TipoAtencion
                                           where t.IdTipoAtencion == objSC.IdTipoAtencion
                                           orderby t.IdTipoAtencion descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_GE_TipoAtencion(
                   objSC.IdTipoAtencion, objSC.Codigo, objSC.Nombre,
                    objSC.Descripcion, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.ClasificadorMovimiento, objSC.Accion, objSC.Version).SingleOrDefault();

                        DataKey = new
                        {
                            IdTipoAtencion = objSC.IdTipoAtencion,
                        };
                        if (objAnterior == null) objAnterior = new SS_GE_TipoAtencion();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_GE_TipoAtencion";
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

