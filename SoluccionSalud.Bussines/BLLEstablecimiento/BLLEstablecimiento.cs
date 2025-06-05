using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALEstablecimiento;


namespace SoluccionSalud.Bussines.BLLEstablecimiento
{
    public class BLLEstablecimiento
    {
         public List<CM_CO_Establecimiento> listarEstablecimiento(CM_CO_Establecimiento objSC, int inicio, int final)
        {
            return new EstablecimientoRepository().listarEstablecimiento(objSC, inicio, final);
        }

        public int setMantenimiento(CM_CO_Establecimiento ObjTrace)
        {
            return new EstablecimientoRepository().setMantenimiento(ObjTrace);
        }
    }
}
