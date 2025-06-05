using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.Repository
{
    public class Parameter
    {
        // Fields
        private DataTable _DataTable = null;
        private DbType _Type = DbType.Object;
        private System.Data.ParameterDirection _sDirection;
        private string _sName;
        private object _sValue;
        private int _sSize;

        private OracleType _OracleType;
        private bool _bOracleType;

        /// <summary>
        /// Obtiene o establece la dirección del parametro.
        /// </summary>
        public ParameterDirection Direction
        {
            get
            {
                return this._sDirection;
            }
            set
            {
                this._sDirection = value;
            }
        }
        /// <summary>
        /// Obtiene o establece el nombre del parametro.
        /// </summary>
        public string Name
        {
            get
            {
                return this._sName;
            }
            set
            {
                this._sName = value;
            }
        }
        /// <summary>
        /// Obtiene o establece el tipo del parametro
        /// </summary>
        public OracleType OracleType
        {
            get
            {
                return this._OracleType;
            }
            set
            {
                this._OracleType = value;
            }
        }

        /// <summary>
        /// Obtiene o establece el tipo del parametro
        /// </summary>
        public DbType Type
        {
            get
            {
                return this._Type;
            }
            set
            {
                this._Type = value;
            }
        }

        /// <summary>
        /// Obtiene o establece el valor del parametro.
        /// </summary>
        public object Value
        {
            get
            {
                return this._sValue;
            }
            set
            {
                this._sValue = value;
            }
        }
        /// <summary>
        /// Obtiene o establece el tamaño del parametro.
        /// </summary>
        public int Size
        {
            get
            {
                return this._sSize;
            }
            set
            {
                this._sSize = value;
            }
        }

        /// <summary>
        /// Obtiene o establece el DataTable que obtiene el resultado del Cursor.
        /// </summary>
        public DataTable DataTable
        {
            get
            {
                return this._DataTable;
            }
            set
            {
                this._DataTable = value;
            }
        }

        /// <summary>
        /// Construye un nuevo parametro
        /// </summary>
        /// <param name="str_pParameterName">El nombre del parametro</param>
        /// <param name="str_pParameterValue">El valor del parametro</param>
        public Parameter(string str_pParameterName, object str_pParameterValue)
            : this(str_pParameterName, str_pParameterValue, 0)
        {
        }


        /// <summary>
        /// Construye un nuevo parametro
        /// </summary>
        /// <param name="str_pOutputParameterName">El nombre del parámetro de salida.</param>
        /// <param name="obj_pDBType">El tipo del parametro.</param>
        public Parameter(string str_pOutputParameterName, DbType obj_pDBType)
            : this(str_pOutputParameterName, obj_pDBType, 0)
        {
        }

        /// <summary>
        /// Construye un nuevo parametro
        /// </summary>
        /// <param name="str_pParameterName">El nombre del parametro.</param>
        /// <param name="str_pParameterValue">El valor del parametro.</param>
        /// <param name="int_pParameterSize">El tamaño del parametro.</param>
        public Parameter(string str_pParameterName, object str_pParameterValue, int int_pParameterSize)
        {
            this.Name = str_pParameterName;
            this.Value = str_pParameterValue;
            this.Size = int_pParameterSize;
            this.Direction = ParameterDirection.Input;
        }

        /// <summary>
        /// Construye un nuevo parametro
        /// </summary>
        /// <param name="str_pOutputParameterName">El nombre del parámetro de salida.</param>
        /// <param name="obj_pDBType">El tipo del parametro de salida.</param>
        /// <param name="int_pSize">El tamaño del parametro de salida.</param>
        public Parameter(string str_pOutputParameterName, DbType obj_pDBType, int int_pSize)
        {
            this.Name = str_pOutputParameterName;
            this.Direction = ParameterDirection.Output;
            this.Type = obj_pDBType;
            this.Size = int_pSize;
        }

        public Parameter(string str_pOutputParameterName, OracleType obj_pDBType, ParameterDirection parDirection, object str_pParameterValue)
        {
            this.Name = str_pOutputParameterName;
            this.OracleType = obj_pDBType;
            this.Direction = parDirection;
            this.Value = str_pParameterValue;
        }

        /// <summary>
        /// El Parametro es un cursor, se define el DataTable de Resultado
        /// </summary>
        /// <param name="str_pOutputParameterName">Nombre del Parametro</param>
        /// <param name="dt_DataTable">Referencia del DataTable Resultado</param>
        public Parameter(string str_pOutputParameterName, ref DataTable dt_DataTable)
        {
            this.Name = str_pOutputParameterName;
            //this.OracleType =  OracleType.Cursor;
            this.Direction = ParameterDirection.Output;
            this.DataTable = dt_DataTable;
        }
    }
}
