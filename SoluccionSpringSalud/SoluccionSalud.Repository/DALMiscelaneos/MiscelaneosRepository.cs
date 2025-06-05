using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALMiscelaneos
{

    public class MiscelaneosRepository : GenericDataRepository<MA_MiscelaneosDetalle>, IMiscelaneosRepository
    {
        public List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle ObjTrace)
        { 
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_LISTARSERVICIOS(ObjTrace.AplicacionCodigo,	ObjTrace.CodigoTabla,	ObjTrace.Compania,	
                    ObjTrace.CodigoElemento,	ObjTrace.DescripcionLocal,	ObjTrace.DescripcionExtranjera,	ObjTrace.ValorNumerico,	
                    ObjTrace.ValorCodigo1,	ObjTrace.ValorCodigo2,	ObjTrace.ValorCodigo3,	ObjTrace.ValorCodigo4,
                    ObjTrace.ValorCodigo5, ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION).ToList();
            }
        }
        public int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_MiscelaneosDetalle(ObjTrace.AplicacionCodigo, ObjTrace.CodigoTabla, ObjTrace.Compania,
                    ObjTrace.CodigoElemento, ObjTrace.DescripcionLocal, ObjTrace.DescripcionExtranjera, ObjTrace.ValorNumerico,
                    ObjTrace.ValorCodigo1, ObjTrace.ValorCodigo2, ObjTrace.ValorCodigo3, ObjTrace.ValorCodigo4,
                    ObjTrace.ValorCodigo5, ObjTrace.ValorCodigo6, ObjTrace.ValorCodigo7, ObjTrace.ValorEntero1, ObjTrace.ValorEntero2,
                    ObjTrace.ValorEntero3, ObjTrace.ValorEntero4, ObjTrace.ValorEntero5, ObjTrace.ValorEntero6, ObjTrace.ValorEntero7,
                    ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
