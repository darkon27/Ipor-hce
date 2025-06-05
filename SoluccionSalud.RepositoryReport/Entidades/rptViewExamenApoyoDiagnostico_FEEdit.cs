
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public class rptViewExamenApoyoDiagnostico_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int Secuencia { get; set; }
        public string Resumen { get; set; }
        public string Motivo { get; set; }
        public DateTime FechaSolicitada { get; set; }
        public int IdTipoExamen { get; set; }
        public string TipoExamen { get; set; }
        public string Examen { get; set; }
        public int  Cantidad{ get; set; }
        public string Especificaciones { get; set; }
        public string Observacion { get; set; }
        public string Diagnostico { get; set; }
        public string CodigoSegus { get; set; }

    }
}