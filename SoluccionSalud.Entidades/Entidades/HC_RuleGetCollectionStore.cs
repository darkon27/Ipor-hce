using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class HC_RuleGetCollectionStore : MA_MiscelaneosDetalle
    {
        public Nullable<System.DateTime> ValorFechaInicio { get; set; }
        public Nullable<System.DateTime> ValorFechaFinal { get; set; }
        public Nullable<int> inicio { get; set; }
        public Nullable<int> final { get; set; }
    }
}
