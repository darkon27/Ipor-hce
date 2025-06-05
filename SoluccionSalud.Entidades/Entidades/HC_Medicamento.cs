using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class HC_Medicamento : SS_HC_Medicamento 
    {
        public string LineaBusqueda { get; set; }
        public string LineaDescripcion { get; set; }
        public string FamiliaDescripcion { get; set; }
        public string SubFamiliaDescripcion { get; set; }
        public string Medicamento { get; set; }
        public string MedicamentoDescripcion { get; set; }
        public int SecuenciaMedicamento { get; set; }
        public int SecuenciaId { get; set; }
        public string TipoRegistro { get; set; }
        public Nullable<int> Correlativo { get; set; }
        public Nullable<int> IdTipoIndicacion { get; set; }
        public string Descripcion { get; set; }
    }

    
}
