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
    public class FactorRelacionadoRepository : AuditGenerico<SS_HC_FactorRelacionado, SS_HC_FactorRelacionado> 
    {
        public List<SS_HC_FactorRelacionado> listarFactorRelacionado(SS_HC_FactorRelacionado objSC, int inicio, int final)
        {
            /* dynamic DataKey = null;
             SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();*/
            List<SS_HC_FactorRelacionado> objLista = new List<SS_HC_FactorRelacionado>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_FactorRelacionado_LISTAR(
                    objSC.IdFactorRelacionado,
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

        public int setMantenimientoFR(SS_HC_FactorRelacionado objSC)
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
                        SS_HC_FactorRelacionado objAnterior = new SS_HC_FactorRelacionado();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_FactorRelacionado
                                           where t.IdFactorRelacionado == objSC.IdFactorRelacionado
                                           orderby t.IdFactorRelacionado descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.SP_SS_HC_FactorRelacionado(
                            objSC.IdFactorRelacionado,
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

        //public int setMantenimiento(SS_HC_FactorRelacionado objSC)
        //{
        //    dynamic DataKey;
        //    int valorRetorno = 0; //ERROR
        //    using (var context = new WEB_ERPSALUDEntities())
        //    {
        //        using (var dbContextTransaction = context.Database.BeginTransaction())
        //        {
        //            try
        //            {
        //                if (objSC != null)
        //                {
        //                    SS_HC_FactorRelacionado objAnterior = null;
        //                    if (objSC.Accion == null) objSC.Accion = "X";
        //                    if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
        //                    {
        //                        objAnterior = (from t in context.SS_HC_FactorRelacionado
        //                                       where
        //                                       t.IdFactorRelacionado == objSC.IdFactorRelacionado
        //                                       orderby t.IdFactorRelacionado descending
        //                                       select t).SingleOrDefault();
        //                    }
        //                    /**TRANSACCIÓN*/
        //                    if (objAnterior != null)
        //                    {
        //                        if (objSC.Accion == "UPDATE")
        //                        {
        //                            context.Entry(objSC).State = EntityState.Modified;
        //                        }
        //                        if (objSC.Accion == "DELETE")
        //                        {
        //                            context.Entry(objSC).State = EntityState.Deleted;
        //                        }
        //                    }
        //                    else
        //                    {
        //                        if (objSC.Accion == "INSERT")
        //                        {
        //                            context.Entry(objSC).State = EntityState.Added;
        //                        }
        //                        //InformacionObj = new SS_HC_MiscelaneosPacienteGeneral();
        //                    }
        //                    /*************/
        //                    /***** INICIO AUDITORÍA *****/
        //                    /*
        //                    DataKey = new
        //                    {
        //                        IdFactorRelacionado = objSC.IdFactorRelacionado,                                
        //                    };
        //                    //LLAMAR MÉTODO
        //                    if (objAnterior == null) objAnterior = new SS_HC_FactorRelacionado();
        //                    int resultAudit = setAuditoria(objAnterior, objSC, objSC.Accion, "SS_HC_FactorRelacionado",
        //                        new SS_HC_AuditRoyal(), DataKey, context);                      
        //                    */
        //                    /***TERMINA AUDITORÍA *****/
        //                    context.SaveChanges();
        //                    dbContextTransaction.Commit();
        //                    valorRetorno = 1;
        //                }
        //                else
        //                {
        //                    valorRetorno = -1;
        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                dbContextTransaction.Rollback();
        //                throw ex;
        //            }
        //        }
        //    }
        //    return valorRetorno;
        //}


    }
}
