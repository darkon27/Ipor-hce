using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALHorario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace SoluccionSalud.Bussines.BLLHorario
{
    public class BLLSS_CC_Horario
    {
        public List<SS_CC_Horario> listarSS_CC_Horario(SS_CC_Horario objSC, int inicio, int final)
        {
            return new SS_CC_HorarioRepository().listarSS_CC_Horario(objSC, inicio, final);
        }

        public int setMantenimiento(SS_CC_Horario ObjTrace)
        {
            return new SS_CC_HorarioRepository().setMantenimiento(ObjTrace);
        }
    }
}
