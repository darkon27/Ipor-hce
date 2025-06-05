using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DAL_ADICIONAL
{
    public class AgrupadorAtencionVigenteRepository : AuditGenerico<SS_HC_AgrupadorAtencionVigente, SS_HC_AgrupadorAtencionVigente> 
    {
        public List<SS_HC_AgrupadorAtencionVigente> listarSS_HC_AgrupadorAtencionVigente(
            SS_HC_AgrupadorAtencionVigente objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_AgrupadorAtencionVigente> objLista = new List<SS_HC_AgrupadorAtencionVigente>();
            using (var context = new WEB_ERPSALUDEntities())
            {     
                /*DataKey = new
                {
                    IdFormato = objSC.Secuencia,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_AgrupadorAtencionVigente>(), "SS_HC_AgrupadorAtencionVigente");
                objAudit = AddAudita(new SS_HC_AgrupadorAtencionVigente(), objSC, DataKey, "L");
                objAudit.TableName = "SS_HC_AgrupadorAtencionVigente";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
                */
            }
            return objLista;
        }
        public int setMantenimiento(List<SS_HC_AgrupadorAtencionVigente> listaObjSC) {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue =0;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaObjSC!=null)
                        {
                            foreach (var objSC in listaObjSC)
                            {
                                SS_HC_AgrupadorAtencionVigente objAnterior = new SS_HC_AgrupadorAtencionVigente();
                                if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                                {
                                    objAnterior = (from t in context.SS_HC_AgrupadorAtencionVigente
                                                   where
                                                   t.UnidadReplicacion == objSC.UnidadReplicacion
                                                   && t.IdPaciente == objSC.IdPaciente
                                                   && t.EpisodioClinico == objSC.EpisodioClinico
                                                   && t.IdOrdenAtencion == objSC.IdOrdenAtencion
                                                   orderby t.IdOrdenAtencion descending
                                                   select t).SingleOrDefault();
                                }
                                /*****/
                                /*****/
                                DataKey = new
                                {
                                    UnidadReplicacion = objSC.UnidadReplicacion,
                                    IdPaciente = objSC.IdPaciente,
                                    EpisodioClinico = objSC.EpisodioClinico,
                                    IdOrdenAtencion = objSC.IdOrdenAtencion,                                    

                                };
                                if (objAnterior == null) objAnterior = new SS_HC_AgrupadorAtencionVigente();
                                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                                objAudit.TableName = "SS_HC_AgrupadorAtencionVigente";
                                objAudit.Type = objSC.Accion.Substring(0, 1);
                                if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                                {
                                    if (objAudit.Type != "L")
                                    {
                                        context.Entry(objAudit).State = EntityState.Added;
                                        context.SaveChanges();
                                    }
                                }
                            }
                        }

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
        public int setMantenimiento(SS_HC_AgrupadorAtencionVigente objSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue = 0;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_AgrupadorAtencionVigente objAnterior = new SS_HC_AgrupadorAtencionVigente();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_AgrupadorAtencionVigente
                                           where 
                                           t.UnidadReplicacion == objSC.UnidadReplicacion
                                           && t.IdPaciente == objSC.IdPaciente
                                           && t.EpisodioClinico == objSC.EpisodioClinico
                                           && t.IdOrdenAtencion == objSC.IdOrdenAtencion
                                           orderby t.IdOrdenAtencion descending
                                           select t).SingleOrDefault();
                        }
                        /*****/
                        /***/
                        DataKey = new
                        {                            
                            UnidadReplicacion = objSC.UnidadReplicacion,
                            IdPaciente = objSC.IdPaciente,
                            EpisodioClinico = objSC.EpisodioClinico,
                            IdOrdenAtencion = objSC.IdOrdenAtencion,                           
                                           
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_AgrupadorAtencionVigente();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_AgrupadorAtencionVigente";
                        objAudit.Type = objSC.Accion.Substring(0, 1);
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
                            }
                        }

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
