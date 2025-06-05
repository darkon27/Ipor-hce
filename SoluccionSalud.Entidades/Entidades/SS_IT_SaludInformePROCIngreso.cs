using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_IT_SaludInformePROCIngreso
    {
        public int IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string UnidadReplicacion { get; set; }
        public Nullable<int> IdEpisodioAtencion { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public Nullable<int> EpisodioClinico { get; set; }
        public string Informe { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IndicadorRecepcion { get; set; }
        public Nullable<System.DateTime> FechaRecepcion { get; set; }
        public Nullable<int> IndicadorProcesado { get; set; }
        public Nullable<System.DateTime> FechaProcesado { get; set; }
    }
}
