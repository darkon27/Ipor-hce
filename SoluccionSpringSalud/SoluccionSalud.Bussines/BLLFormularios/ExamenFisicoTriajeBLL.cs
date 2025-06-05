using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{ 
    public class ExamenFisicoTriajeBLL
    {
        public int setMantenimiento(SS_HC_ExamenFisico_Triaje objSC)
        {
            return new ExamenFisicoTriajeRepository().setMantenimiento(objSC);
        }

        public List<SS_HC_ExamenFisico_Triaje> ExamenFisicoTriajeListar(SS_HC_ExamenFisico_Triaje objSC)
        {
            return new ExamenFisicoTriajeRepository().ExamenFisicoTriajeListar(objSC);
        }
        
    }
}
