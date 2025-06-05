using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewAlergias_FEEdit
    {


        public int Secuencia { get; set; }
        public int IdTipoAlergia { get; set; }
        public string Nombre { get; set; }
        public string DesdeCuando { get; set; }
        public int EstudioAlegista { get; set; }
        public string Observaciones { get; set; }
        public string UnidadReplicacion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdEpisodioAtencion { get; set; }
        public string TipoAlergiaDesc { get; set; }
        public string SI { get; set; }
        public string NO { get; set; }
        public string EstudioAlergista { get; set; }
        public string Accion { get; set; }
    }
}
