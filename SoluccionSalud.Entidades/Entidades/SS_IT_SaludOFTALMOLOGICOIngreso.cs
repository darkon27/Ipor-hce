﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class SS_IT_SaludOFTALMOLOGICOIngreso
    {
        public int IdOrdenAtencion { get; set; }
        public Nullable<int> LineaOrdenAtencion { get; set; }
        public string UnidadReplicacion { get; set; }
        public int IdEpisodioAtencion { get; set; }
        public int IdPaciente { get; set; }
        public Nullable<int> EpisodioClinico { get; set; }
        public string Secuencia { get; set; }
        public string ENFACTUAL { get; set; }
        public string ANTIMPORTANCIA { get; set; }
        public string AVscOD { get; set; }
        public string AvCCOD { get; set; }
        public string AEAVODPIN { get; set; }
        public string CERCAVAD { get; set; }
        public string AVSCOI { get; set; }
        public string AVCCOI { get; set; }
        public string AEAVOIDPIN { get; set; }
        public string CERCAVAOI { get; set; }
        public string SPHodREFRA { get; set; }
        public string CILodREFA { get; set; }
        public string EJEodREFRA { get; set; }
        public string AVodREFRA { get; set; }
        public string ADDodREFRA { get; set; }
        public string DIPodREFRA { get; set; }
        public string SPHoiSCICLO { get; set; }
        public string CILoiSCICLO { get; set; }
        public string EJEoiSCICLO { get; set; }
        public string AVoiSCICLO { get; set; }
        public string ADDoiSCICLO { get; set; }
        public string DIPoiSCICLO { get; set; }
        public string PAPARPADOSANEXOS { get; set; }
        public string CORNEACRISTESCLERA { get; set; }
        public string IRISPUPILA { get; set; }
        public string TonoOD { get; set; }
        public string TonoOI { get; set; }
        public string MMHHTonShiotz { get; set; }
        public string MMHHTonAplanacion { get; set; }
        public string MMHHTonOtra { get; set; }
        public string FONDOJOyG { get; set; }
        public Nullable<int> Estado { get; set; }
        public string UsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IndicadorProcesado { get; set; }
        public Nullable<System.DateTime> FechaProcesado { get; set; }
    }
}
