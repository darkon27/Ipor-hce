using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.ModelPAE;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALNocIndicador
{
    public class NocIndicadorRepository : AuditGenerico<SS_HC_NOCIndicador, SS_HC_NOCIndicador> 
    {
        public List<SS_HC_NOCIndicador> listarNocIndicador(SS_HC_NOCIndicador objSC, int inicio, int final)
        {
            /* dynamic DataKey = null;
             SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();*/
            List<SS_HC_NOCIndicador> objLista = new List<SS_HC_NOCIndicador>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_NocIndicador_LISTAR(

                    objSC.IdNIN,
                    objSC.IdNoc,
                    objSC.IdIndicadorPAE,
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

        public int setMantenimientoNocIndicador(SS_HC_NOCIndicador objSC)
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
                        SS_HC_NOCIndicador objAnterior = new SS_HC_NOCIndicador();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_NOCIndicador
                                           where t.IdNIN == objSC.IdNIN
                                           orderby t.IdNIN descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.SP_SS_HC_NOC_INDICADOR(
                            objSC.IdNIN,
                            objSC.IdNoc,
                            objSC.IdIndicadorPAE,
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


        public int setMantenimientoNocIndicador(List<SS_HC_NOCIndicador> listaObjSC)
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


                                iReturnValue = context.SP_SS_HC_NOC_INDICADOR(
                                objSC.IdNIN,
                                objSC.IdNoc,
                                objSC.IdIndicadorPAE,
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
