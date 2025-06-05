using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALTablaDatos;

namespace SoluccionSalud.Bussines.BLLTablaDatos
{
    public class TablaDatosBLL
    {
        public List<CM_CO_TablaMaestro> listarTablaDatos(CM_CO_TablaMaestro objSC, int inicio, int final)
        {
            return new TablaDatosRepository().listarTablaDatos(objSC, inicio, final);
        }

        public int setMantenimiento(CM_CO_TablaMaestro ObjTrace)
        {
            return new TablaDatosRepository().setMantenimiento(ObjTrace);
        }
    }
}
