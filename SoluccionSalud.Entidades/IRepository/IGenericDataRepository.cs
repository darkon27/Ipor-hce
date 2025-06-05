using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Linq.Expressions;

namespace SoluccionSalud.Entidades.IRepository
{
    public interface IGenericDataRepository<T> where T : class
    {
        int AddEntity(params T[] items);
        int UpdateEntity(params T[] items);
        int DeleteEntity(params T[] items);

        int Add(params object[] items);
        int Update(params object[] items);
        int Delete(object items);

        bool Buscar(params object[] items);
        List<T> GetSelectAll();
        List<T> GetSelect(params object[] items);
        List<T> GetSelectSP(string sqlCommand, params object[] parameters);
        int ExecuteNonQuery(string sqlCommand, params object[] parameters);

    }
}
