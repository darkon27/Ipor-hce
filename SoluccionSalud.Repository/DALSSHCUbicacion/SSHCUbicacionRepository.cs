using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALSSHCUbicacion
{
    public class SSHCUbicacionRepository : AuditGenerico<SS_HC_Ubicacion, SS_HC_Ubicacion> 
    {
        public List<SS_HC_Ubicacion> listarSSHCUbicacion(SS_HC_Ubicacion objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_Ubicacion> objLista = new List<SS_HC_Ubicacion>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_UbicacionListar(
                    objSC.UnidadReplicacion, objSC.IdUbicacion,objSC.IdUbicacionPadre, objSC.Codigo, objSC.Nombre,
                    objSC.Descripcion, objSC.TipoUbicacion, objSC.Ruta, objSC.OrdenRuta, objSC.Orden,
                    objSC.Nivel, objSC.CadenaRecursividad,objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.RutaDescripcion, objSC.Accion, inicio,
                    final).ToList();
                DataKey = new
                {
                    UnidadReplicacion = objSC.UnidadReplicacion,
                    IdUbicacion = objSC.IdUbicacion
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SS_HC_Ubicacion>(), "SS_HC_Ubicacion");
                objAudit = AddAudita(new SS_HC_Ubicacion(), new SS_HC_Ubicacion(), DataKey, "L");
                objAudit.TableName = "SS_HC_Ubicacion";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_Ubicacion objSC)
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
                        SS_HC_Ubicacion objAnterior = new SS_HC_Ubicacion();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_Ubicacion
                                           where t.UnidadReplicacion == objSC.UnidadReplicacion
                                           && t.IdUbicacion == objSC.IdUbicacion
                                           orderby t.Codigo descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_Ubicacion(
                            objSC.UnidadReplicacion, objSC.IdUbicacion, objSC.IdUbicacionPadre, objSC.Codigo, objSC.Nombre,
                            objSC.Descripcion, objSC.TipoUbicacion, objSC.Ruta, objSC.OrdenRuta, objSC.Orden,
                            objSC.Nivel, objSC.CadenaRecursividad, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                            objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.RutaDescripcion, objSC.Accion).SingleOrDefault();
                        DataKey = new
                        {
                            UnidadReplicacion = objSC.UnidadReplicacion,
                            IdUbicacion = objSC.IdUbicacion
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_Ubicacion();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_Ubicacion";
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
