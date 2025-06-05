using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.RepositoryReport;
using SoluccionSalud.Model;
using System.Data.Entity.Validation;
using System.Diagnostics;

namespace SoluccionSalud.Repository.DALSeguridadConcepto
{
    public class SeguridadConceptoRepository 
    {
              public List<SS_CHE_VistaSeguridad> ListarSeguridadOpcion(SS_CHE_VistaSeguridad objSC, int inicio, int final)
        {
            SS_HC_ImpresionHC objAudit = new SS_HC_ImpresionHC();
            dynamic DataKey;

            

            try
            {
                using (var context = new SoluccionSalud.Model.WEB_ERPSALUDEntities())
                {
                    //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                    return context.USP_SS_GE_SeguridadOpcion(objSC.Sistema,	objSC.Nombre,	objSC.Modulo,	objSC.Orden,	
                        objSC.NombreModulo,	objSC.IdOpcion,	objSC.IdOpcionPadre,	objSC.CodigoOpcion,	
                        objSC.CadenaRecursividad,	objSC.NivelOpcion,	objSC.NombreOpcion,	objSC.Descripcion,	
                        objSC.SubModulo,	objSC.OrdenOpcion,	objSC.TipoOpcion,	objSC.TipoIcono,	objSC.IndicadorPrioridad,	
                        objSC.IndicadorObjeto,	objSC.IdObjetoAsociado,	objSC.TipoDato,	objSC.Compania,	
                        objSC.IndicadorCompania,	objSC.idTipoAtencion,	objSC.TipoTrabajador,	
                        objSC.IndicadorFormato,	objSC.IndicadorAsignacion,	objSC.TipoProceso,	objSC.Accion,	
                        objSC.Version,	objSC.Estado,	objSC.IdAgente,	objSC.IdGrupo,	objSC.IdOrganizacion,	
                        objSC.TipoAgente,	objSC.CodigoAgente,	objSC.IdEmpleado,	objSC.IndicadorMultiple,	
                        objSC.Clave,	objSC.NombreAgente,	objSC.EstadoAgente,	objSC.Plataforma,	
                        objSC.EstadoAgenteOpcion,	objSC.IdFormato,	objSC.IdFormatoPadre,	
                        objSC.CodigoFormato,	objSC.Nivel,	objSC.TipoFormato,	objSC.VersionFormatoFijo,	
                        objSC.IdFormatoDinamico,	objSC.EstadoFormato).ToList();


                         
                }
            }
            catch (DbEntityValidationException ex)
            {
                LogValidationErrors.LogError(ex);
                throw;
            }
        }

        public List<SEGURIDADCONCEPTO> listarSeguridadConcepto(SEGURIDADCONCEPTO objSC, int inicio, int final)
        {
            try
            {
                using (var context = new SoluccionSalud.Model.WEB_ERPSALUDEntities())
                {
                    //NUMEROLOGINSDISPONIBLE y NUMEROLOGINSUSADOS usados auxiliarmente como inicio y fin.
                    return context.USP_SEGURIDADCONCEPTOLISTAR(objSC.APLICACIONCODIGO, objSC.GRUPO,
                        objSC.CONCEPTO,objSC.CONCEPTOPADRE,objSC.IDPAGINA, objSC.DESCRIPCION, 
                        objSC.DESCRIPCIONINGLES,objSC.VISIBLEFLAG,objSC.TIPODEDETALLE,
                        objSC.TIPODEOBJETO,objSC.OBJETO,objSC.TIPODEACCESO,objSC.OBJETOWINDOW,
                        objSC.WORKFLAG,objSC.WORKAGREGARFLAG,objSC.WORKMODIFICARFLAG,objSC.WORKBORRARFLAG,
                        objSC.WORKAPROBARFLAG,objSC.WEBFLAG,objSC.WEBPAGE,objSC.WEBACTION,
                        objSC.WEBGRUPO,objSC.WEBGRUPOSECUENCIA,
                        objSC.ULTIMOUSUARIO, objSC.ULTIMAFECHAMODIF, objSC.ESTADO, objSC.ACCION, inicio, final
                        ).ToList();
                }
            }
            catch (DbEntityValidationException ex)
            {
                LogValidationErrors.LogError(ex);
                throw;
            }
        }

        public int setMantenimiento(SEGURIDADCONCEPTO objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            try
            {
                using (var context = new SoluccionSalud.Model.WEB_ERPSALUDEntities())
                {
                    iReturnValue = context.USP_SEGURIDADCONCEPTOMANTENIMIENTO(objSC.APLICACIONCODIGO, objSC.GRUPO,
                        objSC.CONCEPTO, objSC.CONCEPTOPADRE, objSC.IDPAGINA, objSC.DESCRIPCION,
                        objSC.DESCRIPCIONINGLES, objSC.VISIBLEFLAG, objSC.TIPODEDETALLE,
                        objSC.TIPODEOBJETO, objSC.OBJETO, objSC.TIPODEACCESO, objSC.OBJETOWINDOW,
                        objSC.WORKFLAG, objSC.WORKAGREGARFLAG, objSC.WORKMODIFICARFLAG, objSC.WORKBORRARFLAG,
                        objSC.WORKAPROBARFLAG, objSC.WEBFLAG, objSC.WEBPAGE, objSC.WEBACTION,
                        objSC.WEBGRUPO, objSC.WEBGRUPOSECUENCIA,
                        objSC.ULTIMOUSUARIO, objSC.ULTIMAFECHAMODIF, objSC.ESTADO, objSC.ACCION).SingleOrDefault();
                    valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
                }
            }
            catch (DbEntityValidationException ex)
            {
                LogValidationErrors.LogError(ex);
                throw;
            }
            return valorRetorno;
        }
    }
}
