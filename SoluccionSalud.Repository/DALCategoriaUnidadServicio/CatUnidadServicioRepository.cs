using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALCatUnidadServicio
{
    public class CatUnidadServicioRepository : AuditGenerico<SS_HC_CatalogoUnidadServicio, SS_HC_CatalogoUnidadServicio>
    {
        public List<SS_HC_CatalogoUnidadServicio> listarCatUnidadServicio(SS_HC_CatalogoUnidadServicio objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_CatalogoUnidadServicio> objLista = new List<SS_HC_CatalogoUnidadServicio>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_CatalogoUnidadServicioListar(objSC.IdUnidadServicio, objSC.CodigoUnidadServicio,
                    objSC.IdUnidadServicioPadre, objSC.Descripcion, objSC.DescripcionExtranjera, objSC.Nivel, objSC.UltimoNivelFlag,
                  objSC.CadenaRecursividad, objSC.Orden, objSC.Icono, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                  objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, inicio, final
                 ).ToList();
                DataKey = new
                {
                    IdUnidadServicio = objSC.IdUnidadServicio,
                    CodigoUnidadServicio = objSC.CodigoUnidadServicio,
                    Descripcion = objSC.Descripcion
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_CatalogoUnidadServicio>(), "SS_HC_CatalogoUnidadServicio");
                objAudit = AddAudita(new SS_HC_CatalogoUnidadServicio(), new SS_HC_CatalogoUnidadServicio(), DataKey, "L");
                objAudit.TableName = "SS_HC_CatalogoUnidadServicio";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_CatalogoUnidadServicio objSC)
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
                        SS_HC_CatalogoUnidadServicio objAnterior = new SS_HC_CatalogoUnidadServicio();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_CatalogoUnidadServicio
                                           where t.IdUnidadServicio == objSC.IdUnidadServicio
                                           orderby t.IdUnidadServicio descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_CatalogoUnidadServicio(objSC.IdUnidadServicio, objSC.CodigoUnidadServicio,
                            objSC.IdUnidadServicioPadre, objSC.Descripcion, objSC.DescripcionExtranjera, objSC.Nivel,
                            objSC.UltimoNivelFlag, objSC.CadenaRecursividad, objSC.Orden, objSC.Icono, objSC.Estado, objSC.UsuarioCreacion,
                            objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion
                 ).SingleOrDefault();

                        DataKey = new
                        {
                            IdUnidadServicio = objSC.IdUnidadServicio,
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_CatalogoUnidadServicio();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_CatalogoUnidadServicio";
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
