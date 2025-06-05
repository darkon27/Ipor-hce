using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNicActividad;


namespace SoluccionSalud.Bussines.BLLNicActividad
{
    public class NicActividadBLL
    {
        public List<SS_HC_NICActividad> listarNicActividad(SS_HC_NICActividad objSC, int inicio, int final)
        {
            return new NicActividadRepository().listarNicActividad(objSC, inicio, final);
        }

        public int setMantenimientoNicActividad(SS_HC_NICActividad ObjTrace)
        {
            return new NicActividadRepository().setMantenimientoNicActividad(ObjTrace);
        }

        public int setMantenimientoNicActividad(List<SS_HC_NICActividad> listaObjSC)
        {
            return new NicActividadRepository().setMantenimientoNicActividad(listaObjSC);
        }
    }
}
