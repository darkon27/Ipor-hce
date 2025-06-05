using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcResumen_Parto_FE
    {

        public static List<SS_HC_RESUMEN_PARTO_FE> ResumenPartoListar(SS_HC_RESUMEN_PARTO_FE objSC)
        {
            return new ResumenPartoFERepository().ResumenPartoListar(objSC);
        }

        public static Int32 setResumenPartoMantenimiento(SS_HC_RESUMEN_PARTO_FE ObjTraces, List<SS_HC_RESUMEN_PARTO_FE> Cabecera)
        {

            return new ResumenPartoFERepository().setResumenPartoMantenimiento(ObjTraces, Cabecera);
        }

        public static int setMantenimientoGrupo(SS_HC_RESUMEN_PARTO_FE ObjTraces,  List<SS_HC_RESPARTO_EMB_ANT_FE> listaCabecera01, List<SS_HC_RESPARTO_EMB_ACT_FE> listaCabecera02)
        {
            return new ResumenPartoFERepository().setMantenimientoGrupo(ObjTraces,  listaCabecera01, listaCabecera02);
        }


        public static List<SS_HC_RESPARTO_EMB_ANT_FE> Listar_ResumenPartoAnt(SS_HC_RESPARTO_EMB_ANT_FE detalle1)
        {
            return (new ResumenPartoFERepository().Listar_ResumenPartoAnt(detalle1));

        }

        public static List<SS_HC_RESPARTO_EMB_ACT_FE> Listar_ResumenPartoAct(SS_HC_RESPARTO_EMB_ACT_FE detalle1)
        {
            return (new ResumenPartoFERepository().Listar_ResumenPartoAct(detalle1));

        }

    }
}
