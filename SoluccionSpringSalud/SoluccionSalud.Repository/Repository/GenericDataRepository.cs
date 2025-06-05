using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


 
using System.Data.Entity;
using SoluccionSalud.Model;
using SoluccionSalud.Entidades.IRepository;

 

namespace SoluccionSalud.Repository.Repository
{
    
     
    public class GenericDataRepository<T> : IGenericDataRepository<T> where T : class
    {

        public virtual int Add(params object[] items)
        {
            throw new NotImplementedException();
        }

        public virtual int Update(params object[] items)
        {
            throw new NotImplementedException();
        }

        public virtual int Delete(object items)
        {
            throw new NotImplementedException();
        }

        public virtual  bool Buscar(params object[] items)
        {
            throw new NotImplementedException();
        }

        public virtual List<T> GetSelectAll()
        {
           using( var context = new WEB_ERPSALUDEntities()){
                return context.Set<T>().ToList();
           }

        }

        public virtual List<T> GetSelect(params object[] items)
        {
            throw new NotImplementedException();
         
        }

        public virtual List<T> GetSelectSP(string sqlCommand, params object[] parameters)
        {

            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.Database.SqlQuery<T>(sqlCommand,parameters).ToList();
            }

        }
        public virtual int ExecuteNonQuery(string sqlCommand, params object[] parameters)
        {
            using(var context = new WEB_ERPSALUDEntities()){
                return context.Database.ExecuteSqlCommand(sqlCommand, parameters);
                
            }
        }

        public int AddEntity(params T[] items)
        {
            using (var context = new WEB_ERPSALUDEntities()) {
                foreach (T item in items) {
                    context.Entry(item).State = EntityState.Added;
                }
                return context.SaveChanges();
            }
          }
        public int UpdateEntity(params T[] items)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                foreach (T item in items)
                {
                    context.Entry(item).State = EntityState.Modified;
                }
                return context.SaveChanges();
            }
        }

        public int DeleteEntity(params T[] items)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                foreach (T item in items)
                {
                    context.Entry(item).State = EntityState.Deleted;
                }
                return context.SaveChanges();
            }
        }
    }
}
