using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
   public class SS_CE_TriajeViewModel
    {
        public decimal IdTriaje { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<System.TimeSpan> Hora { get; set; }
        public Nullable<int> IdPaciente { get; set; }
        public Nullable<int> NivelTriaje { get; set; }
        public string Observacion { get; set; }
        public Nullable<decimal> IdOrdenAtencion { get; set; }
        public Nullable<int> EstadoDocumento { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string UnidadReplicacion { get; set; }
        public string Accion { get; set; }
        public Nullable<int> PresionMinima { get; set; }
        public Nullable<int> PresionMaxima { get; set; }
        public Nullable<int> Pulso { get; set; }
        public Nullable<int> Respiracion { get; set; }
        public Nullable<decimal> Temperatura { get; set; }
        public Nullable<decimal> SaturacionMinima { get; set; }
        public Nullable<decimal> SaturacionMaxima { get; set; }
        public string TiempoEnfermedad { get; set; }
        public string Sintomas { get; set; }
        public string AntcedentesAlergias { get; set; }
        public Nullable<int> IdEspecialidad { get; set; }
        public Nullable<int> EstadoDocumentoAnterior { get; set; }
        public Nullable<int> indalergiamedicamento { get; set; }
        public string alergiamedicamento1 { get; set; }
        public string alergiamedicamento2 { get; set; }
        public string alergiamedicamento3 { get; set; }
        public string alergiamedicamento4 { get; set; }
        public string alergiamedicamento5 { get; set; }
        public Nullable<int> indmedicamentoregular { get; set; }
        public string medicamentoregular1 { get; set; }
        public string medicamentoregular1dosis { get; set; }
        public string medicamentoregular1frecuencia { get; set; }
        public string medicamentoregular1via { get; set; }
        public string medicamentoregular2 { get; set; }
        public string medicamentoregular2dosis { get; set; }
        public string medicamentoregular2frecuencia { get; set; }
        public string medicamentoregular2via { get; set; }
        public string medicamentoregular3 { get; set; }
        public string medicamentoregular3dosis { get; set; }
        public string medicamentoregular3frecuencia { get; set; }
        public string medicamentoregular3via { get; set; }
        public string medicamentoregular4 { get; set; }
        public string medicamentoregular4dosis { get; set; }
        public string medicamentoregular4frecuencia { get; set; }
        public string medicamentoregular4via { get; set; }
        public string medicamentoregular5 { get; set; }
        public string medicamentoregular5dosis { get; set; }
        public string medicamentoregular5frecuencia { get; set; }
        public string medicamentoregular5via { get; set; }
        public Nullable<int> indtransfusionessanguineas { get; set; }
        public Nullable<int> indproblematransfusion { get; set; }
        public Nullable<int> indalergiaalimento { get; set; }
        public Nullable<int> indalergiacontacto { get; set; }
        public Nullable<int> IndAprobacionAlergia { get; set; }
        public Nullable<int> IndCopiaCE { get; set; }
        public Nullable<int> IndAprobacionTriaje { get; set; }
        public string Sucursal { get; set; }
        public string usuariofirma { get; set; }
        public string alergiacontacto { get; set; }
        public Nullable<int> Especialidad { get; set; }
        public Nullable<int> IdEpisodioTriajeHCE { get; set; }
    }
}
