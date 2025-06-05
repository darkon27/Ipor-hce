using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{
     public class AnamnesisEABLL
     {
         public int setMantenimiento(SS_HC_Anamnesis_EA objSC)
         {
             return new AnamnesisEARepository().setMantenimiento(objSC);
         }
         public int setMantenimiento(SS_HC_Anamnesis_EA ObjTraces, List<SS_HC_Anamnesis_EA> Cabecera, List<SS_HC_Anamnesis_EA> Detalle)
         {
             return new AnamnesisEARepository().setMantenimiento(ObjTraces, Cabecera, Detalle);
         }
         public List<SS_HC_Anamnesis_EA> Anamnesis_EA_Listar(SS_HC_Anamnesis_EA ObjTrace)
         {
             return new AnamnesisEARepository().Anamnesis_EA_Listar(ObjTrace);
         }
     }

}
