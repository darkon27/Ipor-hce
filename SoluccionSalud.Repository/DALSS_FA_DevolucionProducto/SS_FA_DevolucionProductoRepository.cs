using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.ModelPAE;

namespace SoluccionSalud.Repository.DALSS_FA_DevolucionProducto
{
    public class SS_FA_DevolucionProductoRepository
    {
        public int setMantenimiento(SS_FA_DevolucionProducto objSC, List<SS_FA_DevolucionProductoDetalle> objSC2)
        {

            /////
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (objSC != null)
                        {

                            iReturnValue = context.SP_SS_FA_DevolucionProducto(
                                objSC.UnidadReplicacion
                                , objSC.IdEpisodioAtencion
                                , objSC.IdPaciente
                                , objSC.EpisodioClinico
                                , objSC.IdDevolucionProducto
                                , objSC.NumeroDocumento
                                , objSC.Observacion
                                , objSC.EstadoDocumento
                                , objSC.Estado
                                , objSC.UsuarioCreacion
                                , objSC.FechaCreacion
                                , objSC.UsuarioModificacion
                                , objSC.FechaModificacion
                                , objSC.Accion
                                , objSC.Version
                            ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            int IdDevolucionProductoReg = Convert.ToInt32(iReturnValue.ToString().Trim());


                            if (objSC2 != null)
                            {

                                foreach (var obj in objSC2)
                                {
                                    obj.IdDevolucionProducto = IdDevolucionProductoReg;
                                    /* obj.Accion = "DETALLE";*/

                                    iReturnValue = context.SP_SS_FA_DevolucionProductoDetalle(
                        obj.UnidadReplicacion
                        , obj.IdEpisodioAtencion
                        , obj.IdPaciente
                        , obj.EpisodioClinico
                        , obj.IdDevolucionProducto
                        , obj.Secuencia
                        , obj.Cantidad                        
                        , obj.Linea
                        , obj.Familia
                        , obj.SubFamilia
                        , obj.TipoComponente
                        , obj.CodigoComponente
                         , obj.Medicamento
                        , obj.GrupoMedicamento
                        , obj.IdOrdenAtencion                        
                        , obj.Estado
                        , obj.UsuarioCreacion
                        , obj.FechaCreacion
                        , obj.UsuarioModificacion
                        , obj.FechaModificacion
                        , obj.Accion
                        , obj.Version

                    ).SingleOrDefault();
                                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                                }
                            }
                        }
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

        public List<SS_FA_DevolucionProducto> Listar(SS_FA_DevolucionProducto objSC)
        {

            /////
            try
            {
            object valorRetorno = null;
            var iReturnValue2 = new List<SS_FA_DevolucionProducto>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                /* using (var dbContextTransaction = context.Database.BeginTransaction())
                 {
                     try
                     {*/
               /* if (objSC != null)
                {*/

                 /*   return context.SP_SS_FA_DevolucionProducto_Listar(
                          objSC.UnidadReplicacion
                          , objSC.IdEpisodioAtencion
                          , objSC.IdPaciente
                          , objSC.EpisodioClinico
                          , objSC.IdDevolucionProducto
                          , objSC.NumeroDocumento
                          , objSC.Observacion
                          , objSC.EstadoDocumento
                          , objSC.Estado
                          , objSC.UsuarioCreacion
                          , objSC.FechaCreacion
                          , objSC.UsuarioModificacion
                          , objSC.FechaModificacion
                          , objSC.Accion
                          , objSC.Version
                      ).ToList();*/
                /* .SingleOrDefault();*/
                    /* valorRetorno = Convert.ToString(iReturnValue.ToString().Trim());*/
                    /* int IdSolicitudProductoReg = Convert.ToInt32(iReturnValue.ToString().Trim());*/



                    /*  }
                      context.SaveChanges();
                      dbContextTransaction.Commit();
                  }
                  catch (Exception ex)
                  {
                      dbContextTransaction.Rollback();
                      throw ex;
                  }*/


                    iReturnValue2 = (from t in context.SS_FA_DevolucionProducto
                                     where
                                     t.UnidadReplicacion == objSC.UnidadReplicacion
                                     && t.IdPaciente == objSC.IdPaciente
                                     && t.EpisodioClinico == objSC.EpisodioClinico
                                     && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                     orderby t.IdEpisodioAtencion descending
                                     select t).ToList();



                }
            return iReturnValue2;
            }
            //
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SS_FA_DevolucionProductoDetalle> ListarDetalle(SS_FA_DevolucionProducto objSC)
        {

            /////

            object valorRetorno = null;
            var iReturnValue2 = new List<SS_FA_DevolucionProductoDetalle>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                /* using (var dbContextTransaction = context.Database.BeginTransaction())
                 {
                     try
                     {*/
                if (objSC != null)
                {

                    iReturnValue2 = context.SP_SS_FA_DevolucionProductoDetalle_Listar(
                          objSC.UnidadReplicacion
                          , objSC.IdEpisodioAtencion
                          , objSC.IdPaciente
                          , objSC.EpisodioClinico
                          , objSC.IdDevolucionProducto
                          , null
                          , null
                          , ""
                          , ""
                          , ""
                          , ""
                          , ""
                          , ""
                          , null
                          , null
                          , objSC.Estado
                          , objSC.UsuarioCreacion
                          , objSC.FechaCreacion
                          , objSC.UsuarioModificacion
                          , objSC.FechaModificacion
                          , objSC.Accion
                          , objSC.Version
                      ).ToList();/* .SingleOrDefault();*/
                    /* valorRetorno = Convert.ToString(iReturnValue.ToString().Trim());*/
                    /* int IdSolicitudProductoReg = Convert.ToInt32(iReturnValue.ToString().Trim());*/



                    /*  }
                      context.SaveChanges();
                      dbContextTransaction.Commit();
                  }
                  catch (Exception ex)
                  {
                      dbContextTransaction.Rollback();
                      throw ex;
                  }*/

                }
            }
            return iReturnValue2;

        }
    }
}
