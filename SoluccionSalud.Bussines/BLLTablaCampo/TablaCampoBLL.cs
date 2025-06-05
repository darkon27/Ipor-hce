using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALTablaCampo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLTablaCampo
{
    public class TablaCampoBLL
    {
        public List<SS_HC_TablaCampo> listarTablaCampo(SS_HC_TablaCampo objSC, int inicio, int final)
        {
            return new TablaCampoRepository().listarTablaCampo(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_TablaCampo ObjTrace)
        {
            return new TablaCampoRepository().setMantenimiento(ObjTrace);
        }
    }
}
