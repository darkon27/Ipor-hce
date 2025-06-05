using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;

namespace SoluccionSalud.Repository.DALSG_Opcion
{
    public class OpcionFormatoAsignacionRepository
    {
        public List<SS_HC_FormatoAsignacion> listarSS_HC_FormatoAsignacion(SS_HC_FormatoAsignacion objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_FormatoAsignacion_LISTAR(
                     objSC.IdFormatoAsignacion
                    , objSC.IdOpcion
                    , objSC.Nombre
                    , objSC.Descripcion
                    , objSC.Estado
                    , objSC.UsuarioCreacion
                    , objSC.FechaCreacion
                    , objSC.UsuarioModificacion
                    , objSC.FechaModificacion
                    , objSC.Version
                    , inicio
                    , final
                    , objSC.Accion

                    ).ToList();
            }
        }

        public List<SS_HC_FormatoCodigoId> listarSS_HC_FormatoCodigoId(SS_HC_FormatoCodigoId objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_FormatoCodigoId_LISTAR(
                         objSC.IdOpcion
                        , objSC.CampoCodigoId
                        , objSC.SecuenciaAsignacion
                        , objSC.IndicadorCodigoId
                        , objSC.ValorTexto
                        , objSC.ValorId
                        , objSC.Version
                        , inicio
                        , final
                        , objSC.Accion
                    ).ToList();
            }
        }

        public int setMantenimiento(SS_HC_FormatoAsignacion objSC  , List<SS_HC_FormatoCodigoId> listaDetalle)
        {
            System.Nullable<int> iReturnValue=0;            
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaDetalle!=null)
                        {
                            foreach (var result in listaDetalle)
                            {
                                iReturnValue = context.USP_SS_HC_FormatoCodigoId(
                                         result.IdOpcion
                                        , result.CampoCodigoId
                                        , result.SecuenciaAsignacion
                                        , result.IndicadorCodigoId
                                        , result.ValorTexto
                                        , result.ValorId
                                        , result.Version
                                        , result.UsuarioCreacion
                                        , result.FechaCreacion
                                        , result.UsuarioModificacion
                                        , result.FechaModificacion
                                        , result.Accion
                                     ).SingleOrDefault();
                            }
                            
                        }
                        valorRetorno = Convert.ToInt32(iReturnValue);
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
