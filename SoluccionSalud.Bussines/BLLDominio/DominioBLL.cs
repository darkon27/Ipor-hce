using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALDominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLDominio
{
    public class DominioBLL
    {
        public List<SS_HC_DominioPAE> listardominio(SS_HC_DominioPAE objSC, int inicio, int final)
        {
            return new dominioRepository().listardominio(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_DominioPAE ObjTrace)
        {
             return new dominioRepository().setMantenimiento(ObjTrace);
        }

    }
}
