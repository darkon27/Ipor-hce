using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Bussines.BLLEpisodioAtencion;

namespace SoluccionSalud.Service.EpisodioAtencionService
{
    public class SvcEpisodioAtencion
    {
        public static List<SS_HC_EpisodioAtencion> listarSS_HC_EpisodioAtencion(SS_HC_EpisodioAtencion objSC, int inicio, int final)
        {
            return new EpisodioAtencionBLL().listarSS_HC_EpisodioAtencion(objSC, inicio, final);
        }

        public static long setMantenimiento(SS_HC_EpisodioAtencion ObjTrace)
        {
            return new EpisodioAtencionBLL().setMantenimiento(ObjTrace);
        }

        public static int setPreMantenimiento(PERSONAMAST ObjPersona, SS_GE_Paciente objPaciente,
            SS_HC_AsignacionMedico ObjAsigmedico, SS_HC_EpisodioClinico ObjEpiClinico,List<SS_HC_EpisodioAtencion> listaEpiAtencion )
        {
            return new EpisodioAtencionBLL().setPreMantenimiento(ObjPersona, objPaciente, ObjAsigmedico, ObjEpiClinico, listaEpiAtencion);
        }

                /****/
        public static long setCopiarEpisodio(SS_HC_EpisodioAtencion objSC, int idOpcion,String codigoFormato){
            return new EpisodioAtencionBLL().setCopiarEpisodio(objSC, idOpcion, codigoFormato);
        }

        
    }
}
