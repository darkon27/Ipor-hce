using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALParametrosMast;

namespace SoluccionSalud.Bussines.BLLParametro
{
    public class ParametroBLL
    {
        public List<ParametrosMast> listarParametro(ParametrosMast objSC, int inicio, int final)
        {
            return new ParametroRepository().listarParametro(objSC, inicio, final);
        }

        public List<ParametrosMast> listarParametroWServicio(ParametrosMast objSC, int inicio, int final)
        {
            return new ParametroRepository().listarParametroWServicio(objSC, inicio, final);
        }

        public int setMantenimiento(ParametrosMast ObjTrace)
        {
            return new ParametroRepository().setMantenimiento(ObjTrace);
        }
        public ParametrosMast getMantenimientoPoId(ParametrosMast ObjTrace)
        {
            return new ParametroRepository().getMantenimientoPoId(ObjTrace);
        }
    }
}
