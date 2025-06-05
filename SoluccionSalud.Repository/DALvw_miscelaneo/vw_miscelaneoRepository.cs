using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALvw_miscelaneo
{
    public class vw_miscelaneoRepository : AuditGenerico<vw_Miscelaneos, vw_Miscelaneos> 
    { 
        public List<vw_Miscelaneos> listarVw_Miscelaneos(vw_Miscelaneos objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<vw_Miscelaneos> objLista = new List<vw_Miscelaneos>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.usp_vw_Miscelaneos_listar(
                objSC.AplicacionHeader,
                objSC.CodigoHeader,
                objSC.CompaniaHeader,
                objSC.DescLocalHeader,
                objSC.DescExtHeader,
                objSC.EstadoHeader,
                objSC.UsuarioHeader,
                objSC.FechaHeader,
                objSC.TimeHeader,
                objSC.AccionHeader,
                objSC.AplicacionDetalle,
                objSC.CodigoDetalle,
                objSC.CompaniaDetalle,
                objSC.ElementoDetalle,
                objSC.DescDetalle,
                objSC.DescextDetalle,
                objSC.ValorCodigoDetalle,
                objSC.EstadoDetalle,
                objSC.UsuarioDetalle,
                objSC.FechaDetalle,
                objSC.TimeDetalle,
                objSC.ValorCodigo2,
                objSC.ValorCodigo3,
                objSC.ValorCodigo4,
                objSC.ValorEntero1,
                objSC.ValorEntero2,
                objSC.ValorEntero3,
                objSC.ValorEntero4,
                     inicio, final
                    ).ToList();

                DataKey = new
                {
                    AplicacionHeader = objSC.AplicacionHeader,
                    CodigoHeader = objSC.CodigoHeader,
                    CompaniaHeader = objSC.CompaniaHeader
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<vw_Miscelaneos>(), "vw_Miscelaneos");
                objAudit = AddAudita(new vw_Miscelaneos(), new vw_Miscelaneos(), DataKey, "L");
                objAudit.TableName = "vw_Miscelaneos";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }

        public int setMantenimiento(vw_Miscelaneos objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.usp_vw_Miscelaneos(

                objSC.AplicacionHeader,
                objSC.CodigoHeader,
                objSC.CompaniaHeader,
                objSC.DescLocalHeader,
                objSC.DescExtHeader,
                objSC.EstadoHeader,
                objSC.UsuarioHeader,
                objSC.FechaHeader,
                objSC.TimeHeader,
                objSC.AccionHeader,
                objSC.AplicacionDetalle,
                objSC.CodigoDetalle,
                objSC.CompaniaDetalle,
                objSC.ElementoDetalle,
                objSC.DescDetalle,
                objSC.DescextDetalle,
                objSC.ValorCodigoDetalle,
                objSC.EstadoDetalle,
                objSC.UsuarioDetalle,
                objSC.FechaDetalle,
                objSC.TimeDetalle,
                objSC.ValorCodigo2,
                objSC.ValorCodigo3,
                objSC.ValorCodigo4,
                objSC.ValorEntero1,
                objSC.ValorEntero2,
                objSC.ValorEntero3,
                objSC.ValorEntero4

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
