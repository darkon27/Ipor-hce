using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.ModelPAE;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Repository.DALIndicador
{
    public class indicadorRepository : AuditGenerico<SS_HC_IndicadorPAE, SS_HC_IndicadorPAE> 
    {
        public List<SS_HC_IndicadorPAE> listarindicador(SS_HC_IndicadorPAE objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_IndicadorPAE> objLista = new List<SS_HC_IndicadorPAE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_IndicadorPAE_LISTAR(
                           objSC.IdIndicadorPAE
                         , objSC.Descripcion
                         , objSC.Estado
                         , objSC.UsuarioCreacion
                         , objSC.FechaCreacion
                         , objSC.UsuarioModificacion
                         , objSC.FechaModificacion
                         , inicio
                         , final
                         , objSC.Accion
                         , objSC.Version


                     ).ToList();

                //DataKey = new
                //{
                //  dominio1 = objSC.IdDominioPAE1,
                //};
                //// Audit
                //String xlmIn = XMLString(objLista, new List<SS_HC_DominioPAE>(), "SS_HC_DominioPAE");
                //objAudit = AddAudita(new SS_HC_DominioPAE(), objSC, DataKey, "L");
                //objAudit.TableName = "SS_HC_DominioPAE";
                //objAudit.Type = "L";
                //objAudit.Accion = "INSERT";
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_IndicadorPAE objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.SP_SS_HC_IndicadorPAE(
                         objSC.IdIndicadorPAE
                        , objSC.Descripcion
                        , objSC.Estado
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.Accion

                     ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
