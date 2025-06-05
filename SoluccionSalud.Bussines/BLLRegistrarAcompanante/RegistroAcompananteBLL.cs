using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALRegistrarAcompanante;

namespace SoluccionSalud.Bussines.BLLRegistrarAcompanante
{
    public class RegistroAcompananteBLL
    {
        public List<SS_HC_RegistroAcompanante> listarRegistroAcompanante(SS_HC_RegistroAcompanante objSC, int inicio, int final)
        {
            return new RegistroAcompananteRepository().listarRegistroAcompanante(objSC, inicio, final);
        }

        public int setMantenimientoRegistroAcompanante(SS_HC_RegistroAcompanante ObjTrace)
        {
            return new RegistroAcompananteRepository().setMantenimientoRegistroAcompanante(ObjTrace);
        }
    }
}
