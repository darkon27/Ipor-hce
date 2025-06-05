using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;

namespace SoluccionSalud.Repository.DALSeguridadAutorizacion
{
    public class SeguridadAutorizacionRepository
    {
        public List<SEGURIDADAUTORIZACIONE> listarSeguridadAutorizaciones(SEGURIDADAUTORIZACIONE objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                return context.USP_SEGURIDADAUTORIZACIONES_LISTAR(objSC.APLICACIONCODIGO, objSC.GRUPO, objSC.CONCEPTO,
                    objSC.USUARIO, objSC.ESTADO,  objSC.ACCION).ToList();
            }
        }

        public int setMantenimiento(SEGURIDADAUTORIZACIONE objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SEGURIDADAUTORIZACIONES(objSC.APLICACIONCODIGO, objSC.GRUPO, objSC.CONCEPTO,
                    objSC.USUARIO,objSC.OPCIONAGREGARFLAG,objSC.OPCIONMODIFICARFLAG,objSC.OPCIONBORRARFLAG,objSC.OPCIONAPROBARFLAG,
                    objSC.ESTADO,objSC.ULTIMOUSUARIO,objSC.ULTIMAFECHAMODIF, objSC.ACCION).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        /**SY_SEGURIDAD*/
        public List<SY_SeguridadAutorizaciones> listarSysSeguridadAutorizaciones(SY_SeguridadAutorizaciones objSC,int inicio,int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                return context.USP_SS_HC_SY_SeguridadAutorizaciones_LISTAR(
                    objSC.AplicacionCodigo
                    ,objSC.Grupo
                    ,objSC.Concepto
                    ,objSC.Usuario
                    ,objSC.MasterBrowseFlag
                    ,objSC.MasterUpdateFlag
                    ,objSC.MasterApproveFlag
                    ,objSC.Estado
                    ,objSC.UltimoUsuario
                    ,objSC.UltimaFechaModif
                    ,objSC.IndAplicaSalud
                    ,inicio
                    ,inicio
                    ,final
                    ,objSC.Accion

                    ).ToList();
            }
        }

        public int setMantenimiento(SY_SeguridadAutorizaciones objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_SY_SeguridadAutorizaciones(
                    objSC.AplicacionCodigo
                    , objSC.Grupo
                    , objSC.Concepto
                    , objSC.Usuario
                    , objSC.MasterBrowseFlag
                    , objSC.MasterUpdateFlag
                    , objSC.MasterApproveFlag
                    , objSC.Estado
                    , objSC.UltimoUsuario
                    , objSC.UltimaFechaModif
                    , objSC.IndAplicaSalud
                    , objSC.IndAplicaSalud
                    , 0
                    , 0
                    , objSC.Accion
                    ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }

    }
}
