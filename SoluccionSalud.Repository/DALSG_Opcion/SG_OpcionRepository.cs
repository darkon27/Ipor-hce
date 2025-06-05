using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;


namespace SoluccionSalud.Repository.DALSG_Opcion
{
    public class SG_OpcionRepository : AuditGenerico<SG_Opcion, SG_Opcion> 
    {
        public List<SG_Opcion> listarSG_Opcion(SG_Opcion objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<SG_Opcion> objLista = new List<SG_Opcion>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_SG_Opcion_LISTAR(
                    objSC.IdOpcion
                    ,objSC.IdOpcionPadre
                    ,objSC.CodigoOpcion
                    ,objSC.CadenaRecursividad
                    ,objSC.NivelOpcion
                    ,objSC.Nombre
                    ,objSC.Descripcion
                    ,objSC.Sistema
                    ,objSC.Modulo
                    ,objSC.SubModulo
                    ,objSC.Orden
                    ,objSC.TipoOpcion
                    ,objSC.TipoIcono
                    ,objSC.IndicadorPrioridad
                    ,objSC.IndicadorObjeto
                    ,objSC.IdObjetoAsociado
                    ,objSC.TipoDato
                    ,objSC.ValorTexto
                    ,objSC.ValorNumerico
                    ,objSC.ValorFecha
                    ,objSC.UrlOpcion
                    ,objSC.UsuarioCreacion
                    ,objSC.FechaCreacion
                    ,objSC.UsuarioModificacion
                    ,objSC.FechaModificacion
                    ,objSC.Compania
                    ,objSC.IndicadorCompania
                    ,objSC.idTipoAtencion
                    ,objSC.TipoTrabajador
                    ,objSC.IndicadorFormato
                    ,objSC.IdFormato
                    ,objSC.IndicadorAsignacion
                    ,objSC.TipoProceso                    
                    ,objSC.Version
                    ,objSC.Estado
                    , inicio, final
                    , objSC.Accion
                    ).ToList();
                DataKey = new
                {
                    IdOpcion = objSC.IdOpcion,
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<SG_Opcion>(), "SG_Opcion");
                objAudit = AddAudita(new SG_Opcion(), objSC, DataKey, "L");
                objAudit.TableName = "SG_Opcion";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }

        public int setMantenimiento(SG_Opcion objSC)
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
                        SG_Opcion objAnterior = new SG_Opcion();
                        if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                        {
                            objAnterior = (from t in context.SG_Opcion
                                           where t.IdOpcion == objSC.IdOpcion
                                           orderby t.IdOpcion descending
                                           select t).SingleOrDefault();
                        }
                        iReturnValue = context.USP_SS_HC_SG_Opcion(
                   objSC.IdOpcion
                   , objSC.IdOpcionPadre
                   , objSC.CodigoOpcion
                   , objSC.CadenaRecursividad
                   , objSC.NivelOpcion
                   , objSC.Nombre
                   , objSC.Descripcion
                   , objSC.Sistema
                   , objSC.Modulo
                   , objSC.SubModulo
                   , objSC.Orden
                   , objSC.TipoOpcion
                   , objSC.TipoIcono
                   , objSC.IndicadorPrioridad
                   , objSC.IndicadorObjeto
                   , objSC.IdObjetoAsociado
                   , objSC.TipoDato
                   , objSC.ValorTexto
                   , objSC.ValorNumerico
                   , objSC.ValorFecha
                   , objSC.UrlOpcion
                   , objSC.UsuarioCreacion
                   , objSC.FechaCreacion
                   , objSC.UsuarioModificacion
                   , objSC.FechaModificacion
                   , objSC.Compania
                   , objSC.IndicadorCompania
                   , objSC.idTipoAtencion
                   , objSC.TipoTrabajador
                   , objSC.IndicadorFormato
                   , objSC.IdFormato
                   , objSC.IndicadorAsignacion
                   , objSC.TipoProceso
                   , objSC.Version
                   , objSC.Estado
                   , objSC.Accion
                    ).SingleOrDefault();
                        DataKey = new
                        {
                            IdOpcion = objSC.IdOpcion,
                        };
                        if (objAnterior == null) objAnterior = new SG_Opcion();
                        objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                        objAudit.TableName = "SG_Opcion";
                        objAudit.Type = objSC.Accion.Substring(0, 1);
                        if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                        {
                            if (objAudit.Type != "L")
                            {
                                context.Entry(objAudit).State = EntityState.Added;
                                context.SaveChanges();
                            }
                        }

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


        public int setMantenimiento(List<SG_Opcion> listaObjSC)
        {
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            dynamic DataKey;
            List<int> indicesAuxiliares = new List<int>();
            Dictionary<String, Nullable<int>> dataIndicesAuxiliares = new Dictionary<String, Nullable<int>>();
            System.Nullable<int> iReturnValue =0;
            System.Nullable<int> idPadreAux = null;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        if (listaObjSC != null)
                        {
                            foreach (SG_Opcion objSC in listaObjSC)
                            {
                                SG_Opcion objAnterior = new SG_Opcion();
                                if ((objSC.Accion.Substring(0, 1) != "I") || (objSC.Accion.Substring(0, 1) != "N"))
                                {
                                    objAnterior = (from t in context.SG_Opcion
                                                   where t.IdOpcion == objSC.IdOpcion
                                                   orderby t.IdOpcion descending
                                                   select t).SingleOrDefault();
                                }
                                if (objSC.IdOpcionPadre!=null)
                                {
                                    idPadreAux = (Math.Abs(Convert.ToInt32(objSC.IdOpcionPadre)));
                                }
                                
                                iReturnValue = context.USP_SS_HC_SG_Opcion(
                                       objSC.IdOpcion
                                       , idPadreAux
                                       , objSC.CodigoOpcion
                                       , objSC.CadenaRecursividad
                                       , objSC.NivelOpcion
                                       , objSC.Nombre
                                       , objSC.Descripcion
                                       , objSC.Sistema
                                       , objSC.Modulo
                                       , objSC.SubModulo
                                       , objSC.Orden
                                       , objSC.TipoOpcion
                                       , objSC.TipoIcono
                                       , objSC.IndicadorPrioridad
                                       , objSC.IndicadorObjeto
                                       , objSC.IdObjetoAsociado
                                       , objSC.TipoDato
                                       , objSC.ValorTexto
                                       , objSC.ValorNumerico
                                       , objSC.ValorFecha
                                       , objSC.UrlOpcion
                                       , objSC.UsuarioCreacion
                                       , objSC.FechaCreacion
                                       , objSC.UsuarioModificacion
                                       , objSC.FechaModificacion
                                       , objSC.Compania
                                       , objSC.IndicadorCompania
                                       , objSC.idTipoAtencion
                                       , objSC.TipoTrabajador
                                       , objSC.IndicadorFormato
                                       , objSC.IdFormato
                                       , objSC.IndicadorAsignacion
                                       , objSC.TipoProceso
                                       , objSC.Version
                                       , objSC.Estado
                                       , objSC.Accion
                                        ).SingleOrDefault();

                                if (iReturnValue != 0 && objSC.IdOpcionPadre < 0)
                                {
                                    indicesAuxiliares.Add(Convert.ToInt32(iReturnValue));
                                    dataIndicesAuxiliares["" + objSC.IdOpcion] = iReturnValue;
                                }

                                /***AUDITORíA****/
                                DataKey = new
                                {
                                    IdOpcion = objSC.IdOpcion,
                                };
                                if (objAnterior == null) objAnterior = new SG_Opcion();
                                objAudit = AddAudita(objAnterior, objSC, DataKey, objSC.Accion.Substring(0, 1));
                                objAudit.TableName = "SG_Opcion";
                                objAudit.Type = objSC.Accion.Substring(0, 1);
                                if (((objAudit.OldData.Trim().Length != 0) || (objAudit.NewData.Trim().Length != 0)) || (objAudit.Type == "D"))
                                {
                                    if (objAudit.Type != "L")
                                    {
                                        context.Entry(objAudit).State = EntityState.Added;
                                        context.SaveChanges();
                                    }
                                }
                                /***********/
                            }
                            /**operaciones extras : ACTUALIZAR PADRE*/
                            if (indicesAuxiliares.Count > 0)
                            {
                                foreach (int idAux in indicesAuxiliares)
                                {
                                    //int idAux = indicesAuxiliares[0];
                                    SG_Opcion obsTrans = (from t in context.SG_Opcion
                                                          where t.IdOpcion == idAux
                                                          orderby t.IdOpcion descending
                                                          select t).SingleOrDefault();
                                    if (obsTrans != null)
                                    {
                                        obsTrans.IdOpcionPadre = Math.Abs(Convert.ToInt32(obsTrans.IdOpcionPadre));
                                        if (dataIndicesAuxiliares.ContainsKey("" + obsTrans.IdOpcionPadre))
                                        {
                                            Nullable<int> dataAux = dataIndicesAuxiliares["" + obsTrans.IdOpcionPadre];
                                            if (dataAux != null)
                                            {
                                                obsTrans.IdOpcionPadre = dataAux;
                                            }
                                        }
                                        context.Entry(obsTrans).State = EntityState.Modified;                                   
                                    }
                                }
                                context.SaveChanges();
                            }
                            /*********************/
                            valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                        }
                        
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
