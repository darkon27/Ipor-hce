using SoluccionSalud.Bussines.BLLFormatosDinamicos;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormatoDinamico
{
   public class SvcFormatosDinamicos
    {
        public static int Listar(int ObjTrace)
        {
            return new FormatosDinamicosBLL().Listar(ObjTrace);
        }
        public static int ListarAnt(int ObjTrace)
        {
            return new FormatosDinamicosBLL().ListarAnt(ObjTrace);
        }
    }
}
