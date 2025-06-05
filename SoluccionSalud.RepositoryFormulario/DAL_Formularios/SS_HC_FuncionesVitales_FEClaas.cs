using System;

namespace SoluccionSalud.RepositoryFormulario.DAL_Formularios
{
    public class SS_HC_FuncionesVitales_FEClaas
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdFuncionVital { get; set; }
        public Nullable<System.DateTime> Fecha { get; set; }
        public Nullable<System.DateTime> Hora { get; set; }
        public Nullable<int> PresionArterialMSD1 { get; set; }
        public Nullable<int> PresionArterialMSD2 { get; set; }
        public Nullable<int> PresionArterialMSI { get; set; }
        public Nullable<int> PresionArterialMS2 { get; set; }
        public Nullable<decimal> FrecuenciaCardiaca { get; set; }
        public Nullable<int> FrecuenciaRespiratoria { get; set; }
        public Nullable<decimal> Temperatura { get; set; }
        public Nullable<int> SaturacionOxigeno { get; set; }
        public Nullable<int> Fi02 { get; set; }
        public Nullable<int> FrecuenciaCardFetal_Flag { get; set; }
        public Nullable<int> FrecuenciaCard_FetalAdd { get; set; }
        public Nullable<decimal> Peso { get; set; }
        public Nullable<decimal> Talla { get; set; }
        public Nullable<decimal> IMC { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    }
}