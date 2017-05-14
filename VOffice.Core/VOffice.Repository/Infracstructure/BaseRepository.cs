using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Collections;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Data.Entity;
using VOffice.Repository.Infrastructure.Contract;
using VOffice.Model;
using System.Data.Entity.Core.Objects;

namespace VOffice.Repository.Infrastructure
{
    /// <summary>
    /// Base class for all SQL based service classes
    /// </summary>
    /// <typeparam name="T">The domain object type</typeparam>
    /// <typeparam name="TU">The database object type</typeparam>
    public class BaseRepository<T> : IBaseRepository<T>
        where T : class
    {
        //protected DbContext _entities;
        protected VOfficeEntities _entities;
        protected readonly IDbSet<T> _dbset;
        public BaseRepository()
        {
            _entities = new VOfficeEntities();
            _dbset = _entities.Set<T>();
        }
        public virtual T GetById(object primaryKey)
        {
            return _dbset.Find(primaryKey);
        }
        public virtual IEnumerable<T> GetAll()
        {
            return _dbset.AsEnumerable<T>();
        }
        public IEnumerable<T> FindBy(System.Linq.Expressions.Expression<Func<T, bool>> predicate)
        {

            IEnumerable<T> query = _dbset.Where(predicate).AsEnumerable();
            return query;
        }
        public virtual T Add(T entity)
        {
            T t = _dbset.Add(entity);
            _entities.SaveChanges();
            return t;
        }
        public void Delete(T entity)
        {

            
            _dbset.Remove(entity);
            _entities.SaveChanges();
        }
        public virtual T Edit(T entity)
        {
            _entities.Entry(entity).State = System.Data.Entity.EntityState.Modified;
            _entities.SaveChanges();
            return entity;
        }
        public virtual void Save()
        {
            _entities.SaveChanges();
        }
    }
}
