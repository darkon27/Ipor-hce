using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcNotaEnfermeriaServiceFE
    {
        
        public static List<SS_HC_NotasEnfermeria_FE> ReporteNotaEnfermeriaListar(SS_HC_NotasEnfermeria_FE objSC)
        {
            return new NotaEnfermeriaFERepository().ReporteNotaEnfermeriaListar(objSC);
        }

        public static List<SS_HC_NotasEnfermeria_FE> NotaEnfermeriaListar(SS_HC_NotasEnfermeria_FE objSC)
        {
            return new NotaEnfermeriaFERepository().NotaEnfermeriaListar(objSC);
        }

        public static Int32 setMantenimiento(SS_HC_NotasEnfermeria_FE objSave)
        {
            return new NotaEnfermeriaFERepository().setMantenimiento(objSave);
        }


    }
}
