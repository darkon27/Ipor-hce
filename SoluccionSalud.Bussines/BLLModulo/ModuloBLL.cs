using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALModulo;

namespace SoluccionSalud.Bussines.BLLModulo
{
   public class ModuloBLL
   {
       public List<SG_Modulo> listarModulos(SG_Modulo objSC, int inicio, int final)
       {
           return new ModuloRepository().listarModulos(objSC, inicio, final);
       }

       public int setMantenimiento(SG_Modulo ObjTrace)
       {
           return new ModuloRepository().setMantenimiento(ObjTrace);
       }
    }
}
