using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSeguridadAutorizacion;


namespace SoluccionSalud.Bussines.BLLSeguridadAutorizacion
{
    public class SeguridadAutorizacionBLL
    {
        public List<SEGURIDADAUTORIZACIONE> listarSeguridadAutorizaciones(SEGURIDADAUTORIZACIONE objSC)
        {
            return new SeguridadAutorizacionRepository().listarSeguridadAutorizaciones(objSC);
        }

        public int setMantenimiento(SEGURIDADAUTORIZACIONE ObjTrace)
        {
            return new SeguridadAutorizacionRepository().setMantenimiento(ObjTrace);
        }

        /**SYS SEGURIDAD*/
        public List<SY_SeguridadAutorizaciones> listarSysSeguridadAutorizaciones(SY_SeguridadAutorizaciones objSC, int inicio, int final)
        {
            return new SeguridadAutorizacionRepository().listarSysSeguridadAutorizaciones(objSC,inicio,final);
        }

        public int setMantenimiento(SY_SeguridadAutorizaciones ObjTrace)
        {
            return new SeguridadAutorizacionRepository().setMantenimiento(ObjTrace);
        }
    }
}
