﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class VW_SA_PR_REP_ListaServiciosAuxiliares
    {
        public int Selector { get; set; }
        public string UnidadReplicacion { get; set; }
        public int Paciente { get; set; }
        public string CodigoHC { get; set; }
        public string PacienteNombres { get; set; }
        public string PacienteAPPaterno { get; set; }
        public string PacienteAPMaterno { get; set; }
        public Nullable<System.DateTime> FechaNacimiento { get; set; }
        public string Sexo { get; set; }
        public string TipoDocumento { get; set; }
        public string Documento { get; set; }
        public Nullable<int> TipoOrdenAtencionOA { get; set; }
        public string CodigoOA { get; set; }
        public Nullable<int> EstadoDocumento { get; set; }
        public Nullable<System.DateTime> FechaPago { get; set; }
        public Nullable<int> TipoAtencion { get; set; }
        public Nullable<int> Especialidad { get; set; }
        public Nullable<int> TipoPaciente { get; set; }
        public Nullable<int> Modalidad { get; set; }
        public int IndicadorSeguro { get; set; }
        public int IdOrdenAtencion { get; set; }
        public int Linea { get; set; }
        public Nullable<int> Estado { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public Nullable<int> TipoOrdenAtencion { get; set; }
        public string Componente { get; set; }
        public string ComponenteNombre { get; set; }
        public Nullable<decimal> CantidadSolicitada { get; set; }
        public Nullable<int> IndicadorDisponible { get; set; }
        public Nullable<int> IndicadorCobrado { get; set; }
        public Nullable<int> SituacionInterfase { get; set; }
        public Nullable<int> GrupoInterfase { get; set; }
        public Nullable<int> SecuencialInterfase { get; set; }
        public Nullable<int> Medico { get; set; }
        public string MedicoNombres { get; set; }
        public string MedicoAPPaterno { get; set; }
        public string MedicoAPMaterno { get; set; }
        public string CMP { get; set; }
        public Nullable<int> IdProcedimiento { get; set; }
        public Nullable<int> PREstadoDocumento { get; set; }
        public int MaximoGrupo { get; set; }
        public string Aseguradora_RUC { get; set; }
        public string Aseguradora_Nombre { get; set; }
        public string Empleadora_RUC { get; set; }
        public string Empleadora_Nombre { get; set; }
        public string Especialidad_Nombre { get; set; }
        public string TipoOrdenAtencion_Nombre { get; set; }
        public Nullable<int> EstadoDocumentoTransaccion { get; set; }
        public Nullable<System.DateTime> FechaLimiteAtencion { get; set; }
        public string Observacion { get; set; }
    }
}
