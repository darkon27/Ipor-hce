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
    public class SvcEpisodioNotificaciones
    {
        public static List<SS_HC_EpisodioNotificaciones_FE> EpisodioNotificaciones_Listar(SS_HC_EpisodioNotificaciones_FE objSC, int inicio, int final)
        {
            return new EpisodioNotificacionesRepository().listarNotificaciones(objSC, inicio, final);
        }


    }
}
