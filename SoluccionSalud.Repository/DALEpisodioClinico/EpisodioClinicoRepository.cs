using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALEpisodioClinico
{
    public class EpisodioClinicoRepository : AuditGenerico<SS_HC_EpisodioClinico, SS_HC_EpisodioClinico> 
    {
        public List<SS_HC_EpisodioClinico> listarSS_HC_EpisodioClinico(SS_HC_EpisodioClinico objSC, int inicio, int final)
        {
            try
            {
                /////
                using (var context = new WEB_ERPSALUDEntities())
                {
                    return context.USP_SS_HC_EpisodioClinicoListar(
                         objSC.UnidadReplicacion
                        , objSC.IdPaciente
                        , objSC.EpisodioClinico
                        , objSC.FechaRegistro
                        , objSC.FechaCierre
                        , objSC.Estado
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.CodigoEpisodioClinico
                        , objSC.FlagMedico
                        , objSC.FlagEnfermera
                        , objSC.IdOrdenAtencion
                        , inicio
                        , final
                        , objSC.ACCION

                    ).ToList();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int setMantenimiento(SS_HC_EpisodioClinico objSC)
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
                        SS_HC_EpisodioClinico objAnterior = new SS_HC_EpisodioClinico();
                        if (objSC.ACCION != "EPISODIOCLINICO")
                        {
                            objAnterior = (from t in context.SS_HC_EpisodioClinico
                                           where t.UnidadReplicacion == objSC.UnidadReplicacion                                           
                                          && t.EpisodioClinico == objSC.EpisodioClinico
                                          && t.IdPaciente == objSC.IdPaciente
                                           orderby t.EpisodioClinico descending
                                           select t).SingleOrDefault();
                        }

                        iReturnValue = context.USP_SS_HC_EpisodioClinico(
                         objSC.UnidadReplicacion
                        , objSC.IdPaciente
                        , objSC.EpisodioClinico
                        , objSC.FechaRegistro
                        , objSC.FechaCierre
                        , objSC.Estado
                        , objSC.UsuarioCreacion
                        , objSC.FechaCreacion
                        , objSC.UsuarioModificacion
                        , objSC.FechaModificacion
                        , objSC.CodigoEpisodioClinico
                        , objSC.FlagMedico
                        , objSC.FlagEnfermera
                        , objSC.IdOrdenAtencion                        
                        , objSC.ACCION
                            ).SingleOrDefault();
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        if (objSC.ACCION != "EPISODIOCLINICO")
                        {
                            //*  Registra Audit/
                            DataKey = new
                            {
                                UnidadReplicacion = objSC.UnidadReplicacion,                                
                                IdPaciente = objSC.IdPaciente,
                                EpisodioClinico = objSC.EpisodioClinico
                            };
                            if (objAnterior == null) objAnterior = new SS_HC_EpisodioClinico();
                            objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                            objAudit.TableName = "SS_HC_EpisodioClinico";
                            if (objSC.ACCION == "INSERT" || objSC.ACCION == "CONTINUAR")
                            {
                                objAudit.Type = "I";
                            }
                            else
                            {
                                objAudit.Type = "U";
                            }
                            if (valorRetorno > 0)
                            {
                                if (objAudit.Type != "L")
                                {
                                    context.Entry(objAudit).State = EntityState.Added;
                                    context.SaveChanges();
                                }
                            }
                        }
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
