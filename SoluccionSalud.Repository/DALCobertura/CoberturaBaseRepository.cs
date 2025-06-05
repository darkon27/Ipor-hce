using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALCobertura
{
    public class CoberturaBaseRepository : AuditGenerico<SS_SG_MaestroCobertura, SS_SG_MaestroCobertura> 
    {
        
        public List<SS_SG_MaestroCobertura> listarCobertura(SS_SG_MaestroCobertura objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_SG_MaestroCobertura> objLista = new List<SS_SG_MaestroCobertura>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_SG_MaestroCoberturaListar(objSC.IdCobertura, objSC.CodigoCobertura, objSC.Nombre,
                    objSC.Descripcion, objSC.IndicadorAmbulatorio, objSC.IndicadorEmergencia, objSC.IndicadorHospitalario,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.Coderam, objSC.TipoTabla, objSC.ACCION, objSC.VERSION, inicio, final
                   ).ToList();
                DataKey = new
                {
                    IdCobertura = objSC.IdCobertura,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_SG_MaestroCobertura>(), "SS_SG_MaestroCobertura");
                objAudit = AddAudita(new SS_SG_MaestroCobertura(), new SS_SG_MaestroCobertura(), DataKey, "L");
                objAudit.TableName = "SS_SG_MaestroCobertura";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        public int setMantenimiento(SS_SG_MaestroCobertura objSC)
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
                        SS_SG_MaestroCobertura objAnterior = new SS_SG_MaestroCobertura();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_SG_MaestroCobertura
                                           where t.IdCobertura == objSC.IdCobertura
                                           orderby t.IdCobertura descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_SG_MaestroCobertura(
                  objSC.IdCobertura, objSC.CodigoCobertura, objSC.Nombre,
                   objSC.Descripcion, objSC.IndicadorAmbulatorio, objSC.IndicadorEmergencia, objSC.IndicadorHospitalario,
                   objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                   objSC.FechaModificacion, objSC.Coderam, objSC.TipoTabla, objSC.ACCION, objSC.VERSION
                   ).SingleOrDefault();
                        DataKey = new
                        {
                            IdCobertura = objSC.IdCobertura,
                        };
                        if (objAnterior == null) objAnterior = new SS_SG_MaestroCobertura();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                        objAudit.TableName = "SS_SG_MaestroCobertura";
                        objAudit.Type = objSC.ACCION.Substring(0, 1);
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
