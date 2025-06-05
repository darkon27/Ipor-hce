using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.ModelPAE;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Repository.DALDiagnosticoPAE
{
    public class DiagnosticoPAERepository : AuditGenerico<SS_HC_PAE_Diagnostico, SS_HC_PAE_Diagnostico> 
    {
        public List<SS_HC_PAE_Diagnostico> listarDiagnosticoPAE(SS_HC_PAE_Diagnostico objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_PAE_Diagnostico> objLista = new List<SS_HC_PAE_Diagnostico>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_PAE_DiagnosticoListar(
                    objSC.UnidadReplicacion,
                    objSC.IdEpisodioAtencion,
                    objSC.IdPaciente,
                    objSC.EpisodioClinico,
                    objSC.IdOrdenAtencion,
                    objSC.SecuenciaPAE,
                    objSC.IdNanda,
                    objSC.IdDominioPAE,
                    objSC.IdClasePAE,
                    objSC.Observacion,
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

        public int setMantenimientoDiagPAE(SS_HC_PAE_Diagnostico objSC)
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
                        SS_HC_PAE_Diagnostico objAnterior = new SS_HC_PAE_Diagnostico();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_PAE_Diagnostico
                                           where t.IdNanda == objSC.IdNanda
                                           orderby t.IdNanda descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.SP_SS_HC_PAE_Diagnostico(
                             objSC.UnidadReplicacion,
                             objSC.IdEpisodioAtencion,
                             objSC.IdPaciente,
                             objSC.EpisodioClinico,
                             objSC.IdOrdenAtencion,
                             objSC.SecuenciaPAE,
                             objSC.IdNanda,
                             objSC.IdDominioPAE,
                             objSC.IdClasePAE,
                             objSC.Observacion,
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


        public int setMantenimientoDiagPAE(SS_HC_PAE_Diagnostico ObjTraces, List<SS_HC_PAE_Diagnostico> listaCabecera,
                   List<SS_HC_PAE_Diagnostico> listaDetalle)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;


            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (var obj in listaDetalle)
                        {

                            var InformacionObj = (from t in context.SS_HC_PAE_Diagnostico
                                                  where t.IdNanda == obj.IdNanda
                                                  orderby t.IdNanda descending
                                                  select t).SingleOrDefault();
                            if (InformacionObj == null) InformacionObj = new SS_HC_PAE_Diagnostico();

                            iReturnValue = context.SP_SS_HC_PAE_Diagnostico(
                             obj.UnidadReplicacion,
                             obj.IdEpisodioAtencion,
                             obj.IdPaciente,
                             obj.EpisodioClinico,
                             obj.IdOrdenAtencion,
                             obj.SecuenciaPAE,
                             obj.IdNanda,
                             obj.IdDominioPAE,
                             obj.IdClasePAE,
                             obj.Observacion,
                             obj.Estado,
                             obj.UsuarioCreacion,
                             obj.FechaCreacion,
                             obj.UsuarioModificacion,
                             obj.FechaModificacion,
                             obj.Accion,
                             obj.Version
                          ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());


                        }
                        context.SaveChanges();
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
