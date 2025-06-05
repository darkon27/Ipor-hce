using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{
    public class DescansoMedicoBLL
    {
        public int DescansoMedico(SS_HC_DescansoMedico objSC)
        {
            return new DescansoMedicoRepository().DescansoMedico(objSC);
        }

        public List<SS_HC_DescansoMedico> DescansoMedicoListar(SS_HC_DescansoMedico objSC)
        {
            return new DescansoMedicoRepository().DescansoMedicoListar(objSC);
        }
    }

}
