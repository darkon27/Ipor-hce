using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.ModelPAE;
using System.Data.Entity;
using System.Data.SqlClient;

namespace SoluccionSalud.Repository.DALSS_FA_SolicitudProducto
{
    public class SS_FA_SolicitudProductoRepository
    {


        public List<SS_FA_SolicitudProducto> ListarSolicitudProductoListar(SS_FA_SolicitudProducto objSC)
        {
            var iReturnValue = new List<SS_FA_SolicitudProducto>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = (from t in context.SS_FA_SolicitudProducto
                                    where
                                    t.UnidadReplicacion == objSC.UnidadReplicacion
                                    && t.IdPaciente == objSC.IdPaciente
                                    && t.EpisodioClinico == objSC.EpisodioClinico
                                    && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion                                                          
                                    orderby t.IdEpisodioAtencion descending
                                    select t).ToList();
            }
            return iReturnValue;

        }

        public int retornoMedicamento(SS_FA_SolicitudProducto objSC)
        {
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
                            //int Secuencia = 0;
                            //string UnidadReplicacionReferencia = null;
                            //int IdEpisodioAtencionReferencia = 0;
                            //int IdPacienteReferencia = 0;
                            //int EpisodioClinicoReferencia = 0;
                            //int Cantidad = 0;
                            //string Linea = null;
                            //string Familia = null;
                            //string SubFamilia = null;
                            //string TipoComponente = null;
                            //string CodigoComponente = null;
                            //int IdOrdenAtencion = 0;
                            //int Estado = 0;




                            iReturnValue = context.SP_SS_FA_SolicitudProducto(
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
                                , objSC.indicaciones
                            ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            //int IdSolicitudProductoReg = Convert.ToInt32(iReturnValue.ToString().Trim());
                        }
                        context.SaveChanges();
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {

                        //DataKey = new
                        //{
                        //    UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        //    IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion,
                        //    EpisodioClinico = ObjTrace.EpisodioClinico,
                        //    IdPaciente = ObjTrace.IdPaciente,
                        //    Secuencia = ObjTrace.Secuencia
                        //};

                        //JSONstring = JsonConvert.SerializeObject(data);
                        //JSONstring = JsonConvert.SerializeObject(data);
                        ////objAudit.Type = "V";
                        ////if (objLista.Count > 1) objAudit.Type = "L";
                        ////string tempType = objAudit.Type;
                        ////objAudit = AddAudita(new SS_HC_Diagnostico_FE(), new SS_HC_Diagnostico_FE(), DataKey, objAudit.Type);
                        ////String xlmIn = XMLString(objLista, new List<SS_HC_Diagnostico_FE>(), "SS_HC_Diagnostico_FE");
                        ////objAudit.TableName = "SS_HC_Diagnostico_FE";
                        ////objAudit.Type = tempType;
                        ////objAudit.VistaData = xlmIn;
                        dbContextTransaction.Rollback();
                        throw ex;
                    }

                }
            }
            return valorRetorno;
        }

        public int setMantenimiento(SS_FA_SolicitudProducto objSC, List<SS_FA_SolicitudProductoDetalle> objSC2)
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
                             iReturnValue = context.SP_SS_FA_SolicitudProducto(
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
                                , objSC.indicaciones
                            ).SingleOrDefault();
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                            int IdSolicitudProductoReg = Convert.ToInt32(iReturnValue.ToString().Trim());
                            if (objSC2 != null)
                            {
                                foreach (var obj in objSC2)
                                {
                                    obj.IdSolicitudProducto = IdSolicitudProductoReg;
                                    /* obj.Accion = "DETALLE";*/
                                        iReturnValue = context.SP_SS_FA_SolicitudProductoDetalle(
                                          obj.UnidadReplicacion
                                        , obj.IdEpisodioAtencion
                                        , obj.IdPaciente
                                        , obj.EpisodioClinico
                                        , obj.IdSolicitudProducto
                                        , obj.Secuencia
                                        , obj.UnidadReplicacionReferencia
                                        , obj.IdEpisodioAtencionReferencia
                                        , obj.IdPacienteReferencia
                                        , obj.EpisodioClinicoReferencia
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
                                        , obj.indicaciones
                                        , obj.LineaOrdenAtencion
                                        , obj.SecuencialHCE

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



        public object Listar(SS_FA_SolicitudProducto objSC)
        {

            /////
           
            object valorRetorno = null;
            var iReturnValue2 = new List<SS_FA_SolicitudProducto>();
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
                            if (objSC.Accion == "ID_REGISTRAR")
                            {

                                List<SS_FA_SolicitudProducto> iReturnValue = (from t in context.SS_FA_SolicitudProducto
                                                                              where
                                                                              t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                              && t.IdPaciente == objSC.IdPaciente
                                                                              && t.EpisodioClinico == objSC.EpisodioClinico
                                                                              && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                              && t.IdSolicitudProducto == objSC.IdSolicitudProducto
                                                                              orderby t.IdEpisodioAtencion descending
                                                                              select t).ToList();

                                if (iReturnValue.Count > 0)
                                {
                                    valorRetorno = iReturnValue[0].NumeroDocumento.ToString();
                                }
                                else { valorRetorno = ""; }
                            }
                            if (objSC.Accion == "NDOCUMENTO")
                            {

                             List<SS_FA_SolicitudProducto>   iReturnValue3 = (from t in context.SS_FA_SolicitudProducto
                                                        where
                                                        t.UnidadReplicacion == objSC.UnidadReplicacion
                                                        && t.IdPaciente == objSC.IdPaciente
                                                        && t.EpisodioClinico == objSC.EpisodioClinico
                                                        && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                        && t.IdSolicitudProducto == objSC.IdSolicitudProducto
                                                        orderby t.IdEpisodioAtencion descending
                                                        select t).ToList();
                                /*objLista.AddRange(iReturnValue2);*/
                             if (iReturnValue3.Count > 0)
                             {
                                 valorRetorno = iReturnValue3;/*[0].ToString();*/
                             }
                             else { valorRetorno = ""; }
                            }
                            if (objSC.Accion == "OBSERVACION")
                            {

                                List<SS_FA_SolicitudProducto> iReturnValue = (from t in context.SS_FA_SolicitudProducto
                                                where
                                                t.UnidadReplicacion == objSC.UnidadReplicacion
                                                && t.IdPaciente == objSC.IdPaciente
                                                && t.EpisodioClinico == objSC.EpisodioClinico
                                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                && t.NumeroDocumento == objSC.NumeroDocumento
                                                orderby t.IdEpisodioAtencion descending
                                                       select t).ToList();

                                if (iReturnValue.Count > 0)
                                {
                                    valorRetorno = iReturnValue[0].Observacion.ToString();
                                }
                                else { valorRetorno = ""; }
                            }
                            if (objSC.Accion == "INDICACIONES")
                            {

                                List<SS_FA_SolicitudProducto> iReturnValue = (from t in context.SS_FA_SolicitudProducto
                                                                              where
                                                                              t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                              && t.IdPaciente == objSC.IdPaciente
                                                                              && t.EpisodioClinico == objSC.EpisodioClinico
                                                                              && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                              && t.NumeroDocumento == objSC.NumeroDocumento
                                                                              orderby t.IdEpisodioAtencion descending
                                                                              select t).ToList();

                                if (iReturnValue.Count > 0)
                                {
                                    valorRetorno = iReturnValue[0].indicaciones.ToString();
                                }
                                else { valorRetorno = ""; }
                            }
                            if (objSC.Accion == "IDSOLICITUD")
                            {

                                List<SS_FA_SolicitudProducto> iReturnValue = (from t in context.SS_FA_SolicitudProducto
                                                where
                                                t.UnidadReplicacion == objSC.UnidadReplicacion
                                                && t.IdPaciente == objSC.IdPaciente
                                                && t.EpisodioClinico == objSC.EpisodioClinico
                                                && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                && t.NumeroDocumento == objSC.NumeroDocumento
                                                orderby t.IdEpisodioAtencion descending
                                                       select t).ToList();

                                if (iReturnValue.Count > 0)
                                {
                                    valorRetorno = iReturnValue[0].IdSolicitudProducto.ToString();
                                }
                                else { valorRetorno = ""; }
                            }

                            if (objSC.Accion == "ESTADO")
                            {

                                List<SS_FA_SolicitudProducto> iReturnValue = (from t in context.SS_FA_SolicitudProducto
                                                                              where
                                                                              t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                              && t.IdPaciente == objSC.IdPaciente
                                                                              && t.EpisodioClinico == objSC.EpisodioClinico
                                                                              && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                              && t.NumeroDocumento == objSC.NumeroDocumento
                                                                              orderby t.IdEpisodioAtencion descending
                                                                              select t).ToList();

                                if (iReturnValue.Count > 0)
                                {
                                    valorRetorno = iReturnValue[0].Estado.ToString();
                                    if (valorRetorno == null || valorRetorno == "") 
                                    { 
                                        valorRetorno = "2";
                                    }
                                }
                                else { valorRetorno = "1"; }
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

        public List<SS_FA_SolicitudProductoDetalle> ListarDetalle(SS_FA_SolicitudProducto objSC)
        {

            /////

            object valorRetorno = null;
            var iReturnValue2 = new List<SS_FA_SolicitudProductoDetalle>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                /* using (var dbContextTransaction = context.Database.BeginTransaction())
                 {
                     try
                     {*/
                if (objSC != null)
                {

                    iReturnValue2 = context.SP_SS_FA_SolicitudProductoDetalle_Listar(
                          objSC.UnidadReplicacion
                          , objSC.IdEpisodioAtencion
                          , objSC.IdPaciente
                          , objSC.EpisodioClinico
                          , objSC.IdSolicitudProducto
                          , null
                          , ""
                          , null
                          , null
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