using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLMiscelaneos;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.MiscelaneosService
{
     public class SvcMiscelaneos
     {
         public static int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
         {
             return new MiscelaneosBLL().setMantenimiento(ObjTrace);
         }
         public static List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle objSC)
         {
             return new MiscelaneosBLL().GetUpListadoServicios(objSC);
         }
         public static List<MA_MiscelaneosDetalle> GetFormTitulo(MA_MiscelaneosDetalle objSC)
         {
             return new MiscelaneosBLL().GetUpListadoServicios(objSC);
         }
   
         public class comboModelGenerico
         {
             public int ID { get; set; }
             public string Name { get; set; }

             public static List<comboModelGenerico> GetComboGenerico(string valor)
             {
                 var objMiscl = new MA_MiscelaneosDetalle();
                 var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                 var model = new SEGURIDADCONCEPTO();
                 var ModelArray = new List<comboModelGenerico>();

                 objMiscl.ACCION = "COMBOSGENERICOS";
                 objMiscl.AplicacionCodigo = "CG";
                 objMiscl.CodigoTabla = valor.Trim();
                 var resulObjMiscl = new MA_MiscelaneosDetalle();
                 var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
                 if (resulMiscelaneosTitulo.Count > 0)
                 {
                         foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                         {
                             var entidad = new comboModelGenerico();
                             entidad.ID = Convert.ToInt32(obMa_Mis.ValorCodigo1.Trim());
                             entidad.Name = obMa_Mis.DescripcionLocal;
                             ModelArray.Add(entidad);
                         }
                 }
                 return ModelArray;
             }
             public static List<comboModelGenerico> GetComboGenericos(string Accion, string TablaCodigo )
             {
                 var objMiscl = new MA_MiscelaneosDetalle();
                 var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                 var model = new SEGURIDADCONCEPTO();
                 var ModelArray = new List<comboModelGenerico>();

                 objMiscl.ACCION = Accion.Trim();
                 objMiscl.AplicacionCodigo = "CG";
                 objMiscl.CodigoTabla = TablaCodigo.Trim();
                 var resulObjMiscl = new MA_MiscelaneosDetalle();
                 var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
                 if (resulMiscelaneosTitulo.Count > 0)
                 {
                     foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                     {
                         var entidad = new comboModelGenerico();
                         entidad.ID = Convert.ToInt32(obMa_Mis.ValorCodigo1.Trim());
                         entidad.Name = obMa_Mis.DescripcionLocal;
                         ModelArray.Add(entidad);
                     }
                 }
                 return ModelArray;
             }
         }

         public static object GetComboGenerico(string p)
         {
             throw new NotImplementedException();
         }
     }
}
