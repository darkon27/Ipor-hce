using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLDiccionario;
using SoluccionSalud.Bussines.BLLSeguridadConcepto;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.DiccionarioService
{

    public class SvcDiccionario
    {
        public static List<SS_CE_DICCIONARIO> GetSelectDiccionario(SS_CE_DICCIONARIO objSC)
        {
            return new DiccionarioBLL().GetSelectDiccionario(objSC);
        }
        
    }
}
