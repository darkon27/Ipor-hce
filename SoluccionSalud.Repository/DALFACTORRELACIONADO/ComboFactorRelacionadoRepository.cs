using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.ModelPAE;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;


namespace SoluccionSalud.Repository.DALFACTORRELACIONADO
{
    public class ComboFactorRelacionadoRepository : AuditGenerico<SS_HC_FactorRelacionado, SS_HC_FactorRelacionado> 
    {
        public List<SS_HC_FactorRelacionado> listarFactorRelacionadocombos(SS_HC_FactorRelacionado objSC, int inicio, int final)
        {
            
            List<SS_HC_FactorRelacionado> objLista = new List<SS_HC_FactorRelacionado>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_FactorRelacionado_listarcombo(
                   objSC.IdFactorRelacionado,
                    objSC.Descripcion,
                    objSC.Accion
                  
                ).ToList();



            }
            return objLista;
        }
    }
}
