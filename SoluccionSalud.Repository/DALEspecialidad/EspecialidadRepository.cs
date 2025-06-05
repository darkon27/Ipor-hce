using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALEspecialidad
{
    public class EspecialidadRepository : AuditGenerico<SS_GE_Especialidad, SS_GE_Especialidad> 
    {
        public List<SS_GE_Especialidad> listarEspecialidad(SS_GE_Especialidad objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_GE_Especialidad> objLista = new List<SS_GE_Especialidad>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                context.Database.Connection.Open();
                objLista= context.USP_SS_GE_Especialidad_listar(objSC.IdEspecialidad, objSC.Codigo,
                    objSC.Nombre, objSC.Descripcion, objSC.TiempoPromedioAtencion, objSC.FormularioInicial,
                    objSC.FormularioFinal, objSC.FormularioInforme, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.CantidadCitasAdicional, objSC.AtencionPeriodoCronico, objSC.IndicadorValidarFlujo,
                    objSC.ReporteCita, objSC.foto, objSC.descripcion_det, objSC.IndicadorWeb, objSC.Accion 
                    , inicio
                    , final).ToList();

                context.Database.Connection.Close();
                context.Dispose();
                //DataKey = new
                //{
                //    IdEspecialidad = objSC.IdEspecialidad
                //};
                // Audit
                //String xlmIn = XMLString(objLista, new List<SS_GE_Especialidad>(), "SS_GE_Especialidad");
                //objAudit = AddAudita(new SS_GE_Especialidad(), objSC, DataKey, "L");
                //objAudit.TableName = "SS_GE_Especialidad";
                //objAudit.Type = "L";
                //objAudit.Accion = "LISTAR";
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();

            }

            return objLista;
        }
        public int setMantenimiento(SS_GE_Especialidad objSC)
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
                        SS_GE_Especialidad objAnterior = new SS_GE_Especialidad();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_GE_Especialidad
                                           where t.IdEspecialidad == objSC.IdEspecialidad
                                           orderby t.IdEspecialidad descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SS_GE_Especialidad_mantenimiento(objSC.IdEspecialidad, objSC.Codigo,
                    objSC.Nombre, objSC.Descripcion, objSC.TiempoPromedioAtencion, objSC.FormularioInicial,
                    objSC.FormularioFinal, objSC.FormularioInforme, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.CantidadCitasAdicional, objSC.AtencionPeriodoCronico, objSC.IndicadorValidarFlujo,
                    objSC.ReporteCita, objSC.foto, objSC.descripcion_det, objSC.IndicadorWeb, objSC.Accion).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdEspecialidad = objSC.IdEspecialidad
                };
                if (objAnterior == null) objAnterior = new SS_GE_Especialidad();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_GE_Especialidad";
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
        public int setMantenimiento(List<SS_GE_Especialidad> listaObjSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue=0;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaObjSC!=null)
                        {
                            foreach(var objSC in  listaObjSC){
                                iReturnValue = context.USP_SS_GE_Especialidad_mantenimiento(objSC.IdEspecialidad, objSC.Codigo,
                            objSC.Nombre, objSC.Descripcion, objSC.TiempoPromedioAtencion, objSC.FormularioInicial,
                            objSC.FormularioFinal, objSC.FormularioInforme, objSC.Estado,
                            objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                            objSC.CantidadCitasAdicional, objSC.AtencionPeriodoCronico, objSC.IndicadorValidarFlujo,
                            objSC.ReporteCita, objSC.foto, objSC.descripcion_det, objSC.IndicadorWeb, objSC.Accion).SingleOrDefault();
                            }
                            
                        }

                        valorRetorno = Convert.ToInt32(iReturnValue);
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
