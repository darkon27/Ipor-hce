using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptView_ValoracionFuncionalAM_FEEdit
    {

        public string Unidadreplicacion { get; set; }
        public long idEpisodioAtencion { get; set; }
        public int Idpaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public string LD { get; set; }
        public string LI { get; set; }
        public string VD { get; set; }
        public string VI { get; set; }
        public string SHD { get; set; }
        public string SHI { get; set; }
        public string MD { get; set; }
        public string MI { get; set; }
        public string CD { get; set; }
        public string CI { get; set; }
        public string AD { get; set; }
        public string AI { get; set; }
        public string DiagnosticoFuncional { get; set; }
        public int estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string version { get; set; }
    }
}
