using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALFormularios
{
     public class AnamnesisAPRepository : GenericDataRepository<SS_HC_Anamnesis_AP>, IAnamnesisAPRepository
    {
         public int setMantAnamnesisAP(SS_HC_Anamnesis_AP ObjTrace)
         {
             System.Nullable<int> iReturnValue;
             int valorRetorno = 0;
             using (var context = new WEB_ERPSALUDEntities())
             {
                 iReturnValue = context.USP_ANAMNESIS_AP(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                     ObjTrace.IdTipoEmbarazo,
                     ObjTrace.PatologiaGestacion, ObjTrace.IdControlPrenatal, ObjTrace.CPnumeroControles, ObjTrace.CPnumeroEmbarazos, ObjTrace.LugarControl,
                     ObjTrace.IdTipoParto, ObjTrace.ComplicacionesParto, ObjTrace.IdLugarParto, ObjTrace.IdPartoAtendidoPor, ObjTrace.AntecentesPatologicos,
                     ObjTrace.SemanasGestacionNacer, ObjTrace.PesoAlNacerGR, ObjTrace.TallaAlNacerCM, ObjTrace.PerimetroCefalicoCM, ObjTrace.PatologiasPernatales,
                     ObjTrace.DiasHospitalizacion, ObjTrace.IdTipoLecheHasta6meses, ObjTrace.AntecLactancia, ObjTrace.EdadInicioAblactanciaMeses,
                     ObjTrace.DesarrolloSicomotriz, ObjTrace.FechaUltimaRegla, ObjTrace.FechaUltimoPeriodo, ObjTrace.MetodosAnticonceptivos,
                     ObjTrace.Menarquia, ObjTrace.Menopausia, ObjTrace.CaracteristicasMenstruaciones, ObjTrace.InformacionEmbarazos, ObjTrace.Transfusiones,
                     ObjTrace.DeinmunizFechaAproximada, ObjTrace.DeinmunizEdadAproximada, ObjTrace.Alcohol, ObjTrace.Tabaco, ObjTrace.Drogas,
                     ObjTrace.ActividadFisica, ObjTrace.ConsumoVerduras, ObjTrace.ConsumoFrutas, ObjTrace.Medicamentos, ObjTrace.Alimentos,
                     ObjTrace.SustanciasEnElAmbiente, ObjTrace.SustanciasContactoConPiel, ObjTrace.ContactoPersonaEnferma, ObjTrace.CrianzaAnimalesDomesticos,
                     ObjTrace.AguaPotable, ObjTrace.DisposicionExcretas, ObjTrace.ReaccionAdversaMedicamentos, ObjTrace.SaludBucal, ObjTrace.VigilanciaDeCrecimiento,
                     ObjTrace.VigilanciaDelDesarrollo, ObjTrace.IdValoracionFuncional1, ObjTrace.IdValoracionFuncional2, ObjTrace.IdValoracionFuncional3,
                     ObjTrace.IdValoracionFuncional4, ObjTrace.IdValoracionFuncional5, ObjTrace.IdValoracionFuncional6, ObjTrace.DiagnosticoFuncional,
                     ObjTrace.IdEstadoCognitivo1, ObjTrace.IdEstadoCognitivo2, ObjTrace.IdEstadoCognitivo3, ObjTrace.IdEstadoCognitivo4,
                     ObjTrace.IdEstadoCognitivo5, ObjTrace.IdEstadoCognitivo6, ObjTrace.IdEstadoCognitivo7, ObjTrace.IdEstadoCognitivo8, ObjTrace.IdEstadoCognitivo9,
                     ObjTrace.IdEstadoCognitivo10, ObjTrace.ValoracionCognitiva, ObjTrace.IdEstadoAfectivo1, ObjTrace.IdEstadoAfectivo2, ObjTrace.IdEstadoAfectivo3,
                     ObjTrace.IdEstadoAfectivo4, ObjTrace.ConManifestacionesDepresivas, ObjTrace.ValoracionSocioFamiliar1, ObjTrace.ValoracionSocioFamiliar2,
                     ObjTrace.ValoracionSocioFamiliar3, ObjTrace.ValoracionSocioFamiliar4, ObjTrace.ValoracionSocioFamiliar5, ObjTrace.ValoracionSocioFamiliar,
                     ObjTrace.IdCategoriaAdutoMayor, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                     ObjTrace.FechaModificacion, ObjTrace.Accion).SingleOrDefault();
                 valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
             }
             return valorRetorno;
         }
         public List<SS_HC_Anamnesis_AP> AnamnesisAP_Listar(SS_HC_Anamnesis_AP ObjTrace)
         {
             using (var context = new WEB_ERPSALUDEntities())
             {
                  return context.USP_Anamnesis_AP_Listar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                     ObjTrace.IdTipoEmbarazo,
                     ObjTrace.PatologiaGestacion, ObjTrace.IdControlPrenatal, ObjTrace.CPnumeroControles, ObjTrace.CPnumeroEmbarazos, ObjTrace.LugarControl,
                     ObjTrace.IdTipoParto, ObjTrace.ComplicacionesParto, ObjTrace.IdLugarParto, ObjTrace.IdPartoAtendidoPor, ObjTrace.AntecentesPatologicos,
                     ObjTrace.SemanasGestacionNacer, ObjTrace.PesoAlNacerGR, ObjTrace.TallaAlNacerCM, ObjTrace.PerimetroCefalicoCM, ObjTrace.PatologiasPernatales,
                     ObjTrace.DiasHospitalizacion, ObjTrace.IdTipoLecheHasta6meses, ObjTrace.AntecLactancia, ObjTrace.EdadInicioAblactanciaMeses,
                     ObjTrace.DesarrolloSicomotriz, ObjTrace.FechaUltimaRegla, ObjTrace.FechaUltimoPeriodo, ObjTrace.MetodosAnticonceptivos,
                     ObjTrace.Menarquia, ObjTrace.Menopausia, ObjTrace.CaracteristicasMenstruaciones, ObjTrace.InformacionEmbarazos, ObjTrace.Transfusiones,
                     ObjTrace.DeinmunizFechaAproximada, ObjTrace.DeinmunizEdadAproximada, ObjTrace.Alcohol, ObjTrace.Tabaco, ObjTrace.Drogas,
                     ObjTrace.ActividadFisica, ObjTrace.ConsumoVerduras, ObjTrace.ConsumoFrutas, ObjTrace.Medicamentos, ObjTrace.Alimentos,
                     ObjTrace.SustanciasEnElAmbiente, ObjTrace.SustanciasContactoConPiel, ObjTrace.ContactoPersonaEnferma, ObjTrace.CrianzaAnimalesDomesticos,
                     ObjTrace.AguaPotable, ObjTrace.DisposicionExcretas, ObjTrace.ReaccionAdversaMedicamentos, ObjTrace.SaludBucal, ObjTrace.VigilanciaDeCrecimiento,
                     ObjTrace.VigilanciaDelDesarrollo, ObjTrace.IdValoracionFuncional1, ObjTrace.IdValoracionFuncional2, ObjTrace.IdValoracionFuncional3,
                     ObjTrace.IdValoracionFuncional4, ObjTrace.IdValoracionFuncional5, ObjTrace.IdValoracionFuncional6, ObjTrace.DiagnosticoFuncional,
                     ObjTrace.IdEstadoCognitivo1, ObjTrace.IdEstadoCognitivo2, ObjTrace.IdEstadoCognitivo3, ObjTrace.IdEstadoCognitivo4,
                     ObjTrace.IdEstadoCognitivo5, ObjTrace.IdEstadoCognitivo6, ObjTrace.IdEstadoCognitivo7, ObjTrace.IdEstadoCognitivo8, ObjTrace.IdEstadoCognitivo9,
                     ObjTrace.IdEstadoCognitivo10, ObjTrace.ValoracionCognitiva, ObjTrace.IdEstadoAfectivo1, ObjTrace.IdEstadoAfectivo2, ObjTrace.IdEstadoAfectivo3,
                     ObjTrace.IdEstadoAfectivo4, ObjTrace.ConManifestacionesDepresivas, ObjTrace.ValoracionSocioFamiliar1, ObjTrace.ValoracionSocioFamiliar2,
                     ObjTrace.ValoracionSocioFamiliar3, ObjTrace.ValoracionSocioFamiliar4, ObjTrace.ValoracionSocioFamiliar5, ObjTrace.ValoracionSocioFamiliar,
                     ObjTrace.IdCategoriaAdutoMayor, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                     ObjTrace.FechaModificacion, ObjTrace.Accion).ToList(); 
             }
         }
    }
}
