using SoluccionSalud.SOA.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.SOA.Bussines.SOA_Atenciones
{
    public class AtencionesOrigenBLL
    {
        public List<VW_ATENCIONPACIENTE_GENERAL> ListaAtenciones(VW_ATENCIONPACIENTE_GENERAL ObjTrace)
        {
            return new RepositySOA().ListaAtenciones(ObjTrace);
        }

        public int ListaConsultaExterna(SS_HCE_ConsultaExterna ObjTrace)
        {
            return new RepositySOA().ListaConsultaExterna(ObjTrace);
        }

        public int ListaRecetaConsultaExterna(SS_HCE_RecetaConsultaExterna ObjTrace)
        {
            return new RepositySOA().ListaRecetaConsultaExterna(ObjTrace);
        }
    }
}
