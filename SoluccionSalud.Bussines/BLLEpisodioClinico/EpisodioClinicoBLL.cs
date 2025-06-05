using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALEpisodioClinico;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Bussines.BLLEpisodioClinico
{
    public class EpisodioClinicoBLL
    {
        public List<SS_HC_EpisodioClinico> listarSS_HC_EpisodioClinico(SS_HC_EpisodioClinico objSC, int inicio, int final)
        {
            return new EpisodioClinicoRepository().listarSS_HC_EpisodioClinico(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_EpisodioClinico ObjTrace)
        {
            return new EpisodioClinicoRepository().setMantenimiento(ObjTrace);
        }
    }
}
