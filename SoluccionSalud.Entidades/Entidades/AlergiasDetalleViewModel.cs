using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class AlergiasDetalleViewModel
    {
        public string UnidadReplicacion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioTriaje { get; set; }
        public int Secuencia { get; set; }
        public Nullable<int> IdCIAP2 { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string CodigoComponente { get; set; }
        public string Linea { get; set; }
        public string Familia { get; set; }
        public string SubFamilia { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IdTipoAlergia { get; set; }
        public string DesdeCuando { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> EstudioAlegista { get; set; }
        public Nullable<int> Dosis { get; set; }
        public string Frecuencia { get; set; }
        public string via { get; set; }
        public string TipoRegistro { get; set; }
        public string DescripcionManual { get; set; }
    }
}
