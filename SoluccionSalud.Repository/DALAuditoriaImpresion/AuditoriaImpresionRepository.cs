using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using SoluccionSalud.RepositoryReport;

namespace SoluccionSalud.Repository.DALAuditoriaImpresion
{
    public class AuditoriaImpresionRepository : AuditGenerico<SS_HC_ImpresionHC, SS_HC_ImpresionHC>
    {
        public List<SS_HC_ImpresionHC> listarAudi_Imp(SS_HC_ImpresionHC objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_ImpresionHC_Detalle objSC2 = new SS_HC_ImpresionHC_Detalle();
            List<SS_HC_ImpresionHC> objLista = new List<SS_HC_ImpresionHC>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_ImpresionHC_LISTAR(objSC.IdImpresion, objSC.UnidadReplicacion, 
                  objSC.IdPaciente, objSC.HostImpresion,  objSC.UsuarioImpresion, objSC.FechaImpresion, 
                  objSC.CodigoHC, objSC.Accion, objSC.Version,  objSC.Descripcion , inicio, final,
                  objSC.Contador_filas).ToList();

                  //objLista = context.RPT_SolicitudProducto_Reportes(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                  //              objSC.IdPaciente, objSC.EpisodioClinico, objSC.Accion).ToList();

        /*           objLista = (from t in context.SS_HC_ImpresionHC
                           where
                           t.FechaImpresion >= objSC.FechaImpresion &&
                           t.FechaImpresion <= objSC.Descripcion &&
                           t.UnidadReplicacion == objSC.UnidadReplicacion

                               select t

                                   ).ToList();*/



                //AQUI ME QUEDO
               // DataKey = new
               // {
               //     IdImpresion = objSC.IdImpresion
               // };
               // // Audit
               // String xlmIn = XMLString(objLista, new List<SS_HC_ImpresionHC>(), "SS_HC_ImpresionHC");
               // objAudit = AddAudita(new SS_HC_ImpresionHC(), objSC, DataKey, "L");
               //// objAudit.TableName = "SS_HC_ImpresionHC";
               //// objAudit.Type = "L";
               // objAudit.Accion = "INSERT";
               //// objAudit.VistaData = xlmIn;
               // context.Entry(objAudit).State = EntityState.Added;
               // context.SaveChanges();

            }

            return objLista;
        }
        public int setMantenimientoAI(SS_HC_ImpresionHC objSC)
        {
            System.Nullable<int> iReturnValue;
            SS_HC_ImpresionHC_Detalle objSC2 = new SS_HC_ImpresionHC_Detalle();
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.SP_SS_HC_ImpresionHC(objSC.IdImpresion,
                            objSC.UnidadReplicacion, objSC.IdPaciente, objSC.HostImpresion,
                            objSC.UsuarioImpresion, objSC.FechaImpresion, objSC.CodigoHC, objSC.Accion,
                            objSC2.Secuencial, objSC2.IdEpisodioAtencion, objSC2.IdOpcion,
                            objSC2.EpisodioClinico, objSC2.EpisodioAtencion, objSC2.CodigoOpcion,
                            objSC2.IdFormato, objSC2.TipoAtencion, objSC2.IdUnidadServicio,
                            objSC2.IdPersonalSalud).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        public int save_ChangesTraking(SS_HC_ImpresionHC objSC,SS_HC_ImpresionHC_Detalle objDetalle,String indica)
        {
            int valorRetorno = 0;            
            System.Nullable<int> iReturnValue;            
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.SP_SS_HC_ImpresionHC(objSC.IdImpresion,
                            objSC.UnidadReplicacion, objSC.IdPaciente, objSC.HostImpresion,
                            objSC.UsuarioImpresion, objSC.FechaImpresion, objSC.CodigoHC, objSC.Accion,
                            objDetalle.Secuencial, objDetalle.IdEpisodioAtencion, objDetalle.IdOpcion,
                            objDetalle.EpisodioClinico, objDetalle.EpisodioAtencion, objDetalle.CodigoOpcion,
                            objDetalle.IdFormato, objDetalle.TipoAtencion, objDetalle.IdUnidadServicio,
                            objDetalle.IdPersonalSalud).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }

    }
}
