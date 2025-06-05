using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALcompanyowner;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace SoluccionSalud.Bussines.BLLcompanyowner
{
    public class companyownerBLL
    {
        public List<companyowner> listarcompanyowner(companyowner objSC, int inicio, int final)
        {
            return new companyownerRepository().listarcompanyowner(objSC, inicio, final);
        }

        public int setMantenimiento(companyowner ObjTrace)
        {
            return new companyownerRepository().setMantenimiento(ObjTrace);
        }
    }
}
