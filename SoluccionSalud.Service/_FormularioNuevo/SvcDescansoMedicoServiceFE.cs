using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Bussines;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;



namespace SoluccionSalud.Service._FormularioNuevo

{
    public class SvcDescansoMedicoServiceFE
    {
        public static int DescansoMedico(SS_HC_DescansoMedico_FE objSC)
        {
            return new DescansoMedicoFERepository().DescansoMedico(objSC);
        }

        public static List<SS_HC_DescansoMedico_FE> DescansoMedicoListar(SS_HC_DescansoMedico_FE objSC)
        {
            return new DescansoMedicoFERepository().DescansoMedicoListar(objSC);
        }

        public static Int32 setMantenimiento(SS_HC_DescansoMedico_FE ObjTraces, List<SS_HC_DescansoMedico_FE> Cabecera, List<SS_HC_DescansoMedico_FE> Detalle)
        {

            return new DescansoMedicoFERepository().setMantenimiento(ObjTraces, Cabecera, Detalle);
        }

     

    }
}




