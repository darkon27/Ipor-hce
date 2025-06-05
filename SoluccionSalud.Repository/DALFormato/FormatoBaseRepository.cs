using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALFormato
{
    public class FormatoBaseRepository : AuditGenerico<SS_HC_Formato, SS_HC_Formato> 
    {
          public List<SS_HC_Formato> listarFormato(SS_HC_Formato objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_Formato> objLista = new List<SS_HC_Formato>();

              using (var context = new WEB_ERPSALUDEntities()){
                  objLista = context.USP_SS_HC_FormatoListar(objSC.IdFormato, objSC.IdFormatoPadre, objSC.CodigoFormato,
                    objSC.CodigoFormatoPadre, objSC.CadenaRecursividad, objSC.Nivel, objSC.Descripcion, 
                    objSC.DescripcionExtranjera,objSC.TipoFormato, objSC.VersionFormatoFijo,
                    objSC.IdFormatoDinamico, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion,
                   objSC.Modulo,
                  objSC.Accion, objSC.Version, inicio, final
                   ).ToList();
                  DataKey = new
                  {
                      IdFormato = objSC.IdFormato,                      
                  };
                  // Audit
                  String xlmIn = XMLString(objLista, new List<SS_HC_Formato>(), "SS_HC_Formato");
                  objAudit = AddAudita(new SS_HC_Formato(), objSC, DataKey, "L");
                  objAudit.TableName = "SS_HC_Formato";
                  objAudit.Type = "L";
                  objAudit.Accion = "INSERT";
                  objAudit.VistaData = xlmIn;
                  context.Entry(objAudit).State = EntityState.Added;
                  context.SaveChanges();
              }
              return objLista;
        }

        public int setMantenimiento(SS_HC_Formato objSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try {
                        SS_HC_Formato objAnterior = new SS_HC_Formato();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_Formato
                                           where t.IdFormato == objSC.IdFormato
                                           orderby t.IdFormato descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_Formato(objSC.IdFormato, objSC.IdFormatoPadre, objSC.CodigoFormato,
                    objSC.CodigoFormatoPadre, objSC.CadenaRecursividad, objSC.Nivel, objSC.Descripcion,
                    objSC.DescripcionExtranjera, objSC.TipoFormato, objSC.VersionFormatoFijo,
                    objSC.IdFormatoDinamico, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.IndCompartido, objSC.FechaModificacion,
                    objSC.Accion, objSC.Version, objSC.Modulo).SingleOrDefault();
                        DataKey = new
                        {
                            IdFormato = objSC.IdFormato,
                        };
                        if (objAnterior == null) objAnterior = new SS_HC_Formato();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SS_HC_Formato";
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

