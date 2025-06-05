using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALFavorito
{
    public class FavoritoRepository : AuditGenerico<SS_HC_Favorito, SS_HC_Favorito> 
    {
        public List<SS_HC_Favorito> listarFavorito(SS_HC_Favorito objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_FAVORITO_LISTAR(objSC.IdFavorito, objSC.Descripcion,
                  objSC.DescripcionExtranjera,
                  objSC.TipoFavorito, objSC.IdFavoritoTabla, objSC.IdAgente, objSC.Estado,
                  objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                  objSC.FechaModificacion, objSC.Accion, objSC.Version,
                  inicio,
                  final).ToList();
            }
        }

        public int setMantenimiento(SS_HC_Favorito objSC)
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
                        SS_HC_Favorito objAnterior = new SS_HC_Favorito();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SS_HC_Favorito
                                           where t.IdFavorito == objSC.IdFavorito
                                           orderby t.IdFavorito descending
                                           select t).SingleOrDefault();
                        }
                iReturnValue = context.USP_SS_HC_FAVORITO(objSC.IdFavorito, objSC.Descripcion,
                  objSC.DescripcionExtranjera,
                  objSC.TipoFavorito, objSC.IdFavoritoTabla, objSC.IdAgente, objSC.Estado,
                  objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                  objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdFavorito = objSC.IdFavorito
                };
                if (objAnterior == null) objAnterior = new SS_HC_Favorito();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_HC_Favorito";
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
