using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using Newtonsoft.Json;


namespace SoluccionSalud.Repository.DALDiagnostico
{
    public class DiagnosticoRepository : AuditGenerico<SS_GE_Diagnostico, SS_GE_Diagnostico> 
    {


        public List<SS_GE_Diagnostico> listarDiagnostico(SS_GE_Diagnostico objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_GE_Diagnostico> objLista = new List<SS_GE_Diagnostico>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_GE_DiagnosticoListar(objSC.IdDiagnostico, objSC.CodigoDiagnostico,
                    objSC.CodigoPadre, objSC.Nombre, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.IdDiagnosticoPadre, objSC.Orden, objSC.CadenaRecursividad, objSC.Nivel,
                    objSC.DiagnosticoSiteds, objSC.IndicadorPermitido, objSC.tipoFolder,
                    objSC.NombreTabla, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();

                DataKey = new
                {
                    IdDiagnostico = objSC.IdDiagnostico
                };
                // Audit
                //String xlmIn = XMLString(objLista, new List<SS_GE_Diagnostico>(), "SS_GE_Diagnostico");
                String xlmIn = JsonConvert.SerializeObject(objLista);  // 2018/01/09 ---Jordan Mateo
                objAudit = AddAudita(new SS_GE_Diagnostico(), objSC, DataKey, "L");
                objAudit.TableName = "SS_GE_Diagnostico";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }
        public int setMantenimiento(SS_GE_Diagnostico objSC)
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
                        SS_GE_Diagnostico objAnterior = new SS_GE_Diagnostico();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_GE_Diagnostico
                                           where t.IdDiagnostico == objSC.IdDiagnostico
                                           orderby t.IdDiagnostico descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_GE_Diagnostico(
                    objSC.IdDiagnostico, objSC.CodigoDiagnostico, objSC.CodigoPadre,
                    objSC.Nombre, objSC.Descripcion, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.IdDiagnosticoPadre, objSC.Orden, objSC.CadenaRecursividad,
                    objSC.Nivel, objSC.DiagnosticoSiteds, objSC.IndicadorPermitido,
                    objSC.tipoFolder, objSC.Nombre, objSC.Accion, objSC.Version).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdDiagnostico = objSC.IdDiagnostico
                };
                if (objAnterior == null) objAnterior = new SS_GE_Diagnostico();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_GE_Diagnostico";
                objAudit.Type = objSC.Accion.Substring(0, 1);
                if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                {
                    if (objAudit.Type != "L")
                    {
                        context.Entry(objAudit).State = EntityState.Added;
                        context.SaveChanges();
                    }
                }

                //*/
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
