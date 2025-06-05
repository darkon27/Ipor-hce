using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewValoracionMentalAM_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Cualfecha { get; set; }
        public int QueDiasemana { get; set; }
        public int EnquelugarEstamos { get; set; }
        public int CualNumerotelefono { get; set; }
        public int CuantosAniostiene { get; set; }
        public int DondeNacio { get; set; }
        public int NombrePresidente { get; set; }
        public int NombrePresidenteAnterior { get; set; }
        public int ApellidoMadre { get; set; }
        public int Restar { get; set; }
        public string ValorCognitiva { get; set; }
        public int Satisfecho { get; set; }
        public int Impotente { get; set; }
        public int Memoria { get; set; }
        public int desgano { get; set; }
        public string EstadoAfectivo { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public System.DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public System.DateTime FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public string SatisfechoDes { get; set; }
        public string ImpotenteDes { get; set; }
        public string MemoriaDes { get; set; }
        public string DesganoDes { get; set; }

    }
}
