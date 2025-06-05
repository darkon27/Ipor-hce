using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace SoluccionSalud.Bussines.BLLFormularios
{
    public class ExamenSolicitadoBLL
    {
        public int setMantenimiento(SS_HC_ExamenSolicitado objSC)
        {
            return new ExamenSolicitadoRepository().setMantenimiento(objSC);
        }
        public List<SS_HC_ExamenSolicitado> MedicamentoListar(SS_HC_ExamenSolicitado ObjTrace)
        {
           return new ExamenSolicitadoRepository().MedicamentoListar(ObjTrace);
        }

        public  int setMantenimiento(SS_HC_ExamenSolicitado objSC, List<SS_HC_ExamenSolicitado> listaDetalle)
        {
            return new ExamenSolicitadoRepository().setMantenimiento(objSC, listaDetalle);
        }
    }
}
