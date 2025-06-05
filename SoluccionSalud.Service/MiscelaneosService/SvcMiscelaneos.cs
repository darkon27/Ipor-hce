using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLMiscelaneos;
using SoluccionSalud.Entidades.Entidades;
using Newtonsoft.Json;

namespace SoluccionSalud.Service.MiscelaneosService
{
    public class SvcMiscelaneos
    {
        public static List<MA_MiscelaneosDetalle> getRuleGetCollectionStore(HC_RuleGetCollectionStore objSC)
        {
            return new MiscelaneosBLL().getRuleGetCollectionStore(objSC);
        }
        public static List<MA_MiscelaneosDetalle> listarMiscelaneoNuevo(MA_MiscelaneosDetalle objSC)
        {
            return new MiscelaneosBLL().CombosMiscelaneos(objSC);
        }
        public static int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
        {
            return new MiscelaneosBLL().setMantenimiento(ObjTrace);
        }
        public static int setMantenimiento(List<MA_MiscelaneosDetalle> listaObjTrace)
        {
            return new MiscelaneosBLL().setMantenimiento(listaObjTrace);
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
            public string Codigo { get; set; }
            public string Name { get; set; }

            public static List<comboModelGenerico> GetComboGenericoMiscelaneos(string AppCodigo, string Compania, string codtabla)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboModelGenerico>();

                objMiscl.ACCION = "LISTAR";
                objMiscl.AplicacionCodigo = AppCodigo;
                objMiscl.Compania = Compania;
                objMiscl.CodigoTabla = codtabla.Trim();
                objMiscl.UltimoUsuario = ENTITY_GLOBAL.Instance.USUARIO;
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.listarMA_MiscelaneosDetalle(objMiscl, 0, 0);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboModelGenerico();
                        entidad.Codigo = obMa_Mis.CodigoElemento.Trim();
                        if (obMa_Mis.ValorNumerico != null)
                        {
                            entidad.ID = Convert.ToInt32(obMa_Mis.ValorNumerico);
                        }
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }

                return ModelArray;
            }

            public static List<comboModelGenerico> GetComboGenericoSession(string valor)
            {
                var ModelArray = new List<comboModelGenerico>();
                string JSONstring = string.Empty;
                if (valor == "TIPOVIA")
                {
                    JSONstring = JsonConvert.SerializeObject(ENTITY_GLOBAL.Instance.Session_TIPOVIA);
                }
                if (valor == "UNITIEMPO")
                {
                    JSONstring = JsonConvert.SerializeObject(ENTITY_GLOBAL.Instance.Session_UNITIEMPO);
                }
                if (valor == "INDIRECETA")
                {
                    JSONstring = JsonConvert.SerializeObject(ENTITY_GLOBAL.Instance.Session_INDIRECETA);
                }
                List<comboModelGenerico> listxx = (List<comboModelGenerico>)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONstring, typeof(List<comboModelGenerico>));
                if (valor == "TIPOVIA")
                {
                    var entidades = new comboModelGenerico();
                    entidades.Codigo = "0";
                    entidades.Name = "Seleccione";
                    entidades.ID = Convert.ToInt32("0");
                    listxx.Add(entidades);
                }
                return listxx;
            }


            public static List<comboModelGenerico> GetComboGenerico(string valor)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboModelGenerico>();

                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = valor.Trim();
                objMiscl.ValorCodigo5 = ENTITY_GLOBAL.Instance.USUARIO;
                if (objMiscl.CodigoTabla == "FAVORITOLISTA")
                {
                    objMiscl.ValorCodigo3 = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                }
                var resulObjMiscl = new MA_MiscelaneosDetalle();

                var data = ENTITY_GLOBAL.Instance.INDICADOR_COMBO;
                string JSONstring = string.Empty;
                JSONstring = JsonConvert.SerializeObject(data);
                List<MA_MiscelaneosDetalle> resulMiscelaneosTitulo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONstring, typeof(List<MA_MiscelaneosDetalle>));
                List<MA_MiscelaneosDetalle> listxx = resulMiscelaneosTitulo.Where(x => x.CodigoTabla == valor).ToList();
                var cont = 1;
                if (listxx.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in listxx)
                    {
                        if (cont == 1)
                        {
                            var entidades = new comboModelGenerico();
                            //  entidades.ID = 0;
                            entidades.Codigo = "0";
                            entidades.Name = "Seleccione";
                            entidades.ID = Convert.ToInt32("0");
                            ModelArray.Add(entidades);
                            cont--;
                        }
                        var entidad = new comboModelGenerico();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        entidad.ID = Convert.ToInt32(obMa_Mis.ValorCodigo1.Trim());
                        ModelArray.Add(entidad);
                    }
                }
                else
                {
                    resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
                    if (resulMiscelaneosTitulo.Count > 0)
                    {
                        foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                        {
                            var entidad = new comboModelGenerico();
                            entidad.ID = Convert.ToInt32(obMa_Mis.ValorCodigo1.Trim());
                            entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                            ModelArray.Add(entidad);
                        }
                    }
                }

                if (valor == "TIPALERGIA")
                {
                    var entidades = new comboModelGenerico();
                    //  entidades.ID = 0;
                    entidades.Codigo = "0";
                    entidades.Name = "Seleccione";
                    entidades.ID = Convert.ToInt32("0");
                    ModelArray.Add(entidades);
                    var sdsd = ModelArray.OrderBy(x => x.ID).ToList();
                    return sdsd;
                }
                else
                {
                    ModelArray = valor == "FORMATOVALIDADOS" ? ModelArray.OrderBy(x => x.Name).ToList() : ModelArray; //SI EL VALOR VIENE DE FORMATO VALIDOS, ORDENARA ASCENDENTE SINO LO DEJARA COMO ESTA :) 
                }
                return ModelArray;
            }

            public static List<MA_MiscelaneosDetalle> GetGrillaGenericos(string Linea, string Familia, string SubFamilia, string Descripcion, string Accion)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var resulList = new List<MA_MiscelaneosDetalle>();

                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                if (Linea != null) objMiscl.ValorCodigo1 = Linea.Trim();
                if (Familia != null) objMiscl.ValorCodigo2 = Familia.Trim();
                if (SubFamilia != null) objMiscl.ValorCodigo3 = SubFamilia.Trim();
                if (Descripcion != null) objMiscl.ValorCodigo4 = Descripcion.Trim();
                if (Accion != null)
                {
                    objMiscl.CodigoTabla = Accion.Trim();
                    var resulObjMiscl = new MA_MiscelaneosDetalle();
                    resulList = SvcMiscelaneos.GetUpListadoServicios(objMiscl);
                }
                return resulList;
            }

            public static List<comboModelGenerico> GetComboGenericoTxtDos(string Linea, string Familia, string SubFamilia, string Descripcion, string Accion)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboModelGenerico>();

                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.ValorCodigo1 = Linea.Trim();
                objMiscl.ValorCodigo2 = Familia.Trim();
                objMiscl.ValorCodigo3 = SubFamilia.Trim();
                objMiscl.CodigoTabla = Accion.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();

                var data = ENTITY_GLOBAL.Instance.INDICADOR_COMBO;
                string JSONstring = string.Empty;
                JSONstring = JsonConvert.SerializeObject(data);
                List<MA_MiscelaneosDetalle> resulMiscelaneosTitulo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONstring, typeof(List<MA_MiscelaneosDetalle>));
                List<MA_MiscelaneosDetalle> listxx = resulMiscelaneosTitulo.Where(x => x.CodigoTabla == objMiscl.CodigoTabla).ToList();

                if (listxx.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in listxx)
                    {
                        var entidad = new comboModelGenerico();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }
                else
                {
                    resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);

                    if (resulMiscelaneosTitulo.Count != 0)
                    {
                        ENTITY_GLOBAL.Instance.listaparchesito = resulMiscelaneosTitulo;
                    }
                    //Coment
                    //if (resulMiscelaneosTitulo.Count == 0)
                    //{
                    //    ENTITY_GLOBAL.Instance.listaparchesito = null;
                    //}



                    if (ENTITY_GLOBAL.Instance.listaparchesito.Count > 0)
                    {

                        foreach (MA_MiscelaneosDetalle obMa_Mis in ENTITY_GLOBAL.Instance.listaparchesito)
                        {
                            var entidad = new comboModelGenerico();
                            entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                            entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                            ModelArray.Add(entidad);
                        }

                    }




                    if (resulMiscelaneosTitulo.Count > 0)
                    {
                        foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                        {
                            var entidad = new comboModelGenerico();
                            entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                            entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                            ModelArray.Add(entidad);
                        }
                    }


                    //}





                }





                return ModelArray;
            }

            public static List<comboModelGenerico> GetComboGenericoTxt(string valor)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboModelGenerico>();

                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = valor.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();

                var data = ENTITY_GLOBAL.Instance.INDICADOR_COMBO;
                string JSONstring = string.Empty;
                JSONstring = JsonConvert.SerializeObject(data);
                List<MA_MiscelaneosDetalle> resulMiscelaneosTitulo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONstring, typeof(List<MA_MiscelaneosDetalle>));

                List<MA_MiscelaneosDetalle> listxx = resulMiscelaneosTitulo.Where(x => x.CodigoTabla == objMiscl.CodigoTabla).ToList();

                if (listxx.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in listxx)
                    {
                        var entidad = new comboModelGenerico();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }
                else
                {
                    resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
                    if (resulMiscelaneosTitulo.Count > 0)
                    {
                        foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                        {
                            var entidad = new comboModelGenerico();
                            entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                            entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                            ModelArray.Add(entidad);
                        }
                    }

                }


                return ModelArray;
            }

            public static List<comboModelGenerico> GetComboSeguridadTxt(string valor, string paramStr01, string paramStr02, int paramInt01)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                //var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboModelGenerico>();
                objMiscl.ACCION = "COMBOSEGURIDAD";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = valor.Trim();
                objMiscl.UltimoUsuario = ENTITY_GLOBAL.Instance.USUARIO;
                objMiscl.ValorCodigo1 = paramStr01;
                objMiscl.ValorCodigo2 = paramStr02;
                objMiscl.ValorEntero1 = paramInt01;

                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.listarMA_MiscelaneosDetalle(objMiscl, 0, 0);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboModelGenerico();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        entidad.ID = Convert.ToInt32(obMa_Mis.ValorEntero1 != null ? obMa_Mis.ValorEntero1 : 0);
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }

            public static List<comboModelGenerico> GetComboSeguridadTxtAlmacen(string valor, string paramStr01, string paramStr02, int paramInt01)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                //var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboModelGenerico>();
                objMiscl.ACCION = "COMBOSEGURIDAD";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = valor.Trim();
                objMiscl.UltimoUsuario = ((paramStr02 != null || paramStr02 != "") && (valor == "SUCURSAL" || valor == "UNIDADREPLI" || valor == "DESALMACEN")) ? paramStr02 : ENTITY_GLOBAL.Instance.USUARIO; objMiscl.ValorCodigo1 = paramStr01;
                objMiscl.ValorCodigo2 = paramStr02;
                objMiscl.ValorEntero1 = paramInt01;

                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.listarMA_MiscelaneosDetalle(objMiscl, 0, 0);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboModelGenerico();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        entidad.ID = Convert.ToInt32(obMa_Mis.ValorEntero1 != null ? obMa_Mis.ValorEntero1 : 0);
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }

            public static List<comboModelGenerico> GetComboDietatxt(string valor, int paramInt01)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                //var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboModelGenerico>();
                objMiscl.ACCION = "DIETAHIJOS";
                objMiscl.CodigoTabla = valor.Trim();
                objMiscl.ValorEntero1 = paramInt01;

                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.listarMA_MiscelaneosDetalle(objMiscl, 0, 0);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboModelGenerico();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        entidad.ID = Convert.ToInt32(obMa_Mis.ValorEntero1 != null ? obMa_Mis.ValorEntero1 : 0);
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }

            public static List<comboModelGenerico> GetComboGenericos(string Accion, string TablaCodigo)
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
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
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

        public static List<MA_MiscelaneosDetalle> listarMA_MiscelaneosDetalle(MA_MiscelaneosDetalle objSC, int inicio, int final)
        {
            List<MA_MiscelaneosDetalle> listaRet;
            listaRet = new MiscelaneosBLL().listarMA_MiscelaneosDetalle(objSC, inicio, final);
            foreach (MA_MiscelaneosDetalle result in listaRet)
            {
                result.DescripcionLocal = (result.DescripcionLocal + "").Trim();
                result.DescripcionExtranjera = (result.DescripcionExtranjera + "").Trim();
                result.CodigoElemento = (result.CodigoElemento + "").Trim();
            }
            return listaRet;
        }

        public static List<MA_MiscelaneosDetalle> CombosMiscelaneos(MA_MiscelaneosDetalle objSC)
        {
            return new MiscelaneosBLL().CombosMiscelaneos(objSC);
        }

        public static object GetCombosMiscelaneos(string p)
        {
            throw new NotImplementedException();
        }

        public static List<MA_MiscelaneosDetalle> GetCombosTitulo(MA_MiscelaneosDetalle objSC)
        {
            return new MiscelaneosBLL().CombosMiscelaneos(objSC);
        }

        public class comboMiscelaneoLista
        {
            public int ID { get; set; }
            public string Codigo { get; set; }
            public string Name { get; set; }

            public static List<comboMiscelaneoLista> GetComboGenerico(string valor)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboMiscelaneoLista>();

                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = valor.Trim();
                if (objMiscl.CodigoTabla == "FAVORITOLISTA")
                {
                    objMiscl.ValorCodigo3 = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                }
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetCombosTitulo(objMiscl);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboMiscelaneoLista();
                        entidad.ID = Convert.ToInt32(obMa_Mis.ValorCodigo1.Trim());
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }

            public static List<MA_MiscelaneosDetalle> GetGrillaGenericos(string Linea, string Familia, string SubFamilia, string Descripcion, string Accion)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var resulList = new List<MA_MiscelaneosDetalle>();

                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                if (Linea != null) objMiscl.ValorCodigo1 = Linea.Trim();
                if (Familia != null) objMiscl.ValorCodigo2 = Familia.Trim();
                if (SubFamilia != null) objMiscl.ValorCodigo3 = SubFamilia.Trim();
                if (Descripcion != null) objMiscl.ValorCodigo4 = Descripcion.Trim();
                if (Accion != null)
                {
                    objMiscl.CodigoTabla = Accion.Trim();
                    var resulObjMiscl = new MA_MiscelaneosDetalle();
                    resulList = SvcMiscelaneos.CombosMiscelaneos(objMiscl);
                }
                return resulList;
            }

            public static List<comboMiscelaneoLista> GetComboGenericoTxtDos(string Linea, string Familia, string SubFamilia, string Descripcion, string Accion)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboMiscelaneoLista>();

                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.ValorCodigo1 = Linea.Trim();
                objMiscl.ValorCodigo2 = Familia.Trim();
                objMiscl.ValorCodigo3 = SubFamilia.Trim();
                objMiscl.CodigoTabla = Accion.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetCombosTitulo(objMiscl);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboMiscelaneoLista();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }
                else
                {
                    if (objMiscl.CodigoTabla == "SELECCDEPA")
                    {
                        var entidad = new comboMiscelaneoLista();
                        entidad.Codigo = "";
                        entidad.Name = "";
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }
            public static List<comboMiscelaneoLista> GetComboGenericoTxt(string valor)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboMiscelaneoLista>();

                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = valor.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetCombosTitulo(objMiscl);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboMiscelaneoLista();
                        entidad.Codigo = obMa_Mis.ValorCodigo1.Trim();
                        if (obMa_Mis.DescripcionLocal != null)
                            entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }

            public static List<comboMiscelaneoLista> GetComboGenericos(string Accion, string TablaCodigo)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboMiscelaneoLista>();

                objMiscl.ACCION = Accion.Trim();
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = TablaCodigo.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetCombosTitulo(objMiscl);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboMiscelaneoLista();
                        entidad.ID = Convert.ToInt32(obMa_Mis.ValorCodigo1.Trim());
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }
            public static List<comboMiscelaneoLista> GetComboGenericosX(string Accion, string TablaCodigo)
            {
                var objMiscl = new MA_MiscelaneosDetalle();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                var ModelArray = new List<comboMiscelaneoLista>();

                objMiscl.ACCION = Accion.Trim();
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = TablaCodigo.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetCombosTitulo(objMiscl);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    //var entidad0 = new comboMiscelaneoLista();
                    //entidad0.ID = 0;
                    //entidad0.Name = "Seleccione";
                    //ModelArray.Add(entidad0);

                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        var entidad = new comboMiscelaneoLista();
                        entidad.ID = Convert.ToInt32(obMa_Mis.ValorCodigo1.Trim());
                        entidad.Name = obMa_Mis.DescripcionLocal.Trim();
                        ModelArray.Add(entidad);
                    }
                }
                return ModelArray;
            }
        }

        public static List<SS_FA_NotificacionDetalle> listarNotificaciones()
        {
            return new MiscelaneosBLL().listarNotificaciones();
        }
    }
}
