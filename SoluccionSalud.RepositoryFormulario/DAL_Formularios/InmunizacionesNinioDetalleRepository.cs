using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

using SoluccionSalud.Entidades.Entidades;


using SoluccionSalud.ModelERP_FORM;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class InmunizacionesNinioDetalleRepository
    {
        public List<SS_HC_AntecedentesPersonalesINDetalle_FE> listarDetalle(SS_HC_AntecedentesPersonalesINDetalle_FE objSC, int inicio, int final)
        {

            List<SS_HC_AntecedentesPersonalesINDetalle_FE> objLista = new List<SS_HC_AntecedentesPersonalesINDetalle_FE>();

            using (var context = new ModelFormularios())
            {
                objLista = context.USP_AntecedentesPersonalesINDetalleListar_FE(
                    objSC.UnidadReplicacion,
                    objSC.IdEpisodioAtencion,
                    objSC.IdPaciente,
                    objSC.EpisodioClinico,        
                    objSC.Accion).ToList();     
            }
            return objLista;
        }

    }
}
