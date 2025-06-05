using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Data.Entity;

namespace SoluccionSalud.Repository.DALMedicamentos
{
    public class MedicamentosRepository : AuditGenerico<WH_ItemMast, WH_ItemMast> 
    {
        public List<WH_ItemMast> listarMedicamentos(WH_ItemMast objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            List<WH_ItemMast> objLista = new List<WH_ItemMast>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista= context.USP_WH_ItemMastListar(objSC.Item,objSC.ItemTipo,objSC.Linea, objSC.Familia,
                objSC.SubFamilia,objSC.SubFamiliaInferior,objSC.DescripcionLocal,objSC.DescripcionIngles,objSC.DescripcionCompleta,
                objSC.NumeroDeParte,objSC.CodigoInterno,objSC.UnidadCodigo,objSC.UnidadCompra,objSC.UnidadEmbalaje,objSC.Color,
                objSC.Modelo,objSC.MarcaCodigo,objSC.ItemProcedencia,objSC.ClasificacionComercial,objSC.PartidaArancelaria,objSC.CodigoBarras,
                objSC.CodigoBarrasFabricante,objSC.CodigoBarras2,objSC.MonedaCodigo,objSC.PrecioCosto,objSC.PrecioUnitarioLocal,objSC.PrecioUnitarioDolares,
                objSC.ItemPrecioFlag,objSC.ItemPrecioCodigo,objSC.DisponibleVentaFlag,objSC.ManejoxLoteFlag,objSC.ManejoxSerieFlag,objSC.ManejoxKitFlag,
                objSC.ManejoxKitSplitFlag,objSC.ManejoxUnidadFlag,objSC.AfectoImpuestoVentasFlag,objSC.AfectoImpuesto2Flag,objSC.RequisicionamientoAutomaticoFl,
                objSC.ControlCalidadFlag,objSC.DisponibleTransferenciaFlag,objSC.DisponibleConsumoFlag,objSC.FormularioFlag,objSC.FormularioNroJuegos,
                objSC.ISOAplicableFlag,objSC.ISONormaInterna,objSC.CantidadDobleFlag,objSC.CantidadDobleFactor,objSC.UnidadCodigoDoble,objSC.UnidadReplicacion,
                objSC.ImageFile,objSC.MapaFile,objSC.CuentaInventario,objSC.CuentaGasto,objSC.CuentaInversion,objSC.CuentaServicioTecnico,objSC.CuentaSalidaTerceros,
                objSC.CuentaVentas,objSC.CuentaTransito,objSC.ElementoGasto,objSC.ElementoInversion,objSC.PartidaPresupuestal,objSC.FlujodeCaja,
                objSC.LotedeCompra,objSC.LotedeDespacho,objSC.LotedeCompraM3,objSC.LotedeCompraKG,objSC.PeriodicidadCompraMeses,objSC.EspecificacionTecnica,
                objSC.Dimensiones,objSC.FactorEquivalenciaComercial,objSC.ABCCodigo,objSC.InventarioTolerancia,objSC.StockMinimo,objSC.StockMaximo,
                objSC.LotedeVenta,objSC.DescripcionAdicional,objSC.CodigoPrecio,objSC.CaracteristicaValor01,objSC.CaracteristicaValor02,objSC.CaracteristicaValor03,
                objSC.CaracteristicaValor04,objSC.CaracteristicaValor05,objSC.ReferenciaFiscal02,objSC.ReferenciaFiscalIngreso02,objSC.DetraccionCodigo,
                objSC.Estado,objSC.PeriodicidadCompra,objSC.UltimaFechaModif,objSC.UltimoUsuario,objSC.Centrocosto,objSC.ConceptoGasto,objSC.ClasificadorMovimiento,
                objSC.FlujodeCajaIngreso,objSC.MapaCodigo,objSC.paisfabricacion,objSC.ABCCodigoIN,objSC.Lectura,objSC.IdGrupoComponente,objSC.IdRegimenVenta,
                objSC.IndicadorReemplazo,objSC.UsuarioCreacion,objSC.FechaCreacion,objSC.CuentaVentaComercial,objSC.CuentaDescuentoVentaComercial,objSC.IndicadorCuentaVenta,
                objSC.TipoRepuesto,objSC.Cantidadkit,objSC.PeriodoInicioReposicion,objSC.PeriodosReposicion,objSC.IndicadorClasificacion,objSC.PeridoInicioReposicion,
                objSC.IdClasificacion,objSC.cantidadReposicion,objSC.grupoReposicion,objSC.IndicadorReposicion,objSC.IndicadorPrecioManual,
                objSC.IndicadorConsumoFraccionado,objSC.nombreLaboratorio,objSC.estadoAnterior,objSC.CuentaCompras,objSC.PrecioCostoAnt,objSC.UltimaOC,
                objSC.PreviaOC,objSC.tipomedicamento,objSC.CodigoDigemid,objSC.EAN13,objSC.MedicamentoCodigo,objSC.MedicamentoCodigoPadre,
                objSC.NombreTabla,objSC.tipofolder,objSC.Accion
                                    , inicio
                                    , final).ToList();
                DataKey = new
                {
                    Item = objSC.Item                    
                };
                // Audit
                String xlmIn = XMLString(objLista, new List<WH_ItemMast>(), "WH_ItemMast");
                objAudit = AddAudita(new WH_ItemMast(), objSC, DataKey, "L");
                objAudit.TableName = "WH_ItemMast";
                objAudit.Type = "L";
                objAudit.Accion = "INSERT";
                objAudit.VistaData = xlmIn;
                context.Entry(objAudit).State = EntityState.Added;
                context.SaveChanges();
            }
            return objLista;
        }
        public int setMantenimiento(WH_ItemMast objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_WH_ItemMast_mantenimiento(objSC.Item, objSC.ItemTipo, objSC.Linea, objSC.Familia,
                objSC.SubFamilia, objSC.SubFamiliaInferior, objSC.DescripcionLocal, objSC.DescripcionIngles, objSC.DescripcionCompleta,
                objSC.NumeroDeParte, objSC.CodigoInterno, objSC.UnidadCodigo, objSC.UnidadCompra, objSC.UnidadEmbalaje, objSC.Color,
                objSC.Modelo, objSC.MarcaCodigo, objSC.ItemProcedencia, objSC.ClasificacionComercial, objSC.PartidaArancelaria, objSC.CodigoBarras,
                objSC.CodigoBarrasFabricante, objSC.CodigoBarras2, objSC.MonedaCodigo, objSC.PrecioCosto, objSC.PrecioUnitarioLocal, objSC.PrecioUnitarioDolares,
                objSC.ItemPrecioFlag, objSC.ItemPrecioCodigo, objSC.DisponibleVentaFlag, objSC.ManejoxLoteFlag, objSC.ManejoxSerieFlag, objSC.ManejoxKitFlag,
                objSC.ManejoxKitSplitFlag, objSC.ManejoxUnidadFlag, objSC.AfectoImpuestoVentasFlag, objSC.AfectoImpuesto2Flag, objSC.RequisicionamientoAutomaticoFl,
                objSC.ControlCalidadFlag, objSC.DisponibleTransferenciaFlag, objSC.DisponibleConsumoFlag, objSC.FormularioFlag, objSC.FormularioNroJuegos,
                objSC.ISOAplicableFlag, objSC.ISONormaInterna, objSC.CantidadDobleFlag, objSC.CantidadDobleFactor, objSC.UnidadCodigoDoble, objSC.UnidadReplicacion,
                objSC.ImageFile, objSC.MapaFile, objSC.CuentaInventario, objSC.CuentaGasto, objSC.CuentaInversion, objSC.CuentaServicioTecnico, objSC.CuentaSalidaTerceros,
                objSC.CuentaVentas, objSC.CuentaTransito, objSC.ElementoGasto, objSC.ElementoInversion, objSC.PartidaPresupuestal, objSC.FlujodeCaja,
                objSC.LotedeCompra, objSC.LotedeDespacho, objSC.LotedeCompraM3, objSC.LotedeCompraKG, objSC.PeriodicidadCompraMeses, objSC.EspecificacionTecnica,
                objSC.Dimensiones, objSC.FactorEquivalenciaComercial, objSC.ABCCodigo, objSC.InventarioTolerancia, objSC.StockMinimo, objSC.StockMaximo,
                objSC.LotedeVenta, objSC.DescripcionAdicional, objSC.CodigoPrecio, objSC.CaracteristicaValor01, objSC.CaracteristicaValor02, objSC.CaracteristicaValor03,
                objSC.CaracteristicaValor04, objSC.CaracteristicaValor05, objSC.ReferenciaFiscal02, objSC.ReferenciaFiscalIngreso02, objSC.DetraccionCodigo,
                objSC.Estado, objSC.PeriodicidadCompra, objSC.UltimaFechaModif, objSC.UltimoUsuario, objSC.Centrocosto, objSC.ConceptoGasto, objSC.ClasificadorMovimiento,
                objSC.FlujodeCajaIngreso, objSC.MapaCodigo, objSC.paisfabricacion, objSC.ABCCodigoIN, objSC.Lectura, objSC.IdGrupoComponente, objSC.IdRegimenVenta,
                objSC.IndicadorReemplazo, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.CuentaVentaComercial, objSC.CuentaDescuentoVentaComercial, objSC.IndicadorCuentaVenta,
                objSC.TipoRepuesto, objSC.Cantidadkit, objSC.PeriodoInicioReposicion, objSC.PeriodosReposicion, objSC.IndicadorClasificacion, objSC.PeridoInicioReposicion,
                objSC.IdClasificacion, objSC.cantidadReposicion, objSC.grupoReposicion, objSC.IndicadorReposicion, objSC.IndicadorPrecioManual,
                objSC.IndicadorConsumoFraccionado, objSC.nombreLaboratorio, objSC.estadoAnterior, objSC.CuentaCompras, objSC.PrecioCostoAnt, objSC.UltimaOC,
                objSC.PreviaOC, objSC.tipomedicamento, objSC.CodigoDigemid, objSC.EAN13, objSC.MedicamentoCodigo, objSC.MedicamentoCodigoPadre,
                objSC.NombreTabla, objSC.tipofolder, objSC.Accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
