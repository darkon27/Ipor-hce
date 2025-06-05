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
    public class EvolucionObjetivaRepository : AuditGenerico<SS_HC_EvolucionObjetiva, SS_HC_EvolucionObjetiva> 
    {

        public SS_HC_EvolucionObjetiva getPorId_SS_HC_EvolucionObjetiva(
                    SS_HC_EvolucionObjetiva objSC)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            SS_HC_EvolucionObjetiva objResult = null;
            using (var context = new WEB_ERPSALUDEntities())
            {
                SS_HC_EvolucionObjetiva objConsulta = (from t in context.SS_HC_EvolucionObjetiva
                                                              where
                                                              t.UnidadReplicacion == objSC.UnidadReplicacion
                                                              && t.IdPaciente == objSC.IdPaciente
                                                              && t.EpisodioClinico == objSC.EpisodioClinico
                                                              && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                              orderby t.IdEpisodioAtencion descending
                                                              select t).SingleOrDefault();

                if (objConsulta != null)
                {
                    objResult = objConsulta;
                }         
            }
            return objResult;
        }

        public List<SS_HC_EvolucionObjetiva> listarSS_HC_EvolucionObjetiva(
                    SS_HC_EvolucionObjetiva objSC)
        {

            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_EvolucionObjetiva> objLista = new List<SS_HC_EvolucionObjetiva>();
            using (var context = new WEB_ERPSALUDEntities())
            {

                List<SS_HC_EvolucionObjetiva> objConsultas = (from t in context.SS_HC_EvolucionObjetiva
                                                        where
                                                        t.UnidadReplicacion == objSC.UnidadReplicacion
                                                        && t.IdPaciente == objSC.IdPaciente
                                                        && t.EpisodioClinico == objSC.EpisodioClinico
                                                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                        orderby t.IdEpisodioAtencion descending
                                                        select t).ToList();



                if (objConsultas != null)
                {
                    objLista.AddRange(objConsultas);
                }

                 DataKey = new
                 {
                    UnidadReplicacion = objSC.UnidadReplicacion,
                    IdPaciente = objSC.IdPaciente,
                    EpisodioClinico = objSC.EpisodioClinico,
                    IdEpisodioAtencion = objSC.IdEpisodioAtencion
                 };

                 String accionTemp  = "V";                    
                 if (objLista.Count > 1) accionTemp = "L";

                 String xlmIn = XMLString(objLista, new List<SS_HC_EvolucionObjetiva>(), "SS_HC_EvolucionObjetiva");
                 setAuditoriaListado(new SS_HC_EvolucionObjetiva(), new SS_HC_EvolucionObjetiva(), accionTemp,
                     "SS_HC_EvolucionObjetiva", objAudit, DataKey, xlmIn);
      
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_EvolucionObjetiva objSC)
        {            
            dynamic DataKey;            
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (objSC!=null)
                        {
                            SS_HC_EvolucionObjetiva objAnterior = null;
                            if (objSC.Accion == null) objSC.Accion = "X";
                            if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                            {
                                objAnterior = (from t in context.SS_HC_EvolucionObjetiva
                                               where
                                               t.UnidadReplicacion == objSC.UnidadReplicacion
                                               && t.IdPaciente == objSC.IdPaciente
                                               && t.EpisodioClinico == objSC.EpisodioClinico
                                               && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                               orderby t.IdEpisodioAtencion descending
                                               select t).SingleOrDefault();
                            }
                            /**TRANSACCIÓN*/
                            if (objAnterior != null)
                            {
                                if (objSC.Accion == "UPDATE")
                                {
                                    objSC.Accion = objSC.Version;
                                    context.Entry(objSC).State = EntityState.Modified;
                                }
                            }
                            else
                            {
                                if (objSC.Accion == "NUEVO")
                                {
                                    objSC.Accion = objSC.Version;
                                    context.Entry(objSC).State = EntityState.Added;
                                }
                                //InformacionObj = new SS_HC_MiscelaneosPacienteGeneral();
                            }
                            /*************/
                            /***** INICIO AUDITORÍA *****/
                            DataKey = new
                            {
                                UnidadReplicacion = objSC.UnidadReplicacion,
                                IdPaciente = objSC.IdPaciente,
                                EpisodioClinico = objSC.EpisodioClinico,
                                IdOrdenAtencion = objSC.IdEpisodioAtencion,
                            };
                            //LLAMAR MÉTODO
                            if (objAnterior == null) objAnterior = new SS_HC_EvolucionObjetiva();
                            int resultAudit = setAuditoria(objAnterior, objSC, objSC.Accion, "SS_HC_EvolucionObjetiva", 
                                new SS_HC_AuditRoyal(), DataKey, context);
                            /*
                            if (objAnterior == null) objAnterior = new SS_HC_EvolucionObjetiva();
                            objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                            objAudit.TableName = "SS_HC_EvolucionObjetiva";
                            objAudit.Type = objSC.Accion.Substring(0, 1);
                            if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                            {
                                if (objAudit.Type != "L")
                                {
                                    context.Entry(objAudit).State = EntityState.Added;
                                    context.SaveChanges();
                                }
                            }*/
                            /***TERMINA AUDITORÍA *****/
                            context.SaveChanges();                            
                            dbContextTransaction.Commit();
                            valorRetorno = 1;
                        }
                        else
                        {
                            valorRetorno = -1;
                        }
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
