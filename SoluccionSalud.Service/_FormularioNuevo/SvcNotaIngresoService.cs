using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcNotaIngresoService
    {

        public static int setMantenimiento(SS_HC_Nota_Ingreso_FE objSC, List<SS_HC_NotaIngreso_ExamenApoyo_FE> detalle0, List<SS_HC_NotaIngreso_Diagnostico_FE> detalle2)
        {
            return (new NotaIngresoFERepository().setMantenimiento(objSC, detalle0, detalle2));
        }

       

        public static List<SS_HC_Nota_Ingreso_FE> lista_Cabecera(SS_HC_Nota_Ingreso_FE objSC)
        {
            return (new NotaIngresoFERepository().Lista_Cabecera(objSC));
        }









    }
}
