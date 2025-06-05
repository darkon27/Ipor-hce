using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVWEspecialidadMedico;

namespace SoluccionSalud.Bussines.BLLVWESPECIALIDADMEDICO
{
    public class VWEspecialidadMedicoBLL
    {
        public List<VW_SS_GE_ESPECIALIDADMEDICO> listarEspecialidadMedico(VW_SS_GE_ESPECIALIDADMEDICO objSC, int inicio, int final)
        {
            return new VWEspecialidadMedicoRepository().listarEspecialidadMedico(objSC, inicio, final);
        }

        public int setMantenimiento(VW_SS_GE_ESPECIALIDADMEDICO ObjTrace)
        {
            return new VWEspecialidadMedicoRepository().setMantenimiento(ObjTrace);
        }
    }
}
