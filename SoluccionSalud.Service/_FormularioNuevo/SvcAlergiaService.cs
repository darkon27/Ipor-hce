using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Bussines;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcAlergiaService
    {
        public static List<SS_HC_Alergia_FE> Alergia_Listar(SS_HC_Alergia_FE ObjTrace)
        {
            //return new AnamnesisEABLL().Anamnesis_EA_Listar(ObjTrace);
            //return new AnamnesisEARepository().Anamnesis_EA_Listar(ObjTrace);
            return new AlergiaRepository().Alergia_Listar(ObjTrace);
        }
    }
}
