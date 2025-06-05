using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALModulo
{
    public class ModuloRepository : AuditGenerico<SG_Modulo, SG_Modulo> 
    {
        public List<SG_Modulo> listarModulos(SG_Modulo objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SG_Modulo> objLista = new List<SG_Modulo>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SG_Modulo_Lista(objSC.Sistema,
				objSC.Modulo,
				objSC.Orden,
				objSC.Nombre,
				objSC.Descripcion,
				objSC.Plataforma,
				objSC.UrlModulo,
				objSC.Estado,
				objSC.UsuarioCreacion,
				objSC.FechaCreacion,
				objSC.UsuarioModificacion,
				objSC.FechaModificacion, objSC.Accion
                    , inicio, final).ToList();

                DataKey = new
                {
                    Sistema = objSC.Sistema,
                    Modulo = objSC.Modulo
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SG_Modulo>(), "SG_Modulo");
                objAudit = AddAudita(new SG_Modulo(), new SG_Modulo(), DataKey, "L");
                objAudit.TableName = "SG_Modulo";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();

            }

            return objLista;
        }
        public int setMantenimiento(SG_Modulo objSC)
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
                        SG_Modulo objAnterior = new SG_Modulo();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SG_Modulo
                                           where t.Sistema == objSC.Sistema
                                           && t.Modulo == objSC.Modulo
                                           orderby t.Modulo descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SG_Modulo(objSC.Sistema,
                objSC.Modulo,
                objSC.Orden,
                objSC.Nombre,
                objSC.Descripcion,
                objSC.Plataforma,
                objSC.UrlModulo,
                objSC.Estado,
                objSC.UsuarioCreacion,
                objSC.FechaCreacion,
                objSC.UsuarioModificacion,
                objSC.FechaModificacion, objSC.Accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                //*  Registra Audit/
                DataKey = new
                {
                    Sistema = objSC.Sistema,
                    Modulo = objSC.Modulo
                };
                if (objAnterior == null) objAnterior = new SG_Modulo();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SG_Modulo";
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
