using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALV_EpisodioAtenciones;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLV_EpisodioAtenciones
{
    public class V_EpisodioAtencionesBLL
    {
        public List<V_EpisodioAtenciones> ListarV_EpisodioAtenciones(V_EpisodioAtenciones objSC, int inicio, int final)
        {
            return new V_EpisodioAtencionesRepository().ListarV_EpisodioAtenciones(objSC,inicio,final);
        }

        public int setMantenimiento(V_EpisodioAtenciones ObjTrace)
        {
            return new V_EpisodioAtencionesRepository().setMantenimiento(ObjTrace);
        }
    }
}
