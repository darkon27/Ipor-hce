using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Entidades.Entidades
{
    public class Order
    {
        private double totalPrice;

        private int cantidadProductos;


        private String descripcion;

        private double descuento;


        public double getTotalPrice()
        {
            return totalPrice;
        }

        public void setTotalPrice(double totalPrice)
        {
            this.totalPrice = totalPrice;
        }

        public int getCantidadProductos()
        {
            return cantidadProductos;
        }

        public void setCantidadProductos(int cantidadProductos)
        {
            this.cantidadProductos = cantidadProductos;
        }

        public double getDescuento()
        {
            return descuento;
        }

        public void setDescuento(double descuento)
        {
            this.descuento = descuento;
        }

        public String getDescripcion()
        {
            return descripcion;
        }

        public void setDescripcion(String descripcion)
        {
            this.descripcion = descripcion;
        }

    }
}
