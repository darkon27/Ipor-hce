using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class Svc_ResumendelParto505_3FEService
    {


        public static List<SS_HC_RESUMEN_PARTO_FE_3> ResumenParto3Listar(SS_HC_RESUMEN_PARTO_FE_3 objSC)
        {
            return new ResumendelParto3FERepository().ResumenParto3Listar(objSC);
        }

        public static Int32 setMantenimiento(SS_HC_RESUMEN_PARTO_FE_3 objSave)
        {
            return new ResumendelParto3FERepository().setMantenimiento(objSave);
        }


    }
}
