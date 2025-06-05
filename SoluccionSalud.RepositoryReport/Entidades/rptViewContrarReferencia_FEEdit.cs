using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewContrarReferencia_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long idEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public long NroContrarreferencia { get; set; }
        public System.DateTime FechaContrarreferencia { get; set; }
        public System.DateTime HoraContrarreferencia { get; set; }
        public string establecimientoOrigen { get; set; }
        public string servicioOrigen { get; set; }
        public string EstablecimientoDestino { get; set; }
        public string ServicioDestino { get; set; }
        public string IdentificacionUsuario { get; set; }
        public System.DateTime FechaIngreso { get; set; }
        public System.DateTime FechaEgreso { get; set; }
        public string DiagnosticoIN { get; set; }
        public string DiagnosticoEG { get; set; }
        public string TratamientoRealizados { get; set; }
        public string ProcedimientosRealizados { get; set; }
        public string OrigenD { get; set; }
        public string OrigenE { get; set; }
        public string OrigenA { get; set; }
        public string CalificacionJ { get; set; }
        public string CalificacionNJ { get; set; }
        public string UPSC { get; set; }
        public string UPSE { get; set; }
        public string UPSA { get; set; }
        public string UPSH { get; set; }
        public string EspecialidadDesc { get; set; }
        public string Recomendaciones { get; set; }
        public string NombreCompleto { get; set; }
        public string CMP { get; set; }
        public string CPC { get; set; }
        public string CPM { get; set; }
        public string CPA { get; set; }
        public string CPD { get; set; }
        public string CPR { get; set; }
        public string CPF { get; set; }
        public string version { get; set; }
    }
}
