using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.BLLPersonaMast
{
     public interface IPersonaMasBLL  
    {
        List<SS_CE_DICCIONARIO> GetSelectDiccionario(SS_CE_DICCIONARIO objSC);
     
    }
}
