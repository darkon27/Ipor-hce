using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALcompanyowner
{
    public class companyownerRepository : AuditGenerico<companyowner, companyowner> 
    {
        public List<companyowner> listarcompanyowner(companyowner objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<companyowner> objLista = new List<companyowner>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_companyowner_LISTAR(
                         objSC.companyowner1
                        , objSC.description
                        , objSC.englishdescription
                        , objSC.percentage
                        , objSC.company
                        , objSC.owner
                        , objSC.ChangeRate
                        , objSC.lastuser
                        , objSC.lastdate                                           
                    , inicio, final  , objSC.ACCION  
                    ).ToList();
                DataKey = new
                {
                    companyowner1 = objSC.companyowner1,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<companyowner>(), "companyowner");
                objAudit = AddAudita(new companyowner(), objSC, DataKey, "L");
                objAudit.TableName = "companyowner";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(companyowner objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_companyowner(
                         objSC.companyowner1
                        , objSC.description
                        , objSC.englishdescription
                        , objSC.percentage
                        , objSC.company
                        , objSC.owner
                        , objSC.ChangeRate
                        , objSC.lastuser
                        , objSC.lastdate
                        , objSC.ACCION 

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
