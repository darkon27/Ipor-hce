using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALVWEmpresaSeguro
{
    public class VW_EmpresaSeguroBaseRepository : GenericDataRepository<VW_SS_GE_EMPRESASEGURO>
    {
        public List<VW_SS_GE_EMPRESASEGURO> listarEmpresaSeguro(VW_SS_GE_EMPRESASEGURO objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_VW_SS_GE_EmpresaSeguroListar(objSC.IDEMPRESA, objSC.CODIGO, objSC.DESCRIPCION,
                    objSC.TIPOEMPRESA, objSC.TIPOSEGURO, objSC.ESTADO, objSC.USUARIOCREACION,
                    objSC.FECHACREACION, objSC.USUARIOMODIFICACION, objSC.FECHAMODIFICACION, objSC.ACCION, objSC.PERSONA,
                    objSC.NOMBRECOMPLETO, objSC.DOCUMENTOFISCAL, objSC.DIRECCION, objSC.TELEFONO, objSC.TIPOEMPRESANOMBRE,
                    objSC.TIPOSEGURONOMBRE, inicio, final
                   ).ToList();
            }
        }
        public int setMantenimiento(VW_SS_GE_EMPRESASEGURO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_VW_SS_GE_EmpresaSeguro(
                   objSC.IDEMPRESA, objSC.CODIGO, objSC.DESCRIPCION,
                    objSC.TIPOEMPRESA, objSC.TIPOSEGURO, objSC.ESTADO, objSC.USUARIOCREACION,
                    objSC.FECHACREACION, objSC.USUARIOMODIFICACION, objSC.FECHAMODIFICACION, objSC.ACCION,
                    objSC.PERSONA, objSC.NOMBRECOMPLETO, objSC.DOCUMENTOFISCAL, objSC.DIRECCION, objSC.TELEFONO
                    , objSC.TIPOEMPRESANOMBRE,
                    objSC.TIPOSEGURONOMBRE
                    ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
