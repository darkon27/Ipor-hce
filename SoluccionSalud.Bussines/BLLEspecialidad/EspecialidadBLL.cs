using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALEspecialidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLEspecialidad
{
    public class EspecialidadBLL
    {
        public List<SS_GE_Especialidad> listarEspecialidad(SS_GE_Especialidad objSC, int inicio, int final)
        {
            return new EspecialidadRepository().listarEspecialidad(objSC, inicio, final);
        }

        public int setMantenimiento(SS_GE_Especialidad ObjTrace)
        {
            return new EspecialidadRepository().setMantenimiento(ObjTrace);
        }

        public int setMantenimiento(List<SS_GE_Especialidad> listaObjSC)
        {
            return new EspecialidadRepository().setMantenimiento(listaObjSC);
        }
        
    }
}
