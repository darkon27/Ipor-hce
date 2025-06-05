using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Bussines.BLLEspecialidadOrdenMedica;

namespace SoluccionSalud.Service.EspecialidadOrdenMedicaService
{
    public class SvcEspecialidadOrdenMedica
    {
        public static List<SS_GE_EspecialidadOrdenMedica> listarEspecialidadOrdenMedica(SS_GE_EspecialidadOrdenMedica objSC, int inicio, int final)
        {
            return new EspecialidadOrdenMedicaBLL().listarEspecialidadOrdenMedica(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_GE_EspecialidadOrdenMedica ObjTrace)
        {
            return new EspecialidadOrdenMedicaBLL().setMantenimiento(ObjTrace);
        }
    }
}
