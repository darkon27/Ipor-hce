using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSG_AgenteOpcion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSG_AgenteOpcion
{
    public class SG_AgenteOpcionBLL
    {
        public List<SG_AgenteOpcion> listarSG_AgenteOpcion(SG_AgenteOpcion objSC, int inicio, int final)
        {
            return new SG_AgenteOpcionRepository().listarSG_AgenteOpcion(objSC, inicio, final); ;
        }

        public int setMantenimiento(SG_AgenteOpcion ObjTrace)
        {
            return new SG_AgenteOpcionRepository().setMantenimiento(ObjTrace);
        }
    }
}
