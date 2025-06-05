using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace SoluccionSalud.Entidades.Entidades
{
   
   [Serializable()]
    public partial class BE_EPICRISIS
    {
        public int EPICRISISID { get; set; }
      
       public string EPI_ANAMNESIS { get; set; }
      
    
    }
}
