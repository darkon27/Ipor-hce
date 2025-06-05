using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALMiscelaneos;

namespace SoluccionSalud.Bussines.BLLMiscelaneos
{
     
    public class MiscelaneosBLL
    {
        public List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle objSC)
        {
            return new MiscelaneosRepository().GetUpListadoServicios(objSC);
        }
        public int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
        {
            return new MiscelaneosRepository().setMantenimiento(ObjTrace);
        }
    }

}
