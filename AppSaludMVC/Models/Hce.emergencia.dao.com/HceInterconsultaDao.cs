using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SPRING_Restaurantes_RestServer1.Entidades;

namespace SPRING_Restaurantes_RestServer1
{
    public class HceInterconsultaDao
    {
        public int InsertInterconsulta(HceInterconsultaBean interconsulta)
        {
            SqlConnection objConexion = default(SqlConnection);
            SqlCommand objComando = default(SqlCommand);
            SqlDataAdapter objResultado = default(SqlDataAdapter);
            int IdPedido = 0;
            try
            {
                objConexion = new SqlConnection(Bd_Configuracion.cadenaSQL);
                objComando = new SqlCommand("SP_HCE_Interconsulta", objConexion);
                objComando.CommandType = CommandType.StoredProcedure;
                objResultado = new SqlDataAdapter(objComando);

                // add OutputParameter
                SqlParameter outputParam = objComando.Parameters.Add("@IdConsulta", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;

                //objComando.Parameters.AddWithValue("@CompaniaSocio", comanda.CompaniaSocio);
                //objComando.Parameters.AddWithValue("@EstablecimientoCodigo", comanda.EstablecimientoCodigo);
                //objComando.Parameters.AddWithValue("@IdPlano", comanda.IdPlano);
                //objComando.Parameters.AddWithValue("@idMesa", comanda.idMesa);
                //objComando.Parameters.AddWithValue("@Vendedor", comanda.Vendedor);
                //objComando.Parameters.AddWithValue("@Cliente", comanda.Cliente);
                //objComando.Parameters.AddWithValue("@IdCanalVenta", comanda.IdCanalVenta);
                //objComando.Parameters.AddWithValue("@NumeroComensales", comanda.NumeroComensales);
                //objComando.Parameters.AddWithValue("@IdAreaVenta", comanda.IdAreaVenta);
                //objComando.Parameters.AddWithValue("@Pedido", comanda.IdPedido);
                //objComando.Parameters.AddWithValue("@List", comanda.List);
                objConexion.Open();
                objComando.ExecuteNonQuery();
                IdPedido = int.Parse(outputParam.Value.ToString());
                objConexion.Close();
            }
            catch (Exception ex)
            {
              
            }
            return IdPedido;
        }
       


        private string retornarValorColumnaCadena(DataRow row, string columna)
        {
            if (row[columna] == DBNull.Value) { return ""; }
            else { return Convert.ToString(row[columna]); }
        }
        private int retornarValorColumnaEntero(DataRow row, string columna)
        {
            if (row[columna] == DBNull.Value) { return 0; }
            else { return Convert.ToInt32(row[columna]); }
        }

        private decimal retornarValorColumnaDecimal(DataRow row, string columna)
        {
            if (row[columna] == DBNull.Value) { return 0; }
            else { return Convert.ToInt32(row[columna]); }
        }
    }
}