using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALMiscelaneos
{

    public class MiscelaneosRepository : AuditGenerico<MA_MiscelaneosDetalle, MA_MiscelaneosDetalle> 
    {
        public void Auditoria(dynamic DataKey,String Tabla, List<MA_MiscelaneosDetalle> Listados)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            using (var context = new WEB_ERPSALUDEntities())
            {
                  objAudit.Type = "V";
                  if (Listados.Count > 1) objAudit.Type = "L";
                    string tempType = objAudit.Type;
                    objAudit = AddAudita(new MA_MiscelaneosDetalle(), new MA_MiscelaneosDetalle(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(Listados, new List<MA_MiscelaneosDetalle>(), Tabla);
                    objAudit.TableName = Tabla;
                    objAudit.Type = tempType;
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();
            }
        }
        public List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle ObjTrace)
        {
            try
            {
                dynamic DataKey;
                List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                using (var context = new WEB_ERPSALUDEntities())
                {
                    objLista = context.USP_LISTARSERVICIOS(ObjTrace.AplicacionCodigo, ObjTrace.CodigoTabla, ObjTrace.Compania,
                        ObjTrace.CodigoElemento, ObjTrace.DescripcionLocal, ObjTrace.DescripcionExtranjera, ObjTrace.ValorNumerico,
                        ObjTrace.ValorCodigo1, ObjTrace.ValorCodigo2, ObjTrace.ValorCodigo3, ObjTrace.ValorCodigo4,
                        ObjTrace.ValorCodigo5, ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION).ToList();

                }
                if (ObjTrace.ACCION == "EXAMENES")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        IdEpisodioAtencion = ObjTrace.ValorCodigo2,
                        EpisodioClinico = ObjTrace.ValorCodigo3
                    };
                    Auditoria(DataKey, "SS_HC_ExamenSolicitado", objLista);
                }
                else if (ObjTrace.ACCION == "EXAMENCUERPO")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        EpisodioClinico = ObjTrace.ValorCodigo2,
                        IdEpisodioAtencion = ObjTrace.ValorCodigo3,
                        
                    };
                    Auditoria(DataKey, "SS_HC_ExamenFisico_Regional", objLista);
                }
                else if (ObjTrace.ACCION == "ENFERMEACTUAL")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        IdEpisodioAtencion = ObjTrace.ValorCodigo2,
                        EpisodioClinico = ObjTrace.ValorCodigo3                        
                    };
                    Auditoria(DataKey, "SS_HC_Anamnesis_EA_Sintoma", objLista);
                }
                else if (ObjTrace.ACCION == "APERSONALDETALLE")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        IdEpisodioAtencion = ObjTrace.ValorCodigo2,
                        EpisodioClinico = ObjTrace.ValorCodigo3    ,
                        TipoRegistro = ObjTrace.ValorCodigo4,
                    };
                    Auditoria(DataKey, "SS_HC_Anamnesis_AP_Detalle", objLista);
                }
                else if (ObjTrace.ACCION == "ANTEC_FAMILIARES")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        EpisodioClinico = ObjTrace.ValorCodigo2,                        
                        IdEpisodioAtencion = ObjTrace.ValorCodigo3
                        
                    };
                    Auditoria(DataKey, "SS_HC_Anamnesis_AF_Enfermedad", objLista);
                }  
                else if (ObjTrace.ACCION == "DIAGNOSTICO")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        EpisodioClinico = ObjTrace.ValorCodigo2,                        
                        IdEpisodioAtencion = ObjTrace.ValorCodigo3
                        
                    };
                    Auditoria(DataKey, "SS_HC_Diagnostico", objLista);
                }
                else if (ObjTrace.ACCION == "DIAGPROCITA")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        IdEpisodioAtencion = ObjTrace.ValorCodigo2,
                        EpisodioClinico = ObjTrace.ValorCodigo3                                             
                        
                    };
                    Auditoria(DataKey, "SS_HC_ProximaAtencionDiagnostico", objLista);
                }
                else if (ObjTrace.ACCION == "DIAGNOSTICOFE_327_AMB" )
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        EpisodioClinico = ObjTrace.ValorCodigo2,
                        IdEpisodioAtencion = ObjTrace.ValorCodigo3

                    };
                    Auditoria(DataKey, "SS_HC_Diagnostico_327_AMB", objLista);
                }
                else if (ObjTrace.ACCION == "DIAGNOSTICOFE_327_AMB_DETALLES")
                {
                    DataKey = new
                    {
                        IdPaciente = ObjTrace.ValorCodigo1,
                        EpisodioClinico = ObjTrace.ValorCodigo2,
                        IdEpisodioAtencion = ObjTrace.ValorCodigo3

                    };
                    Auditoria(DataKey, "DIAGNOSTICOFE_327_AMB_DETALLES", objLista);
                }

                return objLista;
            }catch(Exception ex){
                throw ex;
            }            
            
        }
        public int setMantenimiento(List<MA_MiscelaneosDetalle> ListaObjTrace) {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue = 0;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (ListaObjTrace != null)
                        {
                            foreach (var ObjTrace in ListaObjTrace)
                            {
                                iReturnValue = context.USP_MiscelaneosDetalle(ObjTrace.AplicacionCodigo, ObjTrace.CodigoTabla, ObjTrace.Compania,
                                    ObjTrace.CodigoElemento, ObjTrace.DescripcionLocal, ObjTrace.DescripcionExtranjera, ObjTrace.ValorNumerico,
                                    ObjTrace.ValorCodigo1, ObjTrace.ValorCodigo2, ObjTrace.ValorCodigo3, ObjTrace.ValorCodigo4,
                                    ObjTrace.ValorCodigo5, ObjTrace.ValorCodigo6, ObjTrace.ValorCodigo7, ObjTrace.ValorEntero1, ObjTrace.ValorEntero2,
                                    ObjTrace.ValorEntero3, ObjTrace.ValorEntero4, ObjTrace.ValorEntero5, ObjTrace.ValorEntero6, ObjTrace.ValorEntero7,
                                    ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION).SingleOrDefault();
                                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());                                
                            }

                        }
                        valorRetorno = Convert.ToInt32(iReturnValue);
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
        public int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        iReturnValue = context.USP_MiscelaneosDetalle(ObjTrace.AplicacionCodigo, ObjTrace.CodigoTabla, ObjTrace.Compania,
                        ObjTrace.CodigoElemento, ObjTrace.DescripcionLocal, ObjTrace.DescripcionExtranjera, ObjTrace.ValorNumerico,
                        ObjTrace.ValorCodigo1, ObjTrace.ValorCodigo2, ObjTrace.ValorCodigo3, ObjTrace.ValorCodigo4,
                        ObjTrace.ValorCodigo5, ObjTrace.ValorCodigo6, ObjTrace.ValorCodigo7, ObjTrace.ValorEntero1, ObjTrace.ValorEntero2,
                        ObjTrace.ValorEntero3, ObjTrace.ValorEntero4, ObjTrace.ValorEntero5, ObjTrace.ValorEntero6, ObjTrace.ValorEntero7,
                        ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION).SingleOrDefault();
                        valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());

                        dbContextTransaction.Commit();
                    }
                    catch(Exception ex){
                        dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        public List<MA_MiscelaneosDetalle> listarMA_MiscelaneosDetalle(MA_MiscelaneosDetalle ObjTrace,int inicio,int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_MA_MiscelaneosDetalle_LISTAR(
                    ObjTrace.AplicacionCodigo
                    ,ObjTrace.CodigoTabla
                    ,ObjTrace.Compania
                    ,ObjTrace.CodigoElemento
                    ,ObjTrace.DescripcionLocal
                    ,ObjTrace.DescripcionExtranjera
                    ,ObjTrace.ValorNumerico
                    ,ObjTrace.ValorCodigo1
                    ,ObjTrace.ValorCodigo2
                    ,ObjTrace.ValorCodigo3
                    ,ObjTrace.ValorCodigo4
                    ,ObjTrace.ValorCodigo5
                    ,ObjTrace.ValorFecha
                    ,ObjTrace.Estado
                    ,ObjTrace.UltimoUsuario
                    , ObjTrace.UltimaFechaModif
                    , ObjTrace.RowID
                    , ObjTrace.ValorEntero1
                    , ObjTrace.ValorEntero2
                    , ObjTrace.ValorEntero3
                    , ObjTrace.ValorEntero4
                    , ObjTrace.ValorEntero5
                    , ObjTrace.ValorCodigo6
                    , ObjTrace.ValorCodigo7
                    , ObjTrace.ValorEntero6
                    , ObjTrace.ValorEntero7

                    ,inicio,final
                    , ObjTrace.ACCION
                    ).ToList();
            }
        }
        public List<MA_MiscelaneosDetalle> CombosMiscelaneos(MA_MiscelaneosDetalle ObjTrace)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_COMBOSMISCELANEOS(ObjTrace.AplicacionCodigo, ObjTrace.CodigoTabla, ObjTrace.Compania,
                    ObjTrace.CodigoElemento, ObjTrace.DescripcionLocal, ObjTrace.DescripcionExtranjera, ObjTrace.ValorNumerico,
                    ObjTrace.ValorCodigo1, ObjTrace.ValorCodigo2, ObjTrace.ValorCodigo3, ObjTrace.ValorCodigo4,
                    ObjTrace.ValorCodigo5, ObjTrace.ValorFecha, ObjTrace.Estado, ObjTrace.ACCION, ObjTrace.ValorEntero1,
                    ObjTrace.ValorEntero2, ObjTrace.ValorEntero3, ObjTrace.ValorEntero4, ObjTrace.ValorEntero5, ObjTrace.ValorEntero6,
                    ObjTrace.ValorEntero7).ToList();
            }
        }
        public List<MA_MiscelaneosDetalle> getRuleGetCollectionStore(HC_RuleGetCollectionStore objSC)
        {

            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        return context.SP_SS_HC_RuleGetCollectionStore(
                         objSC.AplicacionCodigo,
                         objSC.CodigoTabla,
                         objSC.Compania,
                         objSC.CodigoElemento,
                         objSC.DescripcionLocal,
                         objSC.DescripcionExtranjera,
                         objSC.ValorNumerico,
                         objSC.ValorCodigo1,
                         objSC.ValorCodigo2,
                         objSC.ValorCodigo3,
                         objSC.ValorCodigo4,
                         objSC.ValorCodigo5,
                         objSC.ValorCodigo6,
                         objSC.ValorCodigo7,
                         objSC.ValorFecha,
                         objSC.ValorFechaInicio,
                         objSC.ValorFechaFinal,
                         objSC.Estado,
                         objSC.UltimoUsuario,
                         objSC.UltimaFechaModif,
                         objSC.RowID,
                         objSC.ValorEntero1,
                         objSC.ValorEntero2,
                         objSC.ValorEntero3,
                         objSC.ValorEntero4,
                         objSC.ValorEntero5,
                         objSC.ValorEntero6,
                         objSC.ValorEntero7,
                         objSC.inicio,
                         objSC.final,
                         objSC.ACCION).ToList();
                    }
                    catch (Exception ex)
                    {
                        //dbContextTransaction.Rollback();
                        throw ex;
                    }
                }
            }
            // return valorRetorno;
        }

        public List<SS_FA_NotificacionDetalle> listarNotificaciones()
        {

            List<SS_FA_NotificacionDetalle> lstLinea = new List<SS_FA_NotificacionDetalle>();
            using (var ctx = new WEB_ERPSALUDEntities())
            {
                //lstLinea = ctx.Database.SqlQuery<SS_FA_NotificacionDetalle>("SELECT * FROM SS_FA_NotificacionDetalle").ToList();
                lstLinea = ctx.Database.SqlQuery<SS_FA_NotificacionDetalle>("SELECT NDD.UnidadReplicacion,NDD.IdEpisodioAtencion,NDD.IdPaciente,NDD.EpisodioClinico,NDD.IdNotificacion, 0 Secuencia, " +
                " NDD.NumeroDocumento,convert(decimal,COUNT(NDD.Secuencia)) Cantidad,'' Linea,'' Familia,'' SubFamilia,'' TipoComponente,'' CodigoComponente,'' Medicamento, " +
                " 0 GrupoMedicamento,NDD.IdOrdenAtencion,0 Estado,NDD.UsuarioCreacion,EA.FechaCreacion,NDD.UsuarioModificacion, " +
                " EA.FechaModificacion,'' Accion,'' Version,NDD.indicaciones,EA.codigooa  codigoauxiliar1,PAC.NOMBRECOMPLETO codigoauxiliar2,'' codigoauxiliar3, " +
                " '' codigoauxiliar4,'' SecuencialHCE " +
                " FROM SS_FA_NotificacionDetalle NDD " +
                " INNER JOIN SS_HC_EpisodioAtencion EA ON  EA.IDPACIENTE=NDD.IDPACIENTE AND EA.IDEPISODIOATENCION=NDD.IDEPISODIOATENCION " +
                " INNER JOIN PERSONAMAST PAC ON PAC.PERSONA=NDD.IdPaciente " +
                " AND EA.UnidadReplicacion=NDD.UnidadReplicacion  AND EA.EpisodioClinico=NDD.EpisodioClinico   " +
                " WHERE NDD.Estado=2 " +
                "  GROUP BY  " +
                " NDD.UnidadReplicacion,NDD.IdEpisodioAtencion,NDD.IdPaciente,NDD.EpisodioClinico,NDD.IdNotificacion, " +
                " NDD.NumeroDocumento,NDD.IdOrdenAtencion,NDD.UsuarioCreacion,EA.FechaCreacion,NDD.UsuarioModificacion, " +
                 " EA.FechaModificacion,NDD.indicaciones,EA.codigooa,PAC.NOMBRECOMPLETO ORDER BY  NDD.NumeroDocumento DESC ").ToList();
            }
            return lstLinea;
        }
    }
}