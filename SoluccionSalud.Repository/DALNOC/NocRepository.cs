using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.ModelPAE;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Repository.DALNOC
{
    public class NocRepository : AuditGenerico<SS_HC_NOC2, SS_HC_NOC2> 
    {
        public List<SS_HC_NOC2> listarNoc(SS_HC_NOC2 objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_NOC2> objLista = new List<SS_HC_NOC2>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_NOC_LISTAR2(
                    objSC.IdNoc,                   
                    objSC.Codigo,
                    objSC.CodigoPadre,
                    objSC.Descripcion, 
                    objSC.DescripcionCorta ,
                    objSC.Nivel, 
                    objSC.CadenaRecursiva,
                    objSC.Orden, 
                    objSC.Estado, 
                    objSC.UsuarioCreacion, 
                    objSC.FechaCreacion,
                    objSC.UsuarioModificacion, 
                    objSC.FechaModificacion, 
                    objSC.Accion, 
                    objSC.Version, 
                    inicio, 
                    final
                ).ToList();

             


                //DataKey = new
                //{
                //    IdNoc = objSC.IdNoc,
                //};
                //// Audit
                //String xlmIn = XMLString(objLista, new List<SS_HC_NOC2>(), "SS_HC_NOC2");
                //objAudit = AddAudita(new SS_HC_NOC2(), new SS_HC_NOC2(), DataKey, "L");
                //objAudit.TableName = "SS_HC_NOC2";
                //objAudit.Type = "L";
                //objAudit.Accion = "INSERT";
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_NOC2 objSC)
        {
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            //dynamic DataKey;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_NOC2 objAnterior = new SS_HC_NOC2();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_NOC2
                                           where t.IdNoc == objSC.IdNoc
                                           orderby t.IdNoc descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.SP_SS_HC_NOC2(
                            objSC.IdNoc,
                            objSC.Codigo,
                            objSC.CodigoPadre, 
                            objSC.Descripcion,                         
                            objSC.DescripcionCorta,
                            objSC.Nivel, 
                            objSC.CadenaRecursiva,
                            objSC.Orden, 
                            objSC.Estado, 
                            objSC.UsuarioCreacion, 
                            objSC.FechaCreacion,
                            objSC.UsuarioModificacion, 
                            objSC.FechaModificacion, 
                            objSC.Accion, 
                            objSC.Version
                 ).SingleOrDefault();

                        //DataKey = new
                        //{
                        //    IdNoc = objSC.IdNoc,
                        //};
                        //if (objAnterior == null) objAnterior = new SS_HC_NOC2();
                        //objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        //objAudit.TableName = "SS_HC_NOC2";
                        //objAudit.Type = objSC.Accion.Substring(0, 1);
                        //if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        //{
                        //    if (objAudit.Type != "L")
                        //    {
                        //        context.Entry(objAudit).State = EntityState.Added;
                        //        context.SaveChanges();
                        //    }
                        //}

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
