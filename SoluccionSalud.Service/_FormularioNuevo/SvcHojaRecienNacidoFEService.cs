using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Bussines;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcHojaRecienNacidoFEService
    {
        public static int setMantenimiento(SS_HC_HojaRecienNacido_FE ObjTraces, List<SS_HC_HojaRecienNacidoDetalle_FE> ObjDetalle)
        {
            return new HojaRecienNacidoFERepository().setMantenimiento(ObjTraces, ObjDetalle);
        }

        public static List<SS_HC_HojaRecienNacido_FE> listarEntidad(SS_HC_HojaRecienNacido_FE objSC)
        {
            return new HojaRecienNacidoFERepository().listarEntidad(objSC);
        }
    }
}
