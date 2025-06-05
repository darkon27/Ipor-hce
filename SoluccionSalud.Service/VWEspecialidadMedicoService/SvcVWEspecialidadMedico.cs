using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLVWESPECIALIDADMEDICO;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.VWEspecialidadMedicoService
{
    public class SvcVWEspecialidadMedico
    {
        public static List<VW_SS_GE_ESPECIALIDADMEDICO> listarEspecialidadMedico(VW_SS_GE_ESPECIALIDADMEDICO objSC, int inicio, int final)
        {
            return new VWEspecialidadMedicoBLL().listarEspecialidadMedico(objSC, inicio, final);
        }

        public static int setMantenimiento(VW_SS_GE_ESPECIALIDADMEDICO ObjTrace)
        {
            return new VWEspecialidadMedicoBLL().setMantenimiento(ObjTrace);
        }
    }
}
