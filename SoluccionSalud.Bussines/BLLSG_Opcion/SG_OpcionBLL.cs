using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSG_Opcion;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSG_Opcion
{
    public class SG_OpcionBLL
    {
        public List<SG_Opcion> listarSG_Opcion(SG_Opcion objSC, int inicio, int final)
        {
            return new SG_OpcionRepository().listarSG_Opcion(objSC, inicio, final);
        }

        public int setMantenimiento(SG_Opcion ObjTrace)
        {
            return new SG_OpcionRepository().setMantenimiento(ObjTrace);
        }

        public  int setMantenimiento(List<SG_Opcion> listaObjTrace)
        {
            return new SG_OpcionRepository().setMantenimiento(listaObjTrace);
        }
    }
}
