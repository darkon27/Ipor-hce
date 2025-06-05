using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Bussines.BLLEspecialidad;

namespace SoluccionSalud.Service.EspecialidadService
{
    public class SvcEspecialidad
    {
        public static List<SS_GE_Especialidad> listarEspecialidad(SS_GE_Especialidad objSC, int inicio, int final)
        {
            return new EspecialidadBLL().listarEspecialidad(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_GE_Especialidad ObjTrace)
        {
            return new EspecialidadBLL().setMantenimiento(ObjTrace);
        }

        public static int setMantenimiento(List<SS_GE_Especialidad> listaObjSC)
        {
            return new EspecialidadBLL().setMantenimiento(listaObjSC);
        }
        
    }
}
