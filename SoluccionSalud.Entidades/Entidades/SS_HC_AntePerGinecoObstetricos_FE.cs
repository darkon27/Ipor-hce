//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_HC_AntePerGinecoObstetricos_FE
    {
        public SS_HC_AntePerGinecoObstetricos_FE()
        {
            this.SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE = new HashSet<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE>();
            this.SS_HC_GINECOOBSTETRICOS_Diagnostico_FE = new HashSet<SS_HC_GINECOOBSTETRICOS_Diagnostico_FE>();
        }
    
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int IdGinecoobstetricos { get; set; }
        public string AntFisioGinecologico_flag { get; set; }
        public Nullable<int> PrimeraRelacionSexual { get; set; }
        public string PrimeraRelacionSexual_flag { get; set; }
        public Nullable<System.DateTime> RelacionesSexuales { get; set; }
        public string RelacionesSexuales_flag { get; set; }
        public Nullable<int> NoParejasSexuales { get; set; }
        public string NoParejasSexuales_flag { get; set; }
        public string ConductaSexualRiesgo { get; set; }
        public string ConductaSexualRiesgo_flag { get; set; }
        public string Barrera_flag { get; set; }
        public string Hormonal_flag { get; set; }
        public string DIU_flag { get; set; }
        public string Ritmo_flag { get; set; }
        public string NoUsa_flag { get; set; }
        public Nullable<System.DateTime> Menarquia { get; set; }
        public Nullable<System.DateTime> FUR { get; set; }
        public Nullable<int> RegimenCatamenialNoDias { get; set; }
        public Nullable<int> RegimenCatamenialNoIntervalo { get; set; }
        public string Dismenorrea { get; set; }
        public string menstruaciones { get; set; }
        public string Leucorrea { get; set; }
        public Nullable<System.DateTime> UltimoPAP { get; set; }
        public string UltimoPAP_flag { get; set; }
        public string UltimoPAP_Resultado { get; set; }
        public Nullable<System.DateTime> Mamografia { get; set; }
        public string Mamografia_flag { get; set; }
        public string Mamografia_Resultado { get; set; }
        public string AntFisioObstetrico_flag { get; set; }
        public Nullable<int> Gravidez { get; set; }
        public Nullable<int> ParidadATermino { get; set; }
        public Nullable<int> ParidadObitoPrematuro { get; set; }
        public Nullable<int> ParidadAborto { get; set; }
        public Nullable<int> ParidadVivo { get; set; }
        public string Abortos_flag { get; set; }
        public Nullable<int> AbortosNo { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
        public Nullable<int> TotalPartos { get; set; }
        public Nullable<int> NoPartosEutocicos { get; set; }
        public Nullable<int> NoPartosDistocicos { get; set; }
        public string PartosGemelares { get; set; }
    
        public virtual ICollection<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE> SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE { get; set; }
        public virtual ICollection<SS_HC_GINECOOBSTETRICOS_Diagnostico_FE> SS_HC_GINECOOBSTETRICOS_Diagnostico_FE { get; set; }
    }
    
}
