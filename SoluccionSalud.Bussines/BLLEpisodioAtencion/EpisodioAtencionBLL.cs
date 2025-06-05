using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALEpisodioAtencion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLEpisodioAtencion
{
    public class EpisodioAtencionBLL
    {
        public List<SS_HC_EpisodioAtencion> listarSS_HC_EpisodioAtencion(SS_HC_EpisodioAtencion objSC, int inicio, int final)
        {
            return new EpisodioAtencionRepository().listarSS_HC_EpisodioAtencion(objSC, inicio, final);
        }

        public long setMantenimiento(SS_HC_EpisodioAtencion ObjTrace)
        {
            return new EpisodioAtencionRepository().setMantenimiento(ObjTrace);
        }

        public  int setPreMantenimiento(PERSONAMAST ObjPersona, SS_GE_Paciente objPaciente,
            SS_HC_AsignacionMedico ObjAsigmedico, SS_HC_EpisodioClinico ObjEpiClinico, 
            List<SS_HC_EpisodioAtencion> listaEpiAtencion)
        {
            return new EpisodioAtencionRepository().setPreMantenimiento(ObjPersona, objPaciente, ObjAsigmedico, ObjEpiClinico, listaEpiAtencion);
        }

        /****/
        public long setCopiarEpisodio(SS_HC_EpisodioAtencion objSC, int idOpcion, String codigoFormato)
        {
            return new EpisodioAtencionRepository().setCopiarEpisodio(objSC, idOpcion, codigoFormato);
        }

    }
}
