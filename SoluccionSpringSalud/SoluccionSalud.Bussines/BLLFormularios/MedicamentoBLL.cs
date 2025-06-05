using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{ 
    public class MedicamentoBLL
    {
        public int setMantenimiento(SS_HC_Medicamento objSC)
        {
            return new MedicamentoRepository().setMantenimiento(objSC);
        }
        public List<SS_HC_Medicamento> MedicamentoListar(SS_HC_Medicamento ObjTrace)
        {
            return new MedicamentoRepository().MedicamentoListar(ObjTrace);
        }
    }
}
