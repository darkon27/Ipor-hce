using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class BE_Medicamento_FE : SS_HC_Medicamento_FE 
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
        public Nullable<int> GrupoMedicamento { get; set; }
        public int medDia { get; set; }
        public int medHora { get; set; }

        public Nullable<System.DateTime> HoraInicio { get; set; }
        public Nullable<System.DateTime> HoraAdministracion { get; set; }


    }
}
