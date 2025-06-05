using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class VW_SS_HCE_VisorDescansoMedico
    {
        public string TAB { get; set; }
        public Nullable<int> IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public int IdConsultaExterna { get; set; }
        public int IdDescanso { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<System.DateTime> FechaFinal { get; set; }
        public string Observaciones { get; set; }
        public string Dia { get; set; }
        public string Diagnostico { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public string Sucursal { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Documento { get; set; }
        public string TipoDocumento { get; set; }
    }
}
