using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcMonitoreoObsFE
    {

        public static List<SS_HC_Monitoreo_Obs_FE> MonitoreoListar(SS_HC_Monitoreo_Obs_FE objSC)
        {
            return new MonitoreoObsFERepository().MonitoreoListar(objSC);
        }

        public static Int32 setMantenimiento(SS_HC_Monitoreo_Obs_FE ObjTraces, List<SS_HC_Monitoreo_Obs_FE> Cabecera, List<SS_HC_Monitoreo_Obs_FE> Detalle)
        {

            return new MonitoreoObsFERepository().setMantenimiento(ObjTraces, Cabecera, Detalle);
        }

        public static int setMantenimientoGrupo(SS_HC_Monitoreo_Obs_FE ObjTraces, List<SS_HC_Monitoreo_Obs_Ing_FE> listaCabecera01)
        {
            return new MonitoreoObsFERepository().setMantenimientoGrupo(ObjTraces, listaCabecera01);
        }

     
        public static List<SS_HC_Monitoreo_Obs_Ing_FE> Listar_MonitoreoIngreso(SS_HC_Monitoreo_Obs_Ing_FE detalle1)
        {
            return (new MonitoreoObsFERepository().Listar_MonitoreoIngreso(detalle1));

        }

    } 
}
