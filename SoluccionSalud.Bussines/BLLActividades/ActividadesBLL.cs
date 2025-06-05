using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALActividades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLActividades
{
    public class ActividadesBLL
    {
        public List<SS_HC_Actividad> listarActividades(SS_HC_Actividad objSC, int inicio, int final)
        {
            return new actividadesRepository().listarActividades(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_Actividad ObjTrace)
        {
            return new actividadesRepository().setMantenimiento(ObjTrace);
        }
    }
}
