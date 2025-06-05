using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewValoracionAM_FEEdit
    {

        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public string E { get; set; }
        public string S { get; set; }
        public string F { get; set; }
        public string G { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        
        public System.DateTime Accion { get; set; }
        public string Version { get; set; }










    }
}
