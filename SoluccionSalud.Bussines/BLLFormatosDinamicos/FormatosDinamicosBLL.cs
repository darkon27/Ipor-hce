using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormatoCons;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormatosDinamicos
{
    public class FormatosDinamicosBLL
    {
        public int Listar(int ObjTrace)
        {
            return new FormatosDinamicosRepository().Listar(ObjTrace);
        }
        public int ListarAnt(int ObjTrace)
        {
            return new FormatosDinamicosRepository().ListarAnt(ObjTrace);
        }
    }
}
