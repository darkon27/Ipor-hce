using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALParametrosMast
{
    public class ParametroRepository : AuditGenerico<ParametrosMast, ParametrosMast> 
    {
        public List<ParametrosMast> listarParametro(ParametrosMast objSC, int inicio, int final)
        {
            //dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<ParametrosMast> objLista = new List<ParametrosMast>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                context.Database.Connection.Open();
                objLista = context.USP_ParametrosMastListar(objSC.CompaniaCodigo, objSC.AplicacionCodigo, objSC.ParametroClave,
                  objSC.DescripcionParametro, objSC.Explicacion, objSC.TipodeDatoFlag, objSC.Texto,
                  objSC.Numero, objSC.Fecha, objSC.FinanceComunFlag, objSC.Estado,
                  objSC.UltimoUsuario, objSC.UltimaFechaModif, objSC.ExplicacionAdicional,objSC.Texto1,objSC.Texto2,
                  objSC.UnidadReplicacion, objSC.Accion, inicio, final, objSC.UsuarioCreacion, objSC.FechaCreacion
                 ).ToList();
                context.Database.Connection.Close();
                context.Dispose();
                //DataKey = new
                //{
                //    CompaniaCodigo = objSC.CompaniaCodigo,
                //    AplicacionCodigo = objSC.AplicacionCodigo,
                //    ParametroClave = objSC.ParametroClave,
                //};
                // Audit
                //String xlmIn = XMLString(objLista, new List<ParametrosMast>(), "ParametrosMast");
                //objAudit = AddAudita(new ParametrosMast(), new ParametrosMast(), DataKey, "L");
                //objAudit.TableName = "ParametrosMast";
                //objAudit.Type = "L";
                //objAudit.Accion = "LISTAR";
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();
            }
            return objLista;
        }


        public List<ParametrosMast> listarParametroWServicio(ParametrosMast objSC, int inicio, int final)
        {
          //  dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<ParametrosMast> objLista = new List<ParametrosMast>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_ParametrosMastListar(objSC.CompaniaCodigo, objSC.AplicacionCodigo, objSC.ParametroClave,
                  objSC.DescripcionParametro, objSC.Explicacion, objSC.TipodeDatoFlag, objSC.Texto,
                  objSC.Numero, objSC.Fecha, objSC.FinanceComunFlag, objSC.Estado,
                  objSC.UltimoUsuario, objSC.UltimaFechaModif, objSC.ExplicacionAdicional,objSC.Texto1,objSC.Texto2,
                  objSC.UnidadReplicacion, objSC.Accion, inicio, final, objSC.UsuarioCreacion, objSC.FechaCreacion
                 ).ToList();

                //DataKey = new
                //{
                //    CompaniaCodigo = objSC.CompaniaCodigo,
                //    AplicacionCodigo = objSC.AplicacionCodigo,
                //    ParametroClave = objSC.ParametroClave,
                //};
                //// Audit
                //String xlmIn = XMLString(objLista, new List<ParametrosMast>(), "ParametrosMast");
                //objAudit = AddAudita(new ParametrosMast(), new ParametrosMast(), DataKey, "L");
                //objAudit.TableName = "ParametrosMast";
                //objAudit.Type = "L";
                //objAudit.Accion = "INSERT";
                //objAudit.VistaData = xlmIn;
                //context.Entry(objAudit).State = EntityState.Added;
                //context.SaveChanges();
            }
            return objLista;
        }

        

        public int setMantenimiento(ParametrosMast objSC)
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
                        ParametrosMast objAnterior = new ParametrosMast();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.ParametrosMasts
                                           where t.CompaniaCodigo == objSC.CompaniaCodigo
                                           && t.AplicacionCodigo == objSC.AplicacionCodigo
                                           && t.ParametroClave == objSC.ParametroClave
                                           orderby t.CompaniaCodigo descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_ParametrosMast(objSC.CompaniaCodigo, objSC.AplicacionCodigo, objSC.ParametroClave,
                  objSC.DescripcionParametro, objSC.Explicacion, objSC.TipodeDatoFlag, objSC.Texto,
                  objSC.Numero, objSC.Fecha, objSC.FinanceComunFlag, objSC.Estado,
                  objSC.UltimoUsuario, objSC.UltimaFechaModif, objSC.ExplicacionAdicional, objSC.Texto1, objSC.Texto2
                  , objSC.UnidadReplicacion, objSC.Accion, objSC.UsuarioCreacion, objSC.FechaCreacion
                  ).SingleOrDefault();
                        DataKey = new
                        {
                            CompaniaCodigo = objSC.CompaniaCodigo,
                            AplicacionCodigo = objSC.AplicacionCodigo,
                            ParametroClave = objSC.ParametroClave,
                        };
                        if (objAnterior == null) objAnterior = new ParametrosMast();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "ParametrosMast";
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

        public ParametrosMast getMantenimientoPoId(ParametrosMast ObjTrace)
        {                
            ParametrosMast objResult = null;
            try
            {
                using (var context = new WEB_ERPSALUDEntities())
                {
                    ParametrosMast objConsulta = (from t in context.ParametrosMasts
                                                  where
                                                  t.CompaniaCodigo == ObjTrace.CompaniaCodigo
                                                  && t.AplicacionCodigo == ObjTrace.AplicacionCodigo
                                                  && t.ParametroClave == ObjTrace.ParametroClave
                                                  select t).SingleOrDefault();

                    if (objConsulta != null)
                    {
                        objResult = objConsulta;
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return objResult;
        }


    }
}
