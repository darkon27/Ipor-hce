using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALWH_ClaseFamilia
{
    public class WH_ClaseFamiliaRepository : AuditGenerico<WH_ClaseFamilia, WH_ClaseFamilia> 
    {
        public List<WH_ClaseFamilia> listarWH_ClaseFamilia(WH_ClaseFamilia objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<WH_ClaseFamilia> objLista = new List<WH_ClaseFamilia>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_WH_ClaseFamilia_Listado(
                         objSC.Linea
                        , objSC.Familia
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.DescripcionCompleta
                        , objSC.CuentaInventario
                        , objSC.CuentaGasto
                        , objSC.ElementoGasto
                        , objSC.PartidaPresupuestal
                        , objSC.FlujodeCaja
                        , objSC.LineaFamilia
                        , objSC.LoteValidacionFlag
                        , objSC.MedicinaGrupoAFlag
                        , objSC.MedicinaGrupoHFlag
                        , objSC.MedicinaGrupoEFlag
                        , objSC.MedicinaGrupoRFlag
                        , objSC.CuentaVentas
                        , objSC.CuentaTransito
                        , objSC.CuentaCostoVentas
                        , objSC.Caracteristica01
                        , objSC.Caracteristica02
                        , objSC.Caracteristica03
                        , objSC.Caracteristica04
                        , objSC.Caracteristica05
                        , objSC.Estado
                        , objSC.UltimoUsuario
                        , objSC.UltimaFechaModif
                        , objSC.ReferenciaFiscal01
                        , objSC.ReferenciaFiscal02
                        , objSC.ReferenciaFiscal03
                        , objSC.ContactoEMail
                        , objSC.ContactoFax
                        , objSC.ContactoNombre
                        , objSC.ContactoTelefono
                        , objSC.CuentaVentaComercial
                        , objSC.CuentaCompras
                        , objSC.CentroCosto
                        , objSC.CuentaServicioTecnico
                        , objSC.Accion
                    , inicio, final
                    ).ToList();

                DataKey = new
                {
                    Linea = objSC.Linea,
                    Familia = objSC.Familia

                };
                // Audit
                String xlmIn = XMLString(objLista, new List<WH_ClaseFamilia>(), "WH_ClaseFamilia");
                objAudit = AddAudita(new WH_ClaseFamilia(), new WH_ClaseFamilia(), DataKey, "L");
                objAudit.TableName = "WH_ClaseFamilia";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(WH_ClaseFamilia objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_WH_ClaseFamilia(
                         objSC.Linea
                        , objSC.Familia
                        , objSC.DescripcionLocal
                        , objSC.DescripcionIngles
                        , objSC.DescripcionCompleta
                        , objSC.CuentaInventario
                        , objSC.CuentaGasto
                        , objSC.ElementoGasto
                        , objSC.PartidaPresupuestal
                        , objSC.FlujodeCaja
                        , objSC.LineaFamilia
                        , objSC.LoteValidacionFlag
                        , objSC.MedicinaGrupoAFlag
                        , objSC.MedicinaGrupoHFlag
                        , objSC.MedicinaGrupoEFlag
                        , objSC.MedicinaGrupoRFlag
                        , objSC.CuentaVentas
                        , objSC.CuentaTransito
                        , objSC.CuentaCostoVentas
                        , objSC.Caracteristica01
                        , objSC.Caracteristica02
                        , objSC.Caracteristica03
                        , objSC.Caracteristica04
                        , objSC.Caracteristica05
                        , objSC.Estado
                        , objSC.UltimoUsuario
                        , objSC.UltimaFechaModif
                        , objSC.ReferenciaFiscal01
                        , objSC.ReferenciaFiscal02
                        , objSC.ReferenciaFiscal03
                        , objSC.ContactoEMail
                        , objSC.ContactoFax
                        , objSC.ContactoNombre
                        , objSC.ContactoTelefono
                        , objSC.CuentaVentaComercial
                        , objSC.CuentaCompras
                        , objSC.CentroCosto
                        , objSC.CuentaServicioTecnico
                        , objSC.Accion

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
