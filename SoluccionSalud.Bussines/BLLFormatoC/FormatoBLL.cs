using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormatoC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormatoC
{
    public class FormatoBLL
    {
        public List<SS_HC_Formato> listarFormato(SS_HC_Formato objSC, int inicio, int final)
        {
            return new FormatoRepository().listarFormato(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_Formato ObjTrace)
        {
            return new FormatoRepository().setMantenimiento(ObjTrace);
        }
    }
}
