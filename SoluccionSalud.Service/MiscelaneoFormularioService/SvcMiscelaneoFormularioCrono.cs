using SoluccionSalud.Bussines.BLLMiscelaneoFormulario;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Service.MiscelaneoFormularioService
{
    public class SvcMiscelaneoFormularioCrono
    {

        public static List<MA_MiscelaneosDetalle> listarMA_MiscelaneosFormularioCrono(MA_MiscelaneosDetalle objSC, string usu, string unidadreplicacion, int idpaciente, int episodioclinico, int idepisodioatencion, int idordenatencion, string CodigoOA, int IdMedico, int IdOpcion, string codigoformato)
        {
            return new MiscelaneoFormularioCronoBLL().listarMA_MiscelaneosFormularioCrono(objSC,  usu, unidadreplicacion, idpaciente, episodioclinico, idepisodioatencion, idordenatencion, CodigoOA, IdMedico, IdOpcion, codigoformato);
        }

    }
}
