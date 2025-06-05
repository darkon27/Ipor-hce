using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_IT_SaludAnamnesisIngreso
    {
        public int IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string UnidadReplicacion { get; set; }
        public int IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public Nullable<int> EpisodioClinico { get; set; }
        public string Secuencia { get; set; }
        public string TiempoEnfermedad { get; set; }
        public string TiempoEnfermedadUnidad { get; set; }
        public string RelatoCronologico { get; set; }
        public string PresionArterialMSD1 { get; set; }
        public Nullable<int> PresionArterialMSD2 { get; set; }
        public string PresionArterialMSI1 { get; set; }
        public string PresionArterialMSI2 { get; set; }
        public string FrecuenciaCardiaca { get; set; }
        public Nullable<int> FrecuenciaRespiratoria { get; set; }
        public string Temperatura { get; set; }
        public Nullable<int> SaturacionOxigeno { get; set; }
        public string Peso { get; set; }
        public string Talla { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IndicadorProcesado { get; set; }
        public Nullable<System.DateTime> FechaProcesado { get; set; }
        public string EXAMENCLINICOOBS { get; set; }
    }
}
