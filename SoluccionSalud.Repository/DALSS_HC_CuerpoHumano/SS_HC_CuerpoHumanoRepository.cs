using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALSS_HC_CuerpoHumano
{
    public class SS_HC_CuerpoHumanoRepository : AuditGenerico<SS_HC_CuerpoHumano, SS_HC_CuerpoHumano>
    {
        public List<SS_HC_CuerpoHumano> listarSSHCCuerpoHumano(SS_HC_CuerpoHumano objSC)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_CuerpoHumano> objLista = new List<SS_HC_CuerpoHumano>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                objLista = context.USP_SS_HC_CuerpoHumano_LISTAR(objSC.IdCuerpoHumano,
                    objSC.IdCuerpoHumanoPadre,objSC.Codigo,objSC.Descripcion
                    ,objSC.DescripcionIngles,objSC.UltimoNivelFlag,objSC.CadenaRecursiva
                    ,objSC.Estado,objSC.UsuarioCreacion,objSC.FechaCreacion
                    ,objSC.Nivel  //AUX
                    ,objSC.Orden //AOX
                    ,objSC.ACCION
                    ).ToList();

                DataKey = new
                {
                    IdCuerpoHumano = objSC.IdCuerpoHumano,
                };
                // Audit
                 /*foreach (SS_HC_CuerpoHumano objNew in objLista)
                 {                     
                     objNew.SS_HC_CuerpoHumano2 = null;
                     objNew.SS_HC_CuerpoHumano1 = null;
                 }
                SS_HC_CuerpoHumano nuevo = new SS_HC_CuerpoHumano();
                nuevo.SS_HC_CuerpoHumano2 = null;
                nuevo.SS_HC_CuerpoHumano1 = null;*/
                String xlmIn = XMLString(objLista, new List<SS_HC_CuerpoHumano>(), "SS_HC_CuerpoHumano");
                objAudit = AddAudita(new SS_HC_CuerpoHumano(), new SS_HC_CuerpoHumano(), DataKey, "L");
                objAudit.TableName = "SS_HC_CuerpoHumano";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }
            return objLista;
        }

        public int setMantenimiento(SS_HC_CuerpoHumano objSC)
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
                        SS_HC_CuerpoHumano objAnterior = new SS_HC_CuerpoHumano();
                        if ((objSC.ACCION.Substring(0, 1) != "I") || (objSC.ACCION.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_CuerpoHumano
                                           where t.IdCuerpoHumano == objSC.IdCuerpoHumano
                                           orderby t.IdCuerpoHumano descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_CuerpoHumano(objSC.IdCuerpoHumano,
                   objSC.IdCuerpoHumanoPadre, objSC.Codigo, objSC.Descripcion
                   , objSC.DescripcionIngles, objSC.Nivel, objSC.UltimoNivelFlag, objSC.CadenaRecursiva
                   , objSC.Orden, objSC.Icono, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                   objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.NombreTabla, objSC.CodigoPadre,
                    objSC.tipofolder, objSC.ACCION).SingleOrDefault();
                        DataKey = new
                        {
                            IdCuerpoHumano = objSC.IdCuerpoHumano,
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_CuerpoHumano();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.ACCION.Substring(0, 1));
                        objAudit.TableName = "SS_HC_CuerpoHumano";
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
