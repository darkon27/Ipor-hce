using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.ModelPAE;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALFactorRelacionadoNanda
{
    public class FactorRelacionadoNandaRepository : AuditGenerico<SS_HC_FactorRelacionadoNanda, SS_HC_FactorRelacionadoNanda> 
    {

        public List<SS_HC_FactorRelacionadoNanda> listarFactorRelacionadoNanda(SS_HC_FactorRelacionadoNanda objSC, int inicio, int final)
        {
            /* dynamic DataKey = null;
             SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();*/
            List<SS_HC_FactorRelacionadoNanda> objLista = new List<SS_HC_FactorRelacionadoNanda>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_FactorRelacionadoNanda_LISTAR(

                    objSC.IdFRN,
                    objSC.IdNanda,
                    objSC.IdFactorRelacionado,
                    objSC.Descripcion,                    
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



                /*
                DataKey = new
                {
                    IdFactorRelacionado = objSC.IdFactorRelacionado,
                };

                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_FactorRelacionado>(), "SS_HC_FactorRelacionado");
                objAudit = AddAudita(new SS_HC_FactorRelacionado(), new SS_HC_FactorRelacionado(), DataKey, "L");
                objAudit.TableName = "SS_HC_FactorRelacionado";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
                 * */
            }
            return objLista;
        }

        public int setMantenimientoFRN(SS_HC_FactorRelacionadoNanda objSC)
        {
            /*  SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();*/
            /* dynamic DataKey;*/

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_FactorRelacionadoNanda objAnterior = new SS_HC_FactorRelacionadoNanda();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_FactorRelacionadoNanda
                                           where t.IdFRN == objSC.IdFRN
                                           orderby t.IdFRN descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.SP_SS_HC_FACTOR_NANDA(
                            objSC.IdFRN,
                            objSC.IdNanda,
                            objSC.IdFactorRelacionado,
                            objSC.Descripcion,                            
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
                        //    IdFactorRelacionado = objSC.IdFactorRelacionado,
                        //};
                        //if (objAnterior == null) objAnterior = new SS_HC_FactorRelacionado();
                        //objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        //objAudit.TableName = "SS_HC_FactorRelacionado";
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


        public int setMantenimientoFRN(List<SS_HC_FactorRelacionadoNanda> listaObjSC)
        {
            /*  SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();*/
            /* dynamic DataKey;*/


            System.Nullable<int> iReturnValue = 0;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {

                        if (listaObjSC != null)
                        {

                            foreach (var objSC in listaObjSC)
                            {


                                iReturnValue = context.SP_SS_HC_FACTOR_NANDA(
                                objSC.IdFRN,
                                objSC.IdNanda,
                                objSC.IdFactorRelacionado,
                                objSC.Descripcion,
                                objSC.Estado,
                                objSC.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO,
                                objSC.FechaCreacion,
                                objSC.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO,
                                objSC.FechaModificacion,
                                objSC.Accion,
                                objSC.Version
                                ).SingleOrDefault();
                            }
                        }
                        valorRetorno = Convert.ToInt32(iReturnValue);
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
