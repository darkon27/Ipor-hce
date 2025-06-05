
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service.ReglasLocal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.ReglasServicios
{
   
    public class SvcReglasServicios
    {
        public static String getReglas(ModelCliente valor)
        {
            
            ReglasSaludServiceImplService xx = new ReglasSaludServiceImplService();
            return xx.EjecutarRegla(45); 
        }
    }
    
}
