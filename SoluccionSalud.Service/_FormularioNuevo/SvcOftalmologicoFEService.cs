using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcOftalmologicoFEService
    {
        public static List<SS_HC_Oftalmologico_FE> OftalmologicoListar(SS_HC_Oftalmologico_FE objSC)
        {
            return new OftalmologicoFERepository().OftalmologicoListar(objSC);
        }

        public static Int32 setMantenimiento(SS_HC_Oftalmologico_FE objSave)
        {

            return new OftalmologicoFERepository().setMantenimiento(objSave);
        }
    }
}
