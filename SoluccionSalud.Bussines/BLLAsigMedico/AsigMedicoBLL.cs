using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALAsigMedico;

namespace SoluccionSalud.Bussines.BLLAsigMedico
{
    public class AsigMedicoBLL
    {
        public List<SS_HC_AsignacionMedico> listarAsigMedico(SS_HC_AsignacionMedico objSC, int inicio, int final)
        {
            return new AsigMedicoRepository().listarAsigMedico(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_AsignacionMedico ObjTrace)
        {
            return new AsigMedicoRepository().setMantenimiento(ObjTrace);
        }
    }
}
