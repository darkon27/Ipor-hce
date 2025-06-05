using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALCatUnidServAtencion
{
    public class CatUnidServAtencionRepository : AuditGenerico<SS_HC_CatalogoUnidadServicio_TipoAtencion, SS_HC_CatalogoUnidadServicio_TipoAtencion>
    {
        public List<SS_HC_CatalogoUnidadServicio_TipoAtencion> listarCatUnidServAtencion(SS_HC_CatalogoUnidadServicio_TipoAtencion objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_CatalogoUnidadServicio_TipoAtencion> objLista = new List<SS_HC_CatalogoUnidadServicio_TipoAtencion>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_CatalogoUnidadServicio_TipoAtencionListar(objSC.IdUnidadServicio, objSC.IdTipoAtencion, 
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion
                    , objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, inicio, final).ToList();
                DataKey = new
                {
                    IdUnidadServicio = objSC.IdUnidadServicio,
                    IdTipoAtencion = objSC.IdTipoAtencion
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_CatalogoUnidadServicio_TipoAtencion>(), "SS_HC_CatalogoUnidadServicio_TipoAtencion");
                objAudit = AddAudita(new SS_HC_CatalogoUnidadServicio_TipoAtencion(), new SS_HC_CatalogoUnidadServicio_TipoAtencion(), DataKey, "L");
                objAudit.TableName = "SS_HC_CatalogoUnidadServicio_TipoAtencion";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        public int setMantenimiento(SS_HC_CatalogoUnidadServicio_TipoAtencion objSC)
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
                        SS_HC_CatalogoUnidadServicio_TipoAtencion objAnterior = new SS_HC_CatalogoUnidadServicio_TipoAtencion();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_CatalogoUnidadServicio_TipoAtencion
                                           where t.IdUnidadServicio == objSC.IdUnidadServicio
                                           && t.IdTipoAtencion == objSC.IdTipoAtencion
                                           orderby t.IdUnidadServicio descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_CatalogoUnidadServicio_TipoAtencion(objSC.IdUnidadServicio, objSC.IdTipoAtencion,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion
                    , objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion).SingleOrDefault();

                        DataKey = new
                        {
                            IdUnidadServicio = objSC.IdUnidadServicio,
                            IdTipoAtencion = objSC.IdTipoAtencion
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_CatalogoUnidadServicio_TipoAtencion();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_CatalogoUnidadServicio_TipoAtencion";
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
