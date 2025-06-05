using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SP_SS_HC_InterConsultaSalida_Lista_Result
    {
        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string CodigoSegus { get; set; }
        public int Cantidad { get; set; }
        public Nullable<int> IndicadorEPS { get; set; }
        public Nullable<int> IdEspecialidad { get; set; }
        public Nullable<int> Medico { get; set; }
        public System.DateTime FechaProcedimiento { get; set; }
        public Nullable<int> IdCita { get; set; }
        public Nullable<int> EstadoDcumento { get; set; }
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Secuencia { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public int IdTipoOrdenAtencion { get; set; }
        public string Observacion { get; set; }
        public string SecuencialHCE { get; set; }
    }
}
