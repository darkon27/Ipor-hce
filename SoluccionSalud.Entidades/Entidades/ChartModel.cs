using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace SoluccionSalud.Entidades.Entidades
{
    public partial class ChartModel : V_EpisodioAtenciones
    {
        public string Name
        {
            get;
            set;
        }
        
        public double Peso
        {
            get;
            set;
        }

        public double Data2
        {
            get;
            set;
        }

        public double Data3
        {
            get;
            set;
        }

        public double Data4
        {
            get;
            set;
        }

        public double Data5
        {
            get;
            set;
        }

        public double Data6
        {
            get;
            set;
        }

        public double Data7
        {
            get;
            set;
        }

        public double Data8
        {
            get;
            set;
        }

        public double Data9
        {
            get;
            set;
        }

        //public static List<ChartModel> GenerateData()
        //{
        //    return ChartModel.GenerateData(12, 20);
        //}

        //public static List<ChartModel> GenerateData(int n)
        //{
        //    return ChartModel.GenerateData(n, 20);
        //}

        public static List<ChartModel> GenerateData(int n, int floor)
        {
            var listarDatos = new List<SS_HC_FuncionesVitales_FE>();
            var dataStrin = ENTITY_GLOBAL.Instance.ANTENCIONESFUNCION;
            var json = JsonConvert.SerializeObject(dataStrin);

            string JSONstring = string.Empty;
            listarDatos = (List<SS_HC_FuncionesVitales_FE>)Newtonsoft.Json.JsonConvert.DeserializeObject(json, typeof(List<SS_HC_FuncionesVitales_FE>));


            List<ChartModel> data = new List<ChartModel>(n);
            //Random random = new Random();
            //double p = (random.NextDouble() * 11) + 1;
            var ObjsodioAtenciones = new V_EpisodioAtenciones();
            ObjsodioAtenciones.Codigo001 = "Peso";
            foreach (SS_HC_FuncionesVitales_FE LocalEnty in listarDatos)
            {
                //for (int i = 0; i < n; i++)
                //{
                data.Add(new ChartModel
                {
                    Name = Convert.ToDateTime(LocalEnty.Fecha).ToShortDateString(),
                    Peso = Convert.ToDouble(LocalEnty.Peso)

                    //Data1 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data2 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data3 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data4 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data5 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data6 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data7 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data8 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))),
                    //Data9 = Math.Floor(Math.Max(Convert.ToDouble(LocalEnty.PresionArterialMSD1), Convert.ToDouble(LocalEnty.PresionArterialMSD1))) 


                    //Name = CultureInfo.InvariantCulture.DateTimeFormat.MonthNames[i % 12],               

                    //Data1 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data2 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data3 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data4 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data5 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data6 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data7 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data8 = Math.Floor(Math.Max(random.NextDouble() * 100, floor)),
                    //Data9 = Math.Floor(Math.Max(random.NextDouble() * 100, floor))                      

                });
                //}
            }
            return data;
        }

        public static List<ChartModel> GenerateDataNegative()
        {
            return ChartModel.GenerateDataNegative(12, 20);
        }

        public static List<ChartModel> GenerateDataNegative(int n, int floor)
        {
            List<ChartModel> data = new List<ChartModel>(n);
            Random random = new Random();
            double p = (random.NextDouble() * 11) + 1;

            for (int i = 0; i < n; i++)
            {
                data.Add(new ChartModel
                {
                    Name = CultureInfo.InvariantCulture.DateTimeFormat.MonthNames[i % 12],
                    Peso = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data2 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data3 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data4 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data5 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data6 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data7 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data8 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor)),
                    Data9 = Math.Floor(Math.Max((random.NextDouble() - 0.5) * 100, floor))
                });
            }

            return data;
        }
    }
}

