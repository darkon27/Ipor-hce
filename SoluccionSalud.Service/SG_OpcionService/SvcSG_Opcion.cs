using SoluccionSalud.Bussines.BLLSG_Opcion;
using SoluccionSalud.Entidades.Entidades;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SG_OpcionService
{
    public class SvcSG_Opcion
    {
        public static List<SG_Opcion> listarSG_Opcion(SG_Opcion objSC, int inicio, int final)
        {
            return new SG_OpcionBLL().listarSG_Opcion(objSC, inicio, final);
        }

        public static int setMantenimiento(SG_Opcion ObjTrace)
        {
            return new SG_OpcionBLL().setMantenimiento(ObjTrace);
        }

        public static int setMantenimiento(List<SG_Opcion> listaObjTrace)
        {
            return new SG_OpcionBLL().setMantenimiento(listaObjTrace);
        }

    }
}
