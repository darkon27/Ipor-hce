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
    public class SvcTriajeAntAlergia
    {

        //public static Int32 setMantenimiento(SS_HC_Triaje_Ant_Alergia_FE objSC)
        //{

        //    return new TriajeAlergiasRepository().setMantenimiento(objSC);
        //}

        public static Int32 setMantenimiento(SS_HC_Triaje_Ant_Alergia_FE ObjTraces, List<SS_HC_Triaje_Ant_Alergia_FE> Cabecera, List<SS_HC_Triaje_Ant_Alergia_FE> Detalle)
        {

            return new TriajeAlergiasRepository().setMantenimiento(ObjTraces, Cabecera, Detalle);
        }

        public static List<SS_HC_Triaje_Ant_Alergia_FE> TriajeAlergia_Listar(SS_HC_Triaje_Ant_Alergia_FE ObjTrace){

            return new TriajeAlergiasRepository().TriajeAlergia_Listar(ObjTrace);
        }


    }
}
