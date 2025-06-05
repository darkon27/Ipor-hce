using System;
using System.Collections.Generic;
using System.Web;

namespace SoluccionSalud.Entidades.Entidades
{
     [Serializable()]
    public partial class ENTITY_GENERALHCE
    {
        public Nullable<int> IDENTIY_GEN { get; set; }
        public string UnidadReplicacion { get; set; }
        public Nullable<int> PacienteID { get; set; }
        public Nullable<int> EpisodioClinico { get; set; }
        public Nullable<long> EpisodioAtencion { get; set; }
        public string USUARIO { get; set; }
        public string ACCION { get; set; }

        public string campoStr01 { get; set; }
        public string campoStr02 { get; set; }
        public string campoStr03 { get; set; }
        public string campoStr04 { get; set; }
        public string campoStr05 { get; set; }
        public string campoStr06 { get; set; }
        public string campoStr07 { get; set; }
        public string campoStr08 { get; set; }
        public string campoStr09 { get; set; }
        public string campoStr10 { get; set; }
        public string campoStr11 { get; set; }
        public string campoStr12 { get; set; }
        public string campoStr13 { get; set; }
        public string campoStr14 { get; set; }
        public string campoStr15 { get; set; }

        public Nullable<int> campoInt01 { get; set; }
        public Nullable<int> campoInt02 { get; set; }
        public Nullable<int> campoInt03 { get; set; }
        public Nullable<int> campoInt04 { get; set; }
        public Nullable<int> campoInt05 { get; set; }
        public Nullable<int> campoInt06 { get; set; }
        public Nullable<int> campoInt07 { get; set; }
        public Nullable<int> campoInt08 { get; set; }
        public Nullable<int> campoInt09 { get; set; }
        public Nullable<int> campoInt10 { get; set; }

        public Nullable<DateTime> campoDate01 { get; set; }
        public Nullable<DateTime> campoDate02 { get; set; }
        public Nullable<DateTime> campoDate03 { get; set; }
        public Nullable<DateTime> campoDate04 { get; set; }
        public Nullable<DateTime> campoDate05 { get; set; }

        public Nullable<Double> campoDouble01 { get; set; }
        public Nullable<Double> campoDouble02 { get; set; }
        public Nullable<Double> campoDouble03 { get; set; }
        public Nullable<Double> campoDouble04 { get; set; }
        public Nullable<Double> campoDouble05 { get; set; }

        public virtual Object objetoGen { get; set; }
        public static ENTITY_GENERALHCE Instance
        {
            get
            {
                ENTITY_GENERALHCE obj = (ENTITY_GENERALHCE)HttpContext.Current.Session["ENTITY_GENERALHCE"];
                return obj;
            }
        }     
    }
}
