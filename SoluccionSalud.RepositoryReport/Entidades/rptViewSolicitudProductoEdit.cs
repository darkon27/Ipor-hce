using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public class rptViewSolicitudProductoEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdSolicitudProducto { get; set; }
        public string NumeroDocumento { get; set; }
        public string Observacion { get; set; }
        public int Secuencia { get; set; }
        public decimal Cantidad { get; set; }
        public string Linea { get; set; }
        public string Familia { get; set; }
        public string SubFamilia { get; set; }
        public string CodigoComponente { get; set; }
        public string NombreCompleto { get; set; }
        public string CodigoOA { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string PersMedicoNombreCompleto { get; set; }
        public string TipoTrabajadorDesc { get; set; }
        public string Medicamento { get; set; }
    }
}
