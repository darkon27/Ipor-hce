using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class MA_MiscelaneosDetalleRule
    {
        public string AplicacionCodigo { get; set; }
        public string CodigoTabla { get; set; }
        public string Compania { get; set; }
        public string CodigoElemento { get; set; }
        public string DescripcionLocal { get; set; }
        public string DescripcionExtranjera { get; set; }
        public Nullable<double> ValorNumerico { get; set; }
        public string ValorCodigo1 { get; set; }
        public string ValorCodigo2 { get; set; }
        public string ValorCodigo3 { get; set; }
        public string ValorCodigo4 { get; set; }
        public string ValorCodigo5 { get; set; }
        public Nullable<System.DateTime> ValorFecha { get; set; }
        public string Estado { get; set; }
        public string UltimoUsuario { get; set; }
        public Nullable<System.DateTime> UltimaFechaModif { get; set; }
        public DateTime FechaAtencion { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFinal { get; set; }
        public DateTime FechaUltimoExamen { get; set; }
        public string CodigoComponente { get; set; }
        public string UnidadReplicacion { get; set; }
        public int IdPaciente { get; set; }
        public int Prioridad { get; set; }
        public int Secuencia { get; set; }
        public int EpisodioClinico { get; set; }
        public long EpisodioAtencion { get; set; }
        public long IdEpisodioAtencion { get; set; }
        public int IdOrdenAtencion { get; set; }
        public int LineaOrdenAtencion { get; set; }
        public string CodigoOA { get; set; }
        public string CodigoDiagnostico { get; set; }
        public string DeterminacionDiagnostico { get; set; }
        public int TipoAtencion { get; set; }
        public int TipoOrdenAtencion { get; set; }
        public int Modalidad { get; set; }
        public int Cantidad { get; set; }
        public int Annos { get; set; }
        public int Meses { get; set; }
        public int Dias { get; set; }
        public int Horas { get; set; }
        public int Minutos { get; set; }
        public int Segundos { get; set; }
        public int Estados { get; set; }

        public int EdadPaciente { get; set; }
        public string SexoPaciente { get; set; }

        public byte[] Timestamp { get; set; }
        public string ACCION { get; set; }
        public Nullable<int> RowID { get; set; }
        public Nullable<int> ValorEntero1 { get; set; }
        public Nullable<int> ValorEntero2 { get; set; }
        public Nullable<int> ValorEntero3 { get; set; }
        public Nullable<int> ValorEntero4 { get; set; }
        public Nullable<int> ValorEntero5 { get; set; }
        public string ValorCodigo6 { get; set; }
        public string ValorCodigo7 { get; set; }
        public Nullable<int> ValorEntero6 { get; set; }
        public Nullable<int> ValorEntero7 { get; set; }
        public Nullable<int> resultInt { get; set; }
        public Nullable<bool> resultBool { get; set; }
        public String resultCadena { get; set; }
        public Nullable<DateTime> resultFecha { get; set; }
        public virtual MA_MiscelaneosHeader MA_MiscelaneosHeader { get; set; }
    }

}
