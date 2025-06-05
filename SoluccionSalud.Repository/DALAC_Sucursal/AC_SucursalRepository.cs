using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALAC_Sucursal
{
   public class AC_SucursalRepository
    {
       public List<AC_Sucursal> listarAC_Sucursal(AC_Sucursal objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_SucursalListar(
                         objSC.Sucursal
                        , objSC.SucursalGrupo
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.CuentaContableDefecto
                        , objSC.Estado
                        , objSC.UltimoUsuario
                        , objSC.UltimaFechaModif
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.DireccionComun
                        , objSC.DireccionAdicional
                        , objSC.Telefono1
                        , objSC.Telefono2
                        , objSC.Telefono3
                        , objSC.Fax1
                        , objSC.Fax2
                        , objSC.Compania
                        , objSC.CIIU
                        , objSC.LogoSucursal
                        , objSC.ACCION
                    , inicio, final                   
                    ).ToList();
            }
        }

       public int setMantenimiento(AC_Sucursal objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        iReturnValue = context.USP_SS_HC_Sucursal(
                         objSC.Sucursal
                        , objSC.SucursalGrupo
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.CuentaContableDefecto
                        , objSC.Estado
                        , objSC.UltimoUsuario
                        , objSC.UltimaFechaModif
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.DireccionComun
                        , objSC.DireccionAdicional
                        , objSC.Telefono1
                        , objSC.Telefono2
                        , objSC.Telefono3
                        , objSC.Fax1
                          , objSC.Fax2
                          , objSC.Compania
                          , objSC.CIIU
                          , objSC.LogoSucursal
                          , objSC.ACCION

                     ).SingleOrDefault();
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
       public int setMantenimiento(List<AC_Sucursal> listaObjSC)
       {
           SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
           dynamic DataKey;
           System.Nullable<int> iReturnValue = 0;
           int valorRetorno = 0; //ERROR
           using (var context = new WEB_ERPSALUDEntities())
           {
               using (var dbContextTransaction = context.Database.BeginTransaction())
               {
                   try
                   {
                       if (listaObjSC != null)
                       {
                           foreach (var objSC in listaObjSC)
                           {
                               iReturnValue = context.USP_SS_HC_Sucursal(objSC.Sucursal, objSC.SucursalGrupo, objSC.DescripcionLocal
                                   , objSC.DescripcionIngles, objSC.CuentaContableDefecto, objSC.Estado, objSC.UltimoUsuario
                                   , objSC.UltimaFechaModif, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.DireccionComun
                                   , objSC.DireccionAdicional, objSC.Telefono1, objSC.Telefono2, objSC.Telefono3, objSC.Fax1
                                   , objSC.Fax2, objSC.Compania, objSC.CIIU, objSC.LogoSucursal, objSC.ACCION).SingleOrDefault();
                           }
                       }
                       valorRetorno = Convert.ToInt32(iReturnValue);
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
