using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_FA_Notificacion
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdNotificacion { get; set; }
        public string NumeroDocumento { get; set; }
        public string Observacion { get; set; }
        public Nullable<int> EstadoDocumento { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string indicaciones { get; set; }

        public string codigoauxiliar1 { get; set; }
        public string codigoauxiliar2 { get; set; }
        public string codigoauxiliar3 { get; set; }
        public string codigoauxiliar4 { get; set; }


    }
}
