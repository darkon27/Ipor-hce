using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service.Categorias;


namespace AppConsola
{
    class Program
    {
        static void Main(string[] args)
        {
             ////PRUEBA DE SVN 1021221  Fiiieieiee
            	 

            var employee = new SEGURIDADCONCEPTO();
            employee.ACCION="GRUPO";
            employee.APLICACIONCODIGO = "WA";
            employee.GRUPO ="GRUPO017";

            foreach (var item in SvcCategorias.GetSelectSP(employee))
            {
                Console.WriteLine(item.CONCEPTO.ToString() + " - " + item.DESCRIPCION);
            }
            /*
            foreach (var item in SvcCategorias.SelectAll()) {
                Console.WriteLine(item.CONCEPTO.ToString()+ " - "+ item.DESCRIPCION);
            }
            Console.ReadKey();
            Console.WriteLine("======");
            Console.WriteLine("Ingreso un Valor");
            int id = Convert.ToInt32(Console.ReadLine());

            if (SvcCategorias.Eliminar(id) == 0)
            {
                Console.WriteLine("No Elimino");
            }
            else
            {
                Console.WriteLine("Si Elimino");
            }

            Console.ReadKey();
            */
           
        }
        

    }
}
