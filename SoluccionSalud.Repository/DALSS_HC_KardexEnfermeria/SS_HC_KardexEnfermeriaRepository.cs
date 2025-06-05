using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.ModelPAE;

namespace SoluccionSalud.Repository.DALSS_HC_KardexEnfermeria
{
    public class SS_HC_KardexEnfermeriaRepository
    {
        public int setMantenimiento(SS_HC_KardexEnfermeria objSC, List<SS_HC_KardexEnfermeriaDetalle> objSC2)
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
                            
                            iReturnValue = context.SP_SS_HC_KardexEnfermeria(
                                objSC.UnidadReplicacion
                                , objSC.IdEpisodioAtencion
                                , objSC.IdPaciente
                                , objSC.EpisodioClinico
                                , objSC.IdOrdenAtencion
                                , objSC.Observacion
                                , objSC.Estado
                                , objSC.UsuarioCreacion
                                , objSC.FechaCreacion
                                , objSC.UsuarioModificacion
                                , objSC.FechaModificacion
                                , objSC.Accion
                                , objSC.Version
                            ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            int IdOrdenAtencionReg = Convert.ToInt32(iReturnValue.ToString().Trim());


                            if (objSC2 != null)
                            {

                                foreach (var obj in objSC2)
                                {
                                    obj.IdOrdenAtencion = IdOrdenAtencionReg;
                                    /* obj.Accion = "DETALLE";*/

                                    iReturnValue = context.SP_SS_HC_KardexEnfermeriaDetalle(
                        obj.UnidadReplicacion
                        , obj.IdEpisodioAtencion
                        , obj.IdPaciente
                        , obj.EpisodioClinico
                        , obj.IdOrdenAtencion
                        , obj.Secuencia
                        , obj.UnidadReplicacionReferencia
                        , obj.IdEpisodioAtencionReferencia
                        , obj.IdPacienteReferencia
                        , obj.EpisodioClinicoReferencia
                        , obj.Fecha                        
                        , obj.FechaCorte
                        , obj.HoraInicioProg
                        , obj.HorasProgramadas
                        , obj.HorasSuministradas
                        , obj.EnfermeraSuministro
                        , obj.Linea
                        , obj.Familia
                        , obj.SubFamilia
                        , obj.TipoComponente
                        , obj.CodigoComponente                        
                        , obj.SituacionRegistro
                        , obj.GrupoMedicamento
                        , obj.Observacion
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

        public object Listar(SS_HC_KardexEnfermeria objSC)
        {

            /////

            object valorRetorno = null;
            var iReturnValue2 = new List<SS_HC_KardexEnfermeria>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                /* using (var dbContextTransaction = context.Database.BeginTransaction())
                 {
                     try
                     {*/
                if (objSC != null)
                {

                    /*  iReturnValue = context.SP_SS_FA_SolicitudProducto(
                          objSC.UnidadReplicacion
                          , objSC.IdEpisodioAtencion
                          , objSC.IdPaciente
                          , objSC.EpisodioClinico
                          , objSC.IdSolicitudProducto
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
                      ).ToString();/* .SingleOrDefault();*/
                    /* valorRetorno = Convert.ToString(iReturnValue.ToString().Trim());*/
                    /* int IdSolicitudProductoReg = Convert.ToInt32(iReturnValue.ToString().Trim());*/

                    if (objSC.Accion == "ESTADO")
                    {

                        List<SS_HC_KardexEnfermeria> iReturnValue3 = (from t in context.SS_HC_KardexEnfermeria
                                                                      where
                                                                      t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                      && t.IdPaciente == objSC.IdPaciente
                                                                      && t.EpisodioClinico == objSC.EpisodioClinico
                                                                      && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                      orderby t.IdEpisodioAtencion descending
                                                                      select t).ToList();
                        /*objLista.AddRange(iReturnValue2);*/
                        if (iReturnValue3.Count > 0)
                        {
                            valorRetorno = iReturnValue3[0].Estado.ToString();/*[0].ToString();*/
                        }
                        else { valorRetorno = ""; }
                    }
                    if (objSC.Accion == "OBSERVACION")
                    {

                        List<SS_HC_KardexEnfermeria> iReturnValue = (from t in context.SS_HC_KardexEnfermeria
                                                                     where
                                                                     t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                     && t.IdPaciente == objSC.IdPaciente
                                                                     && t.EpisodioClinico == objSC.EpisodioClinico
                                                                     && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                     orderby t.IdEpisodioAtencion descending
                                                                     select t).ToList();

                        if (iReturnValue.Count > 0)
                        {
                            valorRetorno = iReturnValue[0].Observacion.ToString();
                        }
                        else { valorRetorno = ""; }
                    }
                    if (objSC.Accion == "IDSOLICITUD")
                    {

                        List<SS_HC_KardexEnfermeria> iReturnValue = (from t in context.SS_HC_KardexEnfermeria
                                                                     where
                                                                     t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                     && t.IdPaciente == objSC.IdPaciente
                                                                     && t.EpisodioClinico == objSC.EpisodioClinico
                                                                     && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                     orderby t.IdEpisodioAtencion descending
                                                                     select t).ToList();

                        if (iReturnValue.Count > 0)
                        {
                            valorRetorno = iReturnValue[0].IdOrdenAtencion.ToString();
                        }
                        else { valorRetorno = ""; }
                    }



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
            return valorRetorno;

        }
    }
}
