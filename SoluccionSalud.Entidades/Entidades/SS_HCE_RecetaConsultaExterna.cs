using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_HCE_RecetaConsultaExterna
    {
        public Nullable<Int32> IdOrdenAtencion { get; set; }
        public Nullable<Int32> LineaOA { get; set; }
        public Nullable<Int32> IdPaciente { get; set; }
        public string Componente { get; set; }
        public Nullable<Int32> Unidadmedida { get; set; }
        public string linea { get; set; }
        public string Familia { get; set; }
        public string Subfamilia { get; set; }
        public string Cantidad { get; set; }
        public Nullable<Int32> Via { get; set; }
        public string Dosis { get; set; }
        public string Diastratamiento { get; set; }
        public string Frecuencia { get; set; }
        public Nullable<Int32> IndicadorEPS { get; set; }
        public string Usuario { get; set; }
        public Nullable<DateTime> FechaCreacion { get; set; }
        public string IndicacionEspecifica { get; set; }
        public Nullable<Int32> lineamax { get; set; }
        public Nullable<Int32> TIPOORDENATENCION { get; set; }
        public string SecuenciaHCE { get; set; }

    }
}
