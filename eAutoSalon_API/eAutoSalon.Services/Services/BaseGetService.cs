using AutoMapper;
using eAutoSalon.Models;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class BaseGetService<T,TDb, TSearch> : IBaseGetService<T, TSearch> where T : class where TSearch : BaseSearchObject where TDb : class
    {
        protected EAutoSalonDbContext _context;
        protected IMapper _mapper;

        public BaseGetService(EAutoSalonDbContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        public virtual async Task<List<T>> GetAll(TSearch? search = null)
        {
            var query =  _context.Set<TDb>().AsQueryable();

            query = AddFilter(query, search);

            query = AddInclude(query);

            if(search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query=query.Take(search.PageSize.Value).Skip((search.Page.Value  * search.PageSize.Value) - search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            return _mapper.Map<List<T>>(list);
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search=null)
        {
            return query;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            if (entity == null)
                throw new UserException("Korisnik sa unesenim ID poljem nepostojeći.");

            return _mapper.Map<T>(entity);
        }
    }
}
