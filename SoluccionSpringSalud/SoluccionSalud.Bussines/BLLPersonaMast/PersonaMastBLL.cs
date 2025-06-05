using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALPersonaMast;


namespace SoluccionSalud.Repository.BLLPersonaMast
{
     
    public class PersonaMastBLL  
    {
        public List<PERSONAMAST> GetSelectPersonaMast(PERSONAMAST objSC)
        {
            return new PersonaMastRepository().GetSelectPersonaMast(objSC);
        }
    }
}
