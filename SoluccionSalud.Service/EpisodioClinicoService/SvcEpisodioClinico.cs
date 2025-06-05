using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Bussines.BLLEpisodioClinico;

namespace SoluccionSalud.Service.EpisodioClinicoService
{
    public class SvcEpisodioClinico
    {
        public static List<SS_HC_EpisodioClinico> listarSS_HC_EpisodioClinico(SS_HC_EpisodioClinico objSC, int inicio, int final)
        {
            return new EpisodioClinicoBLL().listarSS_HC_EpisodioClinico(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_EpisodioClinico ObjTrace)
        {
            return new EpisodioClinicoBLL().setMantenimiento(ObjTrace);
        }

    }
}
