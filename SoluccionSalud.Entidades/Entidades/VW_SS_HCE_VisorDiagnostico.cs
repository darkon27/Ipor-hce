using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class VW_SS_HCE_VisorDiagnostico
    {
        public string TAB { get; set; }
        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public int IdConsultaExterna { get; set; }
        public int iddiagnostico { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public string Nombre { get; set; }
        public string CodigoDiagnostico { get; set; }
        public string TipoDiagnostico { get; set; }
        public string TipoAntecedente { get; set; }
        public int IndicadorAntecedente { get; set; }
        public string DetalleDiagnostico { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string documento { get; set; }
        public string tipodocumento { get; set; }
    }
}
