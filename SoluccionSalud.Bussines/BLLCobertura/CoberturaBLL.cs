using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCobertura;

namespace SoluccionSalud.Bussines.BLLCobertura
{
    public class CoberturaBLL
    {
        public List<SS_SG_MaestroCobertura> listarCobertura(SS_SG_MaestroCobertura objSC, int inicio, int final)
        {
            return new CoberturaBaseRepository().listarCobertura(objSC, inicio, final);
        }

        public int setMantenimiento(SS_SG_MaestroCobertura ObjTrace)
        {
            return new CoberturaBaseRepository().setMantenimiento(ObjTrace);
        }
    }
}
