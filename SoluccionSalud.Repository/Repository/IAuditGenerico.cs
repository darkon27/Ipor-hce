using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.Repository
{ 
    public interface IAuditGenerico<T, P> where T : class
    {
        List<T> ConvertDataTable(DataTable dt);
        T GetItem(DataRow dr);
        //string XMLString(object objList);
        SS_HC_AuditRoyal AddAudita(object itemsA, object itemsB, dynamic itemsC, String Type);
        string XMLString(ICollection<T> objList);
        string XMLString(ICollection<T> objList, ICollection<P> objLists, string TablaID);
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
