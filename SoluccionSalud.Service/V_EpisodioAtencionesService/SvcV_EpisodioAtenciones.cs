using SoluccionSalud.Bussines.BLLV_EpisodioAtenciones;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.V_EpisodioAtencionesService
{
    public class SvcV_EpisodioAtenciones
    {
        public static List<V_EpisodioAtenciones> ListarV_EpisodioAtenciones(V_EpisodioAtenciones objSC, int inicio, int final)
        {
            return new V_EpisodioAtencionesBLL().ListarV_EpisodioAtenciones(objSC,inicio,final);
        }
        public static int setMantenimiento(V_EpisodioAtenciones ObjTrace)
        {
            return new V_EpisodioAtencionesBLL().setMantenimiento(ObjTrace);
        }
    }
}
