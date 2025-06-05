using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALvw_miscelaneo;

namespace SoluccionSalud.Bussines.BLLVw_Miscelaneo
{
    public class Vw_MiscelaneoBLL
    {
        public List<vw_Miscelaneos> listarVw_Miscelaneos(vw_Miscelaneos objSC, int inicio, int final)
        {
            return new vw_miscelaneoRepository().listarVw_Miscelaneos(objSC, inicio, final);
        }

        public int setMantenimiento(vw_Miscelaneos ObjTrace)
        {
            return new vw_miscelaneoRepository().setMantenimiento(ObjTrace);
        }
    }
}
