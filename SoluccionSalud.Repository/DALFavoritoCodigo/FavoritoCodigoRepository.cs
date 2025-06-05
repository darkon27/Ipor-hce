using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALFavoritoCodigo
{
    public class FavoritoCodigoRepository : AuditGenerico<SS_HC_FavoritoCodigoId, SS_HC_FavoritoCodigoId> 
    {
        public List<SS_HC_FavoritoCodigoId> listarFavoritoCodigo(SS_HC_FavoritoCodigoId objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SS_HC_FavoritoCodigoId> objLista = new List<SS_HC_FavoritoCodigoId>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_FAVORITOCODIGOID_LISTAR(objSC.IdFavorito, objSC.CampoCodigoId,
                  objSC.IndicadorCodigoId,
                  objSC.ValorTexto, objSC.ValorId, objSC.ValorFecha, objSC.ValorDecimal,
                  objSC.Estado, objSC.Accion, objSC.Version,
                  inicio,
                  final).ToList();
            
                    DataKey = new
                    {
                        IdFavorito = objSC.IdFavorito,
                        CampoCodigoId = objSC.CampoCodigoId
                    };
                    // Audit
                    String xlmIn = XMLString(objLista, new List<SS_HC_FavoritoCodigoId>(), "SS_HC_FavoritoCodigoId");
                    objAudit = AddAudita(new SS_HC_FavoritoCodigoId(), objSC, DataKey, "L");
                    objAudit.TableName = "SS_HC_FavoritoCodigoId";
                    objAudit.Type = "L";
                    objAudit.Accion = "INSERT";
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();

            }
            
            return objLista;
        }

        public int setMantenimiento(SS_HC_FavoritoCodigoId objSC)
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
                        SS_HC_FavoritoCodigoId objAnterior = new SS_HC_FavoritoCodigoId();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_FavoritoCodigoId
                                           where t.IdFavorito == objSC.IdFavorito
                                           && t.CampoCodigoId == objSC.CampoCodigoId
                                           orderby t.IdFavorito descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SS_HC_FAVORITOCODIGOID(objSC.IdFavorito, objSC.CampoCodigoId,
                  objSC.IndicadorCodigoId,
                  objSC.ValorTexto, objSC.ValorId, objSC.ValorFecha, objSC.ValorDecimal,
                  objSC.Estado, objSC.Accion, objSC.Version).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdFavorito = objSC.IdFavorito,
                    CampoCodigoId = objSC.CampoCodigoId
                };
                if (objAnterior == null) objAnterior = new SS_HC_FavoritoCodigoId();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_HC_FavoritoCodigoId";
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
