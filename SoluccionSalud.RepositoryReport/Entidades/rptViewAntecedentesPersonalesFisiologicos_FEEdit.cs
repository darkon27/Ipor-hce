using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.RepositoryReport.Entidades
{
    public partial class rptViewAntecedentesPersonalesFisiologicos_FEEdit
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdSecuencia { get; set; }
        public string GrupoSanguineo { get; set; }
        public string FactorRH { get; set; }
        public string AlimentacionA_flag { get; set; }
        public string Alcohol { get; set; }
        public string Alcohol_EspecificarCantidad { get; set; }
        public string Tabaco_flag { get; set; }
        public string Tabaco_NroCigarrillos { get; set; }
        public string TiempoConsumo { get; set; }
        public string Drogas_flag { get; set; }
        public string Drogas_Especificar { get; set; }
        public string Cafe_flag { get; set; }
        public string Otros { get; set; }
        public string ActividadFisica_flag { get; set; }
        public string ActividadFisica_subflag { get; set; }
        public string ConsumoVerduras_flag { get; set; }
        public string ConsumoVerduras_subflag { get; set; }
        public string ConsumoFrutas_flag { get; set; }
        public string ConsumoFrutas_subflag { get; set; }
        public string InmunizacionesAdultoObservaciones { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public int Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }
}
