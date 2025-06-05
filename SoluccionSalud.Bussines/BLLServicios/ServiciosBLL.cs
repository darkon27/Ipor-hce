using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALServicios;

namespace SoluccionSalud.Bussines.BLLServicios
{
    public class ServiciosBLL
    {
        public List<SS_GE_Servicio> listarServicio(SS_GE_Servicio objSC, int inicio, int final)
        {
            return new ServiciosRepository().listarServicio(objSC, inicio, final);
        }

        public int setMantenimiento(SS_GE_Servicio ObjTrace)
        {
            return new ServiciosRepository().setMantenimiento(ObjTrace);
        }
    }
}
