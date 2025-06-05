using SoluccionSalud.Bussines.BLLSeguridadAutorizacion;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SeguridadAutorizacionService
{
    public class SvcSeguridadAutorizacion
    {
        public static List<SEGURIDADAUTORIZACIONE> listarSeguridadAutorizaciones(SEGURIDADAUTORIZACIONE objSC)
        {
            return new SeguridadAutorizacionBLL().listarSeguridadAutorizaciones(objSC);
        }
        public static int setMantenimiento(SEGURIDADAUTORIZACIONE ObjTrace)
        {
            return new SeguridadAutorizacionBLL().setMantenimiento(ObjTrace);
        }
        /**SYS SEGURIDAD*/
        public static List<SY_SeguridadAutorizaciones> listarSysSeguridadAutorizaciones(SY_SeguridadAutorizaciones objSC, int inicio, int final)
        {
            return new SeguridadAutorizacionBLL().listarSysSeguridadAutorizaciones(objSC,inicio,final);
        }
        public static int setMantenimiento(SY_SeguridadAutorizaciones ObjTrace)
        {
            return new SeguridadAutorizacionBLL().setMantenimiento(ObjTrace);
        }
    }
}
