using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALUnidadServicio
{
    public class UnidadServicioRepository : AuditGenerico<SS_HC_UnidadServicio, SS_HC_UnidadServicio>
    {
        public List<SS_HC_UnidadServicio> listarUnidadServicio(SS_HC_UnidadServicio objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_UnidadServicio> objLista = new List<SS_HC_UnidadServicio>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_UnidadServicioListar(objSC.IdEstablecimientoSalud, objSC.IdUnidadServicio,
                    objSC.IdServicio, objSC.Codigo, objSC.Descripcion, objSC.IndicadorTriaje, objSC.Estado,
                  objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, 
                  objSC.Accion, inicio, final
                 ).ToList();
                DataKey = new
                {
                    IdEstablecimientoSalud = objSC.IdEstablecimientoSalud,
                    IdUnidadServicio = objSC.IdUnidadServicio,
                    Descripcion = objSC.Descripcion
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_UnidadServicio>(), "SS_HC_UnidadServicio");
                objAudit = AddAudita(new SS_HC_UnidadServicio(), new SS_HC_UnidadServicio(), DataKey, "L");
                objAudit.TableName = "SS_HC_UnidadServicio";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_UnidadServicio objSC)
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
                        SS_HC_UnidadServicio objAnterior = new SS_HC_UnidadServicio();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_UnidadServicio
                                           where t.IdEstablecimientoSalud == objSC.IdEstablecimientoSalud
                                           && t.IdUnidadServicio == objSC.IdUnidadServicio
                                           orderby t.IdUnidadServicio descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_UnidadServicio(objSC.IdEstablecimientoSalud, objSC.IdUnidadServicio,
                            objSC.IdServicio, objSC.Codigo, objSC.Descripcion, objSC.IndicadorTriaje, objSC.Estado,
                            objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                            objSC.Accion
                            ).SingleOrDefault();

                        DataKey = new
                        {
                            IdEstablecimientoSalud = objSC.IdEstablecimientoSalud,
                            IdUnidadServicio = objSC.IdUnidadServicio,
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_UnidadServicio();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_UnidadServicio";
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
