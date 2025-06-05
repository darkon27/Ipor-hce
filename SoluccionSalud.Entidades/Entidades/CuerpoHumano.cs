using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
   public class CuerpoHumano
    {
       public Nullable<int> Id { get; set; }

       public Nullable<int> IdCounter { get; set; }
        public string Name { get; set; }

        public string X { get; set; }
        public string Y { get; set; }
    }
}
