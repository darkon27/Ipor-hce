using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALComponenteBase
{
    public class ComponenteBaseRepository : GenericDataRepository<CM_CO_ListaBaseComponente>
    {
        public List<CM_CO_ListaBaseComponente> listarCM_CO_ListaBaseComponente(CM_CO_ListaBaseComponente objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_CM_CO_ListaBaseComponente_lista(objSC.IdListaBase, objSC.TipoComponente, objSC.CodigoComponente,
                    objSC.Periodo, objSC.Moneda, objSC.PrecioUnitarioLista, objSC.PrecioUnitarioListaLocal,
                    objSC.PrecioUnitarioBase, objSC.PrecioUnitarioBaseLocal, objSC.FechaValidezInicio, objSC.FechaValidezFin, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.IndicadorPrecioCero, objSC.Factor, objSC.TipoFactor, objSC.IndicadorFactor, objSC.PrecioCosto,
                    objSC.FactorCosto, objSC.PrecioKairos, objSC.FactorKairos, objSC.Accion
                    , inicio
                    , final).ToList();
            }
        }

        public int setMantenimiento(CM_CO_ListaBaseComponente objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_CM_CO_ListaBaseComponente_mantenimiento(
                    objSC.IdListaBase, objSC.TipoComponente, objSC.CodigoComponente,
                    objSC.Periodo, objSC.Moneda, objSC.PrecioUnitarioLista, objSC.PrecioUnitarioListaLocal,
                    objSC.PrecioUnitarioBase, objSC.PrecioUnitarioBaseLocal, objSC.FechaValidezInicio, objSC.FechaValidezFin, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.IndicadorPrecioCero, objSC.Factor, objSC.TipoFactor, objSC.IndicadorFactor, objSC.PrecioCosto,
                    objSC.FactorCosto, objSC.PrecioKairos, objSC.FactorKairos, objSC.Accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
