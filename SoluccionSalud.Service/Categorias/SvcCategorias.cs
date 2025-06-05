using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines;
using SoluccionSalud.Bussines.BLLSeguridadConcepto;
using SoluccionSalud.Entidades.Entidades;


namespace SoluccionSalud.Service.Categorias
{
    public class SvcCategorias
    {
        public static List<SEGURIDADCONCEPTO> SelectAll()
        {
            return new CategoriasBLL().Mostrar();

        }

        public static int Eliminar(params object[] parameters)
        {

            return new CategoriasBLL().Eliminar(parameters);
        }
        public static List<SEGURIDADCONCEPTO> GetSelectSP(SEGURIDADCONCEPTO objSC)
        {
            return new SeguridadConceptoBLL().GetSelectSP(objSC);

        }
    }
}
