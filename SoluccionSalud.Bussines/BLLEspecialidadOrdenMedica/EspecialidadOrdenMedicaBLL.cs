using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALEspecialidadOrdenMedica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLEspecialidadOrdenMedica
{
    public class EspecialidadOrdenMedicaBLL
    {
        public List<SS_GE_EspecialidadOrdenMedica> listarEspecialidadOrdenMedica(SS_GE_EspecialidadOrdenMedica objSC, int inicio, int final)
        {
            return new EspecialidadOrdenMedicaRepository().listarEspecialidadOrdenMedica(objSC, inicio, final);
        }

        public int setMantenimiento(SS_GE_EspecialidadOrdenMedica ObjTrace)
        {
            return new EspecialidadOrdenMedicaRepository().setMantenimiento(ObjTrace);
        }
    }
}
