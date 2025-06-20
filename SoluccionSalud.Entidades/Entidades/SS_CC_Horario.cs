//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class SS_CC_Horario
    {
        public int IdHorario { get; set; }
        public Nullable<int> IdServicio { get; set; }
        public Nullable<int> Medico { get; set; }
        public Nullable<int> IdEspecialidad { get; set; }
        public Nullable<int> IdConsultorio { get; set; }
        public Nullable<int> Periodo { get; set; }
        public Nullable<int> IdTurno { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<System.DateTime> FechaFin { get; set; }
        public Nullable<System.DateTime> HoraInicio { get; set; }
        public Nullable<System.DateTime> HoraFin { get; set; }
        public Nullable<System.DateTime> FechaInicioHorario { get; set; }
        public Nullable<System.DateTime> FechaFinHorario { get; set; }
        public Nullable<int> TipoUso { get; set; }
        public Nullable<int> IndicadorLunes { get; set; }
        public Nullable<int> IndicadorMartes { get; set; }
        public Nullable<int> IndicadorMiercoles { get; set; }
        public Nullable<int> IndicadorJueves { get; set; }
        public Nullable<int> IndicadorViernes { get; set; }
        public Nullable<int> IndicadorSabado { get; set; }
        public Nullable<int> IndicadorDomingo { get; set; }
        public Nullable<int> TipoGeneracionCita { get; set; }
        public Nullable<decimal> TiempoPromedioAtencion { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> TipoRegistroHorario { get; set; }
        public Nullable<int> IndicadorCompartido { get; set; }
        public Nullable<int> IdGrupoAtencionCompartido { get; set; }
        public Nullable<int> IdInasistencia { get; set; }
        public Nullable<int> IndicadorCitaMultiple { get; set; }
        public Nullable<int> IndicadorAplicaAdicional { get; set; }
        public Nullable<int> CantidadCitasAdicional { get; set; }
        public string UnidadReplicacion { get; set; }
        public string ACCION { get; set; }
    }
    
}
