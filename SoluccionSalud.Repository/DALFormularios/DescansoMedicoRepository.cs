using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALFormularios
{

    public class DescansoMedicoRepository : AuditGenerico<SS_HC_DescansoMedico, SS_HC_DescansoMedico> 
    {
        public int DescansoMedico(SS_HC_DescansoMedico ObjTrace)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        SS_HC_DescansoMedico objAnterior = new SS_HC_DescansoMedico();
                        if ((ObjTrace.Accion.Substring(0, 1) != "I") || (ObjTrace.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_DescansoMedico
                                                  where t.IdPaciente == ObjTrace.IdPaciente
                                                  && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                  && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                  && t.UnidadReplicacion == ObjTrace.UnidadReplicacion
                                                  orderby t.IdEpisodioAtencion descending
                                                  select t).SingleOrDefault();                            

                        }

                        iReturnValue = context.USP_DescansoMedico(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                        ObjTrace.EpisodioClinico, ObjTrace.FechaInicioDescanso, ObjTrace.FechaFinDescanso, ObjTrace.Observacion,
                        ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                        ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Dias).SingleOrDefault();
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        

                        //*  Registra Audit/
                        DataKey = new
                        {
                            IdPaciente = ObjTrace.IdPaciente,
                            IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                            EpisodioClinico = ObjTrace.EpisodioClinico,
                            UnidadReplicacion = ObjTrace.UnidadReplicacion

                        };
                        if (objAnterior == null) objAnterior = new SS_HC_DescansoMedico();
                        objAudit = AddAudita(objAnterior, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_DescansoMedico";
                        objAudit.Type = ObjTrace.Accion.Substring(0, 1);
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
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
        public List<SS_HC_DescansoMedico> DescansoMedicoListar(SS_HC_DescansoMedico ObjTrace)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_DescansoMedico> objLista = new List<SS_HC_DescansoMedico>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_DescansoMedicoListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.FechaInicioDescanso, ObjTrace.FechaFinDescanso, ObjTrace.Observacion,
                    ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Dias).ToList();


                DataKey = new
                {
                    IdPaciente = ObjTrace.IdPaciente,
                    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                    EpisodioClinico = ObjTrace.EpisodioClinico,                    

                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_DescansoMedico>(), "SS_HC_DescansoMedico");
                objAudit = AddAudita(new SS_HC_DescansoMedico(), ObjTrace, DataKey, "L");
                objAudit.TableName = "SS_HC_DescansoMedico";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

    }
}
