using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryReport;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALRegistrarAcompanante
{
    public class RegistroAcompananteRepository : AuditGenerico<SS_HC_RegistroAcompanante, SS_HC_RegistroAcompanante> 
    {

        public List<SS_HC_RegistroAcompanante> listarRegistroAcompanante(SS_HC_RegistroAcompanante objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            //SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_RegistroAcompanante> objLista = new List<SS_HC_RegistroAcompanante>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_RegistroAcompanante_LISTAR(
                    objSC.IdAcompanante,
                    objSC.UnidadReplicacion,
                    objSC.IdPaciente,
                    objSC.EpisodioClinico,
                    objSC.IdEpisodioAtencion,
                    objSC.CodigoOA,
                    objSC.Tipo,
                    objSC.numero,
                    objSC.TipoParentesco,
                    objSC.ApePat,
                    objSC.ApeMat,
                    objSC.Nombres,
                    objSC.Telefono,
                    objSC.Observaciones,
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

        public int setMantenimientoRegistroAcompanante(SS_HC_RegistroAcompanante objSC)
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
                        SS_HC_RegistroAcompanante objAnterior = new SS_HC_RegistroAcompanante();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_RegistroAcompanante
                                           where t.IdAcompanante == objSC.IdAcompanante
                                           orderby t.IdAcompanante descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.SP_SS_HC_RegistroAcompanante(
                            objSC.IdAcompanante,
                            objSC.UnidadReplicacion,
                            objSC.IdPaciente,
                            objSC.EpisodioClinico,
                            objSC.IdEpisodioAtencion,
                            objSC.CodigoOA,
                            objSC.Tipo,
                            objSC.numero,
                            objSC.TipoParentesco,
                            objSC.ApePat,
                            objSC.ApeMat,
                            objSC.Nombres,
                            objSC.Telefono,
                            objSC.Observaciones,
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
