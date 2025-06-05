using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;

using System.Data.Entity;


namespace SoluccionSalud.Repository.DALTABLAFORMATOVALIDACION
{
    public class VW_TABLAFORMATOVALIDACIONRepository : AuditGenerico<VW_SS_HC_TABLAFORMATO_VALIDACION, VW_SS_HC_TABLAFORMATO_VALIDACION> 
    {
        public List<VW_SS_HC_TABLAFORMATO_VALIDACION> listarVWTABLAFORMATOVALIDACION(VW_SS_HC_TABLAFORMATO_VALIDACION objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<VW_SS_HC_TABLAFORMATO_VALIDACION> objLista = new List<VW_SS_HC_TABLAFORMATO_VALIDACION>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.USP_SS_HC_VW_TABLAFORMATO_VALIDACION_LISTAR(
                  objSC.IdFormato
                  ,objSC.FormatoNivelID
                  ,objSC.IdFormatoPadre
                  ,objSC.CodigoFormato
                  ,objSC.CodigoFormatoPadre
                  ,objSC.DescripcionFormato
                  ,objSC.TipoFormato
                  ,objSC.EstadoFormato
                  ,objSC.IdFavoritoTabla
                  ,objSC.NombreTabla
                  ,objSC.DescripcionTabla
                  ,objSC.TipoTabla
                  ,objSC.EstadoTabla
                  ,objSC.IdCampo
                  ,objSC.NombreCampo
                  ,objSC.DescripcionCampo
                  ,objSC.TipoCampo
                  ,objSC.Longitud
                  ,objSC.Decimales
                  ,objSC.EstadoTablaCampo
                  ,objSC.SecuenciaCampo
                  ,objSC.IdSeccionFormato
                  ,objSC.ValorPorDefecto
                  ,objSC.IndicadorObligatorio
                  ,objSC.IndicadorCampoCalculado
                  ,objSC.Formula
                  ,objSC.IndicadorValoresVarios
                  ,objSC.TablaValoresVarios
                  ,objSC.IndicadorRango
                  ,objSC.RangoDesde
                  ,objSC.RangoHasta
                  ,objSC.IndicadorReglaNegocio
                  ,objSC.ReglaNegocio
                  ,objSC.Observaciones
                  ,objSC.EstadoFormatoCampo
                  ,objSC.IdConcepto
                  ,objSC.IdAgrupadorNivel
                  ,objSC.IdObjetoAgrupador
                  ,objSC.IdColumna
                  ,objSC.IdFila
                  ,objSC.IdEvento
                  ,objSC.IdParameterEnvio
                  ,objSC.Orden
                  ,objSC.IdAgrupadorNivelPadre
                  ,objSC.SecuenciaValidacion
                  ,objSC.IdComponente
                  ,objSC.IdAtributo
                  ,objSC.TipoValidacion
                  ,objSC.FlagTipoDato
                  ,objSC.ValorTexto
                  ,objSC.ValorNumerico
                  ,objSC.ValorDate
                  ,objSC.SecuenciaValidacionRef
                  ,objSC.EstadoValidacion
                  ,objSC.UsuarioCreacion
                  ,objSC.FechaCreacion
                  ,objSC.UsuarioModificacion
                  ,objSC.FechaModificacion
                  ,objSC.Version
                  ,objSC.NombreComponente
                  ,objSC.TipoComponente
                  ,objSC.EstadoComponente
                  ,objSC.NombreAtributo
                  ,objSC.EstadoAtributo
                  ,objSC.IdiomaProperty
                    ,inicio
                    ,final
                    ,objSC.Accion
                ).ToList();

                // Audit
                if (objSC.Accion ==  "LISTARPAGVALIDACION")
                {
                    DataKey = new
                    {
                        IdFormato = objSC.IdFormato,
                        SecuenciaCampo = objSC.SecuenciaCampo,
                        SecuenciaValidacion = objSC.SecuenciaValidacion
                    };

                    String xlmIn = XMLString(objLista, new List<VW_SS_HC_TABLAFORMATO_VALIDACION>(), "VW_SS_HC_TABLAFORMATO_VALIDACION");
                    objAudit = AddAudita(new VW_SS_HC_TABLAFORMATO_VALIDACION(), new VW_SS_HC_TABLAFORMATO_VALIDACION(), DataKey, "L");
                    objAudit.TableName = "VW_SS_HC_TABLAFORMATO_VALIDACION";
                    objAudit.Type = "L";
                    objAudit.Accion = "INSERT";
                    objAudit.VistaData = xlmIn;
                    context.Entry(objAudit).State = EntityState.Added;
                    context.SaveChanges();
                }
            }

            return objLista;
        }


        public int setMantenimiento(VW_SS_HC_TABLAFORMATO_VALIDACION objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_VW_TABLAFORMATO_VALIDACION(
                    objSC.IdFormato
                  , objSC.FormatoNivelID
                  , objSC.IdFormatoPadre
                  , objSC.CodigoFormato
                  , objSC.CodigoFormatoPadre
                  , objSC.DescripcionFormato
                  , objSC.TipoFormato
                  , objSC.EstadoFormato
                  , objSC.IdFavoritoTabla
                  , objSC.NombreTabla
                  , objSC.DescripcionTabla
                  , objSC.TipoTabla
                  , objSC.EstadoTabla
                  , objSC.IdCampo
                  , objSC.NombreCampo
                  , objSC.DescripcionCampo
                  , objSC.TipoCampo
                  , objSC.Longitud
                  , objSC.Decimales
                  , objSC.EstadoTablaCampo
                  , objSC.SecuenciaCampo
                  , objSC.IdSeccionFormato
                  , objSC.ValorPorDefecto
                  , objSC.IndicadorObligatorio
                  , objSC.IndicadorCampoCalculado
                  , objSC.Formula
                  , objSC.IndicadorValoresVarios
                  , objSC.TablaValoresVarios
                  , objSC.IndicadorRango
                  , objSC.RangoDesde
                  , objSC.RangoHasta
                  , objSC.IndicadorReglaNegocio
                  , objSC.ReglaNegocio
                  , objSC.Observaciones
                  , objSC.EstadoFormatoCampo
                  , objSC.IdConcepto
                  , objSC.IdAgrupadorNivel
                  , objSC.IdObjetoAgrupador
                  , objSC.IdColumna
                  , objSC.IdFila
                  , objSC.IdEvento
                  , objSC.IdParameterEnvio
                  , objSC.Orden
                  , objSC.IdAgrupadorNivelPadre
                  , objSC.SecuenciaValidacion
                  , objSC.IdComponente
                  , objSC.IdAtributo
                  , objSC.TipoValidacion
                  , objSC.FlagTipoDato
                  , objSC.ValorTexto
                  , objSC.ValorNumerico
                  , objSC.ValorDate
                  , objSC.SecuenciaValidacionRef
                  , objSC.EstadoValidacion
                  , objSC.UsuarioCreacion
                  , objSC.FechaCreacion
                  , objSC.UsuarioModificacion
                  , objSC.FechaModificacion
                  , objSC.Version
                  , objSC.NombreComponente
                  , objSC.TipoComponente
                  , objSC.EstadoComponente
                  , objSC.NombreAtributo
                  , objSC.EstadoAtributo
                  , objSC.IdiomaProperty
                    , 0
                    , 0
                    , objSC.Accion
                ).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
