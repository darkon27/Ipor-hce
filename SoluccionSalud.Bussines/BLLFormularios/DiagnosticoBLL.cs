using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{

    public class DiagnosticoBLL
    {
        public int setMantenimiento(SS_HC_Diagnostico objSC)
        {
            return new  DiagnosticoRepository().setMantenimiento(objSC);
        }
        public List<SS_HC_Diagnostico> DiagnosticoListar(SS_HC_Diagnostico objSC)
        {
            return new DiagnosticoRepository().DiagnosticoListar(objSC);
        }

        public int setMantenimiento(SS_HC_Diagnostico ObjTraces, List<SS_HC_Diagnostico> listaCabecera,
            List<SS_HC_Diagnostico> listaDetalle)
        {
            return new DiagnosticoRepository().setMantenimiento(ObjTraces, listaCabecera, listaDetalle);
        }

        public SS_HC_Diagnostico obtenerPorId(SS_HC_Diagnostico objSC)
        {
            return new DiagnosticoRepository().obtenerPorId(objSC);
        }
    }
}
