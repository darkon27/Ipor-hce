using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALServicios
{
    public class ServiciosRepository : AuditGenerico<SS_GE_Servicio, SS_GE_Servicio> 
    {
        public List<SS_GE_Servicio> listarServicio(SS_GE_Servicio objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_GE_Servicio> objLista = new List<SS_GE_Servicio>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_GE_ServicioListar(objSC.IdServicio, objSC.IdGrupoAtencion, objSC.Codigo,
                  objSC.Descripcion, objSC.IndicadorTriaje, objSC.TipoOrdenAtencion, objSC.Estado,  objSC.UsuarioCreacion,
                  objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.CentroCosto,
                  objSC.CuentaBancaria, objSC.Accion, inicio, final
                 ).ToList();
                DataKey = new
                {
                    IdServicio = objSC.IdServicio,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_GE_Servicio>(), "SS_GE_Servicio");
                objAudit = AddAudita(new SS_GE_Servicio(), new SS_GE_Servicio(), DataKey, "L");
                objAudit.TableName = "SS_GE_Servicio";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_GE_Servicio objSC)
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
                        SS_GE_Servicio objAnterior = new SS_GE_Servicio();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_GE_Servicio
                                           where t.IdServicio == objSC.IdServicio
                                           orderby t.IdServicio descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_GE_Servicio(objSC.IdServicio, objSC.IdGrupoAtencion, objSC.Codigo,
                  objSC.Descripcion, objSC.IndicadorTriaje, objSC.TipoOrdenAtencion, objSC.Estado, objSC.UsuarioCreacion,
                  objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.CentroCosto,
                  objSC.CuentaBancaria, objSC.Accion
                 ).SingleOrDefault();

                        DataKey = new
                        {
                            IdServicio = objSC.IdServicio,
                        };
                        if (objAnterior == null) objAnterior = new SS_GE_Servicio();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_GE_Servicio";
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
