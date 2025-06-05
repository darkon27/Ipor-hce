using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALTabla;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLTabla
{
    public class TablaBLL
    {
        public List<SS_HC_Tabla> listarTabla(SS_HC_Tabla objSC, int inicio, int final)
        {
            return new TablaRepository().listarTabla(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_Tabla ObjTrace)
        {
            return new TablaRepository().setMantenimiento(ObjTrace);
        }
    }
}
