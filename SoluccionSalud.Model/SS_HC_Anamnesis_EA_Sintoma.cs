//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SoluccionSalud.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class SS_HC_Anamnesis_EA_Sintoma
    {
        public string UnidadReplicacion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public int EpisodioClinico { get; set; }
        public int Secuencia { get; set; }
        public int IdCIAP2 { get; set; }
        public string Accion { get; set; }
        public string Version { get; set; }
    
        public virtual SS_HC_Anamnesis_EA SS_HC_Anamnesis_EA { get; set; }
    }
}
