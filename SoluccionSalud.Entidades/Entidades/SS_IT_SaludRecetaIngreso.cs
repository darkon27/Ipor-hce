using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_IT_SaludRecetaIngreso
    {
        public int IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencionConsulta { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string Componente { get; set; }
        public string SubFamilia { get; set; }
        public string Familia { get; set; }
        public string Linea { get; set; }
        public Nullable<int> UnidadMedida { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<System.DateTime> FechaAplicacion { get; set; }
        public string Via { get; set; }
        public string Dosis { get; set; }
        public string DiasTratamiento { get; set; }
        public string Frecuencia { get; set; }
        public Nullable<int> IndicadorEPS { get; set; }
        public Nullable<int> TipoReceta { get; set; }
        public string UnidadReplicacion { get; set; }
        public Nullable<int> IdEpisodioAtencion { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public Nullable<int> EpisodioClinico { get; set; }
        public Nullable<int> Secuencia { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IndicadorRecepcion { get; set; }
        public Nullable<System.DateTime> FechaRecepcion { get; set; }
        public Nullable<int> IndicadorProcesado { get; set; }
        public Nullable<System.DateTime> FechaProcesado { get; set; }
        public string INDICACIONESPECIFICA { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public string SECUENCIALHCE { get; set; }
    }
}
