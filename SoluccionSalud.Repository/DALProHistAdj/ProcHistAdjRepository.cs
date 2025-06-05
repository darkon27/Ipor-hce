using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALProHistAdj
{
    public class ProcHistAdjRepository : AuditGenerico<VW_SS_IT_ProcesoHistoriaAdjunta, VW_SS_IT_ProcesoHistoriaAdjunta> 
    {
        public List<VW_SS_IT_ProcesoHistoriaAdjunta> listarProcHistAdj(VW_SS_IT_ProcesoHistoriaAdjunta objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<VW_SS_IT_ProcesoHistoriaAdjunta> objLista = new List<VW_SS_IT_ProcesoHistoriaAdjunta>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_VW_SS_IT_ProcesoHistoriaAdjuntaListar(
                    objSC.idsecuencia, objSC.CodigoSucursal, objSC.UnidadReplicacion, objSC.IdAplicativo, objSC.CodigoReferencia,
                    objSC.CodigoHHCC, objSC.DNI, objSC.IdPaciente, objSC.TipoAtencion, objSC.Fecha,objSC.Especialidad, 
                    objSC.IdEspecialidad, objSC.Servicio, objSC.IdServicio,objSC.CodigoMedico, objSC.IdMedico, objSC.CodigoAdmision, 
                    objSC.CodigoOA,objSC.CodigoDiagnostico, objSC.IdDiagnostico, objSC.NumeroPagina, objSC.RutaImagen,
                    objSC.FechaRecepcion, objSC.IndicadorProcesado, objSC.IndicadorError, objSC.DescripcionError,objSC.Accion,
                    objSC.Rownumber, inicio, final).ToList();
                DataKey = new
                {
                    idsecuencia = objSC.idsecuencia
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<VW_SS_IT_ProcesoHistoriaAdjunta>(), "VW_SS_IT_ProcesoHistoriaAdjunta");
                objAudit = AddAudita(new VW_SS_IT_ProcesoHistoriaAdjunta(), new VW_SS_IT_ProcesoHistoriaAdjunta(), DataKey, "L");
                objAudit.TableName = "VW_SS_IT_ProcesoHistoriaAdjunta";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(VW_SS_IT_ProcesoHistoriaAdjunta objSC)
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
                        VW_SS_IT_ProcesoHistoriaAdjunta objAnterior = new VW_SS_IT_ProcesoHistoriaAdjunta();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.VW_SS_IT_ProcesoHistoriaAdjunta
                                           where t.Rownumber == objSC.Rownumber
                                           orderby t.Rownumber descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_VW_SS_IT_ProcesoHistoriaAdjunta(objSC.idsecuencia, objSC.CodigoSucursal, objSC.UnidadReplicacion, 
                            objSC.IdAplicativo, objSC.CodigoReferencia,objSC.CodigoHHCC, objSC.DNI, objSC.IdPaciente, 
                            objSC.TipoAtencion, objSC.Fecha, objSC.Especialidad,objSC.IdEspecialidad, objSC.Servicio, 
                            objSC.IdServicio, objSC.CodigoMedico, objSC.IdMedico, objSC.CodigoAdmision,objSC.CodigoOA, 
                            objSC.CodigoDiagnostico, objSC.IdDiagnostico, objSC.NumeroPagina, objSC.RutaImagen, objSC.FechaRecepcion, 
                            objSC.IndicadorProcesado, objSC.IndicadorError, objSC.DescripcionError, objSC.Accion,objSC.Rownumber)
                            .SingleOrDefault();                        
                        DataKey = new
                        {
                            idsecuencia = objSC.idsecuencia
                        };
                        if (objAnterior == null) objAnterior = new VW_SS_IT_ProcesoHistoriaAdjunta();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "VW_SS_IT_ProcesoHistoriaAdjunta";
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
