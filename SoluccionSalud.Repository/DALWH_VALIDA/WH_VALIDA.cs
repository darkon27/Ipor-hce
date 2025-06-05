using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALWH_VALIDA
{
    public class WH_VALIDA
    {
        public List<SS_VW_VALIDA> listarSS_VW_VALIDA(SS_VW_VALIDA objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_VW_VALIDA_LISTA(
                    objSC.IdFormato,
                    objSC.ValorPorDefecto,
                    objSC.NombreComponente,
                    objSC.TipoComponente,
                    objSC.NombreAtributo,
                    objSC.SecuenciaCampo,
                    objSC.SecuenciaValidacion,
                objSC.Estado,
                objSC.Accion, objSC.Version, inicio, final
                    ).ToList();
            }
        }

        public int setMantenimiento(SS_VW_VALIDA objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_VW_VALIDA(

           objSC.IdFormato,
                    objSC.ValorPorDefecto,
                    objSC.NombreComponente,
                    objSC.TipoComponente,
                    objSC.NombreAtributo,
                    objSC.SecuenciaCampo,
                    objSC.SecuenciaValidacion,
                objSC.Estado,
                objSC.Accion, objSC.Version

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
