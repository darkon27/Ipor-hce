using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALPacDoc
{
    public class PacDocRepository : AuditGenerico<SS_HC_PacienteDocumentos, SS_HC_PacienteDocumentos> 
    {
        public List<SS_HC_PacienteDocumentos> listarPacDoc(SS_HC_PacienteDocumentos objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_PacienteDocumentos> objLista = new List<SS_HC_PacienteDocumentos>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_PacienteDocumentosListar(objSC.UnidadReplicacion, objSC.IdPaciente, objSC.Secuencial,
                    objSC.TipoDocumento, objSC.NumeroDocumento, objSC.FechaVigencia, objSC.Estado,objSC.UsuarioCreacion, 
                    objSC.FechaCreacion,objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, inicio, final
                 ).ToList();
                DataKey = new
                {
                    IdPaciente = objSC.IdPaciente,
                    Secuencial = objSC.Secuencial,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_PacienteDocumentos>(), "SS_HC_PacienteDocumentos");
                objAudit = AddAudita(new SS_HC_PacienteDocumentos(), new SS_HC_PacienteDocumentos(), DataKey, "L");
                objAudit.TableName = "SS_HC_NIC";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_PacienteDocumentos objSC)
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
                        SS_HC_PacienteDocumentos objAnterior = new SS_HC_PacienteDocumentos();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_PacienteDocumentos
                                           where t.IdPaciente == objSC.IdPaciente
                                           && t.Secuencial == objSC.Secuencial
                                           orderby t.IdPaciente descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_PacienteDocumentos(objSC.UnidadReplicacion, objSC.IdPaciente, 
                            objSC.Secuencial,objSC.TipoDocumento, objSC.NumeroDocumento, objSC.FechaVigencia, objSC.Estado, 
                            objSC.UsuarioCreacion,objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, 
                            objSC.Accion).SingleOrDefault();

                        DataKey = new
                        {
                            IdPaciente = objSC.IdPaciente,
                            Secuencial = objSC.Secuencial,
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_PacienteDocumentos();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_PacienteDocumentos";
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
