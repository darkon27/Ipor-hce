using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class VW_SS_HCE_VisorReceta
    {
        public string TAB { get; set; }
        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public int IdConsultaExterna { get; set; }
        public string Componente { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<int> Forma { get; set; }
        public Nullable<decimal> Dosis { get; set; }
        public Nullable<decimal> DiasTratamiento { get; set; }
        public Nullable<decimal> Frecuencia { get; set; }
        public string Comentario { get; set; }
        public Nullable<int> IndicadorEPS { get; set; }
        public Nullable<int> TipoReceta { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public string LIN { get; set; }
        public string FAM { get; set; }
        public string DCI { get; set; }
        public string MED { get; set; }
        public string documento { get; set; }
        public string tipodocumento { get; set; }
        public string DesVia { get; set; }
        public string DesUnidad { get; set; }
        public string IndicacionesEsp { get; set; }
    }
}