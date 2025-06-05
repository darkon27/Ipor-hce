using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALHC_CIAP2
{
    public class HC_CIAP2Repository : AuditGenerico<SS_HC_CIAP2, SS_HC_CIAP2> 
    {
        public List<SS_HC_CIAP2> listarSS_HC_CIAP2(SS_HC_CIAP2 objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_CIAP2> objLista = new List<SS_HC_CIAP2>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_CIAP2Listar(objSC.IdCIAP2, objSC.IdCIAP2Padre, objSC.Codigo,
                    objSC.RubricaCompleta,objSC.RubricaAbreviada,objSC.Nivel,objSC.Incluido,
                    objSC.Excluido,objSC.Criterios,objSC.Consideraciones,objSC.Notas,objSC.CIE10,
                    objSC.IdComponente,objSC.Estado,objSC.UsuarioCreacion,objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();

                DataKey = new
                {
                    IdCIAP2 = objSC.IdCIAP2
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_CIAP2>(), "SS_HC_CIAP2");
                objAudit = AddAudita(new SS_HC_CIAP2(), objSC, DataKey, "L");
                objAudit.TableName = "SS_HC_CIAP2";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }

        public int setMantenimiento(SS_HC_CIAP2 objSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_CIAP2 objAnterior = new SS_HC_CIAP2();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_CIAP2
                                           where t.IdCIAP2 == objSC.IdCIAP2
                                           orderby t.IdCIAP2 descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SS_HC_CIAP2(
                objSC.IdCIAP2, objSC.IdCIAP2Padre, objSC.Codigo,
                    objSC.RubricaCompleta, objSC.RubricaAbreviada, objSC.Nivel, objSC.Incluido,
                    objSC.Excluido, objSC.Criterios, objSC.Consideraciones, objSC.Notas, objSC.CIE10,
                    objSC.IdComponente, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdCIAP2 = objSC.IdCIAP2
                };
                if (objAnterior == null) objAnterior = new SS_HC_CIAP2();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_HC_CIAP2";
                objAudit.Type = objSC.Accion.Substring(0, 1);
                if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                {
                    if (objAudit.Type != "L")
                    {
                        context.Entry(objAudit).State = EntityState.Added;
                        context.SaveChanges();
                    }
                }

                //*/
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                
                dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }

    }
}
