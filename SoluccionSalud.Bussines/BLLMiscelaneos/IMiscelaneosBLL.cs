using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Bussines.BLLMiscelaneos
{
    
    public interface IMiscelaneosBLL
    {
        List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle objSC);

    }
}
