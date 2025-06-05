using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALFavoritoDetalle
{
    public class FavoritoDetalleRepository : AuditGenerico<SS_HC_FavoritoDetalle, SS_HC_FavoritoDetalle> 
    {

        public List<SS_HC_FavoritoDetalle> listarFavoritoDetalle(SS_HC_FavoritoDetalle objSC,
            int inicio, int final, int idAgente, int TipoFavorito)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_FAVORITODETALLEDETALLE_LISTAR(objSC.IdFavorito,
                objSC.NumeroFavorito,
                objSC.Secuencia,
                objSC.ValorId,
                objSC.ValorTexto1,
                objSC.ValorTexto2,
                objSC.ValorTexto3,
                objSC.ValorTexto4,
                objSC.ValorTexto5,
                objSC.UsuarioCreacion,
                objSC.FechaCreacion,
                objSC.Accion,
                objSC.Version,
                idAgente,
                TipoFavorito,
                  inicio,
                  final).ToList();
            }
        }

        public int setMantenimiento(SS_HC_FavoritoDetalle objSC, int IdFavorito, int TipoFavorito)
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
                        SS_HC_FavoritoDetalle objAnterior = new SS_HC_FavoritoDetalle();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            if (objSC.Accion == "CONTARLISTAPAG")
                            {
                                objAnterior = (from t in context.SS_HC_FavoritoDetalle
                                               where t.IdFavorito == objSC.IdFavorito
                                               && t.NumeroFavorito == objSC.NumeroFavorito
                                               && t.Secuencia == objSC.Secuencia
                                               orderby t.IdFavorito descending
                                               select t).SingleOrDefault();
                            }
                            else
                            {
                                objAnterior = (from t in context.SS_HC_FavoritoDetalle
                                               where t.IdFavorito == objSC.IdFavorito
                                               && t.NumeroFavorito == objSC.NumeroFavorito
                                              && t.Secuencia == objSC.Secuencia
                                               orderby t.IdFavorito descending
                                               select t).SingleOrDefault();
                            }
                        }


                iReturnValue = context.USP_SS_HC_FAVORITODETALLEDETALLE(objSC.IdFavorito,
				objSC.NumeroFavorito,
				objSC.Secuencia,
				objSC.ValorId,
				objSC.ValorTexto1,
				objSC.ValorTexto2,
				objSC.ValorTexto3,
				objSC.ValorTexto4,
				objSC.ValorTexto5,
				objSC.UsuarioCreacion,
				objSC.FechaCreacion,
				objSC.Accion,
				objSC.Version,
                IdFavorito,
                TipoFavorito
                ).SingleOrDefault();

                //*  Registra Audit/
                DataKey = new
                {
                    IdFavorito = objSC.IdFavorito,
                    NumeroFavorito = objSC.NumeroFavorito,
                    Secuencia = objSC.Secuencia
                };
                if (objAnterior == null) objAnterior = new SS_HC_FavoritoDetalle();
                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                objAudit.TableName = "SS_HC_FavoritoDetalle";
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
