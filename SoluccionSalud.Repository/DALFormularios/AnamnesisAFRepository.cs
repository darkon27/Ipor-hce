using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALFormularios
{
    public class AnamnesisAFRepository : AuditGenerico<SS_HC_Anamnesis_AF, SS_HC_Anamnesis_AF> 
    {
        public long setMantAnamnesisAF(SS_HC_Anamnesis_AF ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            long  valorRetorno = 0;
            try
            {
                using (var context = new WEB_ERPSALUDEntities())
                {
                    iReturnValue = context.USP_AnamnesisAF(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                        0, ObjTrace.IdTipoParentesco, ObjTrace.Edad, ObjTrace.IdVivo, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                        ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                    valorRetorno = Convert.ToInt64(iReturnValue.ToString().Trim());

                }
            }
            catch (Exception ex)
            {
                //var sqlException = ex.InnerException as SqlException;
                throw ex;
            }
            return valorRetorno;
        }
        public long setMantAnamnesisAF(SS_HC_Anamnesis_AF ObjTraces, List<SS_HC_Anamnesis_AF> Cabecera, List<SS_HC_Anamnesis_AF_Enfermedad> Detalle)
        {
            //  Aquiles MH  : 09/07/2015
            //  Eventos     : Transacciones
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            long valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                         // var department = context.SS_HC_Anamnesis_AF.First<SS_HC_Anamnesis_AF>();
                         // var unicorn = context.SS_HC_Anamnesis_AF.Find(ObjTraces.UnidadReplicacion, ObjTraces.IdEpisodioAtencion, ObjTraces.IdPaciente, ObjTraces.EpisodioClinico);
                            foreach (SS_HC_Anamnesis_AF ObjTrace in Cabecera)
                            {
                               
                                var InformacionObj = (from t in context.SS_HC_Anamnesis_AF
                                                          where t.IdPaciente == ObjTrace.IdPaciente
                                                          && t.EpisodioClinico == ObjTrace.EpisodioClinico
                                                          && t.IdEpisodioAtencion == ObjTrace.IdEpisodioAtencion
                                                          orderby t.IdEpisodioAtencion descending
                                                     select t).SingleOrDefault();
                                if (InformacionObj ==null) InformacionObj = new SS_HC_Anamnesis_AF();
                                
                                iReturnValue = context.USP_AnamnesisAF(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                                       0, ObjTrace.IdTipoParentesco, ObjTrace.Edad, ObjTrace.IdVivo, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                                      ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                                

                                //*  Registra Audit/
                                     DataKey = new {
                                         UnidadReplicacion = ObjTrace.UnidadReplicacion, 
                                         IdPaciente = ObjTrace.IdPaciente, 
                                         EpisodioClinico = ObjTrace.EpisodioClinico, 
                                         IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion
                                     };
                                    objAudit = AddAudita(InformacionObj, ObjTrace, DataKey, ObjTrace.Accion.Substring(0, 1));
                                    objAudit.TableName = "SS_HC_Anamnesis_AF";
                                    objAudit.Type = ObjTrace.Accion.Substring(0,1);
                                    context.Entry(objAudit).State = EntityState.Added;
                                    
                                //*/

                                    foreach (SS_HC_Anamnesis_AF_Enfermedad ObjTraceDell in Detalle)
                                    {
                                        var InforDetalleObj = (from t in context.SS_HC_Anamnesis_AF_Enfermedad
                                                               where t.IdPaciente == ObjTraceDell.IdPaciente
                                                              && t.EpisodioClinico == ObjTraceDell.EpisodioClinico
                                                              && t.IdEpisodioAtencion == ObjTraceDell.IdEpisodioAtencion
                                                              && t.Secuencia == ObjTraceDell.Secuencia
                                                              orderby t.IdEpisodioAtencion descending
                                                              select t).SingleOrDefault();
                                        if (InforDetalleObj == null) InforDetalleObj = new SS_HC_Anamnesis_AF_Enfermedad();
                                        
                                        if (ObjTraceDell.Accion == "DETALLE") context.Entry(ObjTraceDell).State = EntityState.Added;
                                        if (ObjTraceDell.Accion == "UPDATEDETALLE") context.Entry(ObjTraceDell).State = EntityState.Modified;
                                        if (ObjTraceDell.Accion == "DELETE") context.Entry(ObjTraceDell).State = EntityState.Deleted;

                                        if (ObjTraceDell.Accion == "DETALLE")
                                        {
                                            objAudit.Type = "N";
                                        }
                                            //*  Registra Audit/
                                         DataKey = new {
                                             UnidadReplicacion = ObjTraceDell.UnidadReplicacion,
                                             IdPaciente = ObjTraceDell.IdPaciente,
                                             EpisodioClinico = ObjTraceDell.EpisodioClinico,
                                                            IdEpisodioAtencion = ObjTraceDell.IdEpisodioAtencion,
                                                            Secuencia = ObjTraceDell.Secuencia };
                                         objAudit = AddAudita(InforDetalleObj, ObjTraceDell, DataKey, ObjTraceDell.Accion.Substring(0, 1));
                                         objAudit.TableName = "SS_HC_Anamnesis_AF_Enfermedad";
                                         objAudit.Type = ObjTraceDell.Accion.Substring(0, 1);
                                         context.Entry(objAudit).State = EntityState.Added;
                                            
                                        //*/
                                    }
                                    valorRetorno = Convert.ToInt64(iReturnValue.ToString().Trim());

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
 

        public List<SS_HC_Anamnesis_AF> AnamnesisAFListar(SS_HC_Anamnesis_AF ObjTrace)
        {
            try
            {
                dynamic DataKey = null;
                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                List<SS_HC_Anamnesis_AF> objLista = new List<SS_HC_Anamnesis_AF>();
                using (var context = new WEB_ERPSALUDEntities())
                {


                    objLista = context.USP_AnamnesisAFListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                        0, ObjTrace.IdTipoParentesco, ObjTrace.Edad, ObjTrace.IdVivo, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                        ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();
                    //*  Registra Audit/
                    DataKey = new
                    {
                        UnidadReplicacion = ObjTrace.UnidadReplicacion,
                        IdPaciente = ObjTrace.IdPaciente,
                        EpisodioClinico = ObjTrace.EpisodioClinico,
                        IdEpisodioAtencion = ObjTrace.IdEpisodioAtencion

                    };
                    objAudit.Type = "V";
                    if (objLista.Count > 1) objAudit.Type = "L";
                    objAudit = AddAudita(new SS_HC_Anamnesis_AF(), new SS_HC_Anamnesis_AF(), DataKey, objAudit.Type);
                    String xlmIn = XMLString(objLista, new List<SS_HC_Anamnesis_AF>(), "SS_HC_Anamnesis_AF");
                    objAudit.TableName = "SS_HC_Anamnesis_AF";
                    objAudit.Type = "V";
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();
                    //*/
                    return objLista;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }	
        }

        /**NUEVA VERSIÓN***/


        public long setMantAnamnesisAF(SS_HC_Anamnesis_AFAM ObjTraces, List<SS_HC_Anamnesis_AFAM> Cabecera, List<SS_HC_Anamnesis_AFAM_Enfermedad> Detalle)
        {
            //  Aquiles MH  : 09/07/2015
            //  Eventos     : Transacciones
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            System.Nullable<int> iReturnValue;
            long valorRetorno = -1;
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        Dictionary<String, int> mapSecuenciaFam = new Dictionary<String, int>();
                        int contadorCab = 0;
                        /**obtener la última secuencia*/
                        var secuenciaFamMax = context.SS_HC_Anamnesis_AFAM
                                .Where(t =>
                                        t.IdPaciente == ObjTraces.IdPaciente
                                        && t.UnidadReplicacion == ObjTraces.UnidadReplicacion
                                        && t.EpisodioClinico == ObjTraces.EpisodioClinico
                                        && t.IdEpisodioAtencion == ObjTraces.IdEpisodioAtencion
                                ).DefaultIfEmpty().Max(t => t == null ? 0 : t.SecuenciaFamilia);

                        if (Cabecera.Count>0)
                        {
                            foreach (SS_HC_Anamnesis_AFAM objSC in Cabecera)
                            {
                                if (objSC != null)
                                {
                                    int secuenciaFamAux = objSC.SecuenciaFamilia;
                                    SS_HC_Anamnesis_AFAM objAnterior = null;
                                    if (objSC.Accion == null) objSC.Accion = "X";
                                    if ((objSC.Accion.Substring(0, 1) != "I") && (objSC.Accion.Substring(0, 1) != "N"))
                                    {
                                        objAnterior = (from t in context.SS_HC_Anamnesis_AFAM
                                                       where
                                                       t.UnidadReplicacion == objSC.UnidadReplicacion
                                                       && t.IdPaciente == objSC.IdPaciente
                                                       && t.EpisodioClinico == objSC.EpisodioClinico
                                                       && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                       && t.SecuenciaFamilia == objSC.SecuenciaFamilia
                                                       orderby t.IdEpisodioAtencion descending
                                                       select t).SingleOrDefault();
                                    }
                                    /**TRANSACCIÓN*/
                                    if (objAnterior != null)
                                    {
                                        if (objSC.Accion == "UPDATE")
                                        {
                                           /* objSC.Version = "CCEP0055";*/
                                            context.Entry(objSC).State = EntityState.Modified;
                                            mapSecuenciaFam.Add("" + secuenciaFamAux, objSC.SecuenciaFamilia);
                                        }
                                        else if (objSC.Accion == "DELETE")
                                        {
                                            //PRIMERO ELIMINAR DETALLE
                                            List<SS_HC_Anamnesis_AFAM_Enfermedad> objConsultasDet = (from t in context.SS_HC_Anamnesis_AFAM_Enfermedad
                                                                                       where
                                                                                       t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                                       && t.IdPaciente == objSC.IdPaciente
                                                                                       && t.EpisodioClinico == objSC.EpisodioClinico
                                                                                       && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                                       && t.SecuenciaFamilia == objSC.SecuenciaFamilia
                                                                                       orderby t.IdEpisodioAtencion descending
                                                                                       select t).ToList();



                                            if (objConsultasDet != null){
                                                foreach(SS_HC_Anamnesis_AFAM_Enfermedad resultDet in objConsultasDet){
                                                    context.Entry(resultDet).State = EntityState.Deleted;
                                                }                                                
                                            }
                                            context.Entry(objSC).State = EntityState.Deleted;
                                        }
                                    }
                                    else
                                    {
                                        if (objSC.Accion == "NUEVO")
                                        {
                                            contadorCab++;
                                           /* objSC.Version = "CCEP0055";*/
                                            objSC.SecuenciaFamilia = secuenciaFamMax + contadorCab;
                                            context.Entry(objSC).State = EntityState.Added;
                                            mapSecuenciaFam.Add("" + secuenciaFamAux, objSC.SecuenciaFamilia);
                                        }
                                        //InformacionObj = new SS_HC_MiscelaneosPacienteGeneral();
                                    }
                                    //ADD MAP (ARTIFICIO PARA OBTENER LOS VERDADEROS ID DEL HEADER)
                                    

                                    /*************/
                                    /***** INICIO AUDITORÍA *****/
                                    DataKey = new
                                    {
                                        UnidadReplicacion = objSC.UnidadReplicacion,
                                        IdPaciente = objSC.IdPaciente,
                                        EpisodioClinico = objSC.EpisodioClinico,
                                        IdOrdenAtencion = objSC.IdEpisodioAtencion,
                                        SecuenciaFamilia = objSC.SecuenciaFamilia,
                                    };
                                    //LLAMAR MÉTODO
                                    if (objAnterior == null) objAnterior = new SS_HC_Anamnesis_AFAM();
                                    int resultAudit = setAuditoria(objAnterior, objSC, objSC.Accion, "SS_HC_Anamnesis_AFAM",
                                        new SS_HC_AuditRoyal(), DataKey, context);
                                    /***TERMINA AUDITORÍA *****/
                                    //context.SaveChanges();
                                    //dbContextTransaction.Commit();
                                    valorRetorno = 1;
                                }
                                else
                                {
                                    //valorRetorno = 0;
                                }
                            }

                            /*********GUARDAR DETALLE***************/
                            if (Detalle != null)
                            {
                                int contadorDet = 0;
                                /**obtener la última secuencia*/
                                var secuenciaMax = context.SS_HC_Anamnesis_AFAM_Enfermedad
                                        .Where(t =>
                                                t.IdPaciente == ObjTraces.IdPaciente
                                                && t.UnidadReplicacion == ObjTraces.UnidadReplicacion
                                                && t.EpisodioClinico == ObjTraces.EpisodioClinico
                                                && t.IdEpisodioAtencion == ObjTraces.IdEpisodioAtencion
                                                //&& t.SecuenciaFamilia == ObjTraces.SecuenciaFamilia
                                        ).DefaultIfEmpty().Max(t => t == null ? 0 : t.Secuencia);

                                foreach (SS_HC_Anamnesis_AFAM_Enfermedad objDetalle in Detalle)
                                {
                                    if (mapSecuenciaFam.ContainsKey("" + objDetalle.SecuenciaFamilia)) 
                                    {
                                        int SecuenciaFamReal = mapSecuenciaFam["" + objDetalle.SecuenciaFamilia];
                                        if (objDetalle.Accion == "DETALLE")
                                        {
                                            contadorDet++;
                                            objDetalle.SecuenciaFamilia = SecuenciaFamReal;
                                            objDetalle.Secuencia = secuenciaMax + contadorDet;
                                            context.Entry(objDetalle).State = EntityState.Added;
                                        }
                                        else if (objDetalle.Accion == "UPDATEDETALLE")
                                        {
                                            context.Entry(objDetalle).State = EntityState.Modified;
                                        }
                                        else if (objDetalle.Accion == "DELETEDETALLE")
                                        {
                                            context.Entry(objDetalle).State = EntityState.Deleted;
                                        }
                                    }
                                    
                                }
                            }
                            /*******************************/

                            context.SaveChanges();
                            dbContextTransaction.Commit();
                        }
                    }
                    catch (Exception ex)
                    {
                        valorRetorno = 0;
                        dbContextTransaction.Rollback();
                        //throw ex;
                    }
                }
            }
            return valorRetorno;
        }

        public List<SS_HC_Anamnesis_AFAM> AnamnesisAFListar(SS_HC_Anamnesis_AFAM objSC)
        {
            try
            {
                dynamic DataKey = null;
                SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
                List<SS_HC_Anamnesis_AFAM> objLista = new List<SS_HC_Anamnesis_AFAM>();
                using (var context = new WEB_ERPSALUDEntities())
                {
                    List<SS_HC_Anamnesis_AFAM> objConsultas = (from t in context.SS_HC_Anamnesis_AFAM
                                                                  where
                                                                  t.UnidadReplicacion == objSC.UnidadReplicacion
                                                                  && t.IdPaciente == objSC.IdPaciente
                                                                  && t.EpisodioClinico == objSC.EpisodioClinico
                                                                  && t.IdEpisodioAtencion == objSC.IdEpisodioAtencion
                                                                  orderby t.IdEpisodioAtencion descending
                                                                  select t).ToList();



                    if (objConsultas != null)
                    {
                        objLista.AddRange(objConsultas);
                    }

                    DataKey = new
                    {
                        UnidadReplicacion = objSC.UnidadReplicacion,
                        IdPaciente = objSC.IdPaciente,
                        EpisodioClinico = objSC.EpisodioClinico,
                        IdEpisodioAtencion = objSC.IdEpisodioAtencion
                    };

                    String accionTemp = "V";
                    if (objLista.Count > 1) accionTemp = "L";

                    //String xlmIn = XMLString(objLista, new List<SS_HC_EvolucionObjetiva>(), "SS_HC_EvolucionObjetiva");//CAMBAIR DE CLASE
                    String xlmIn = "";
                    setAuditoriaListado(new SS_HC_Anamnesis_AFAM(), new SS_HC_Anamnesis_AFAM(), accionTemp,
                        "SS_HC_Anamnesis_AFAM", objAudit, DataKey, xlmIn);
                }
                return objLista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
