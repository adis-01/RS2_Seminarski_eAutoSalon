﻿using AutoMapper;
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
        protected EAutoSalonTestContext _context;
        protected IMapper _mapper;

        public BaseGetService(EAutoSalonTestContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        public virtual async Task<PagedList<T>> GetAll(TSearch? search = null)
        {
            var query =  _context.Set<TDb>().AsQueryable();

            PagedList<T> list = new PagedList<T>();

            query = AddFilter(query, search);

            list.PageCount = await query.CountAsync();

            query = Order(query);
            query = AddInclude(query);

            if(search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query=query.Skip(search.PageSize.Value  * (search.Page.Value-1)).Take(search.PageSize.Value);
            }

            

            var lista = await query.ToListAsync();

            list.List= _mapper.Map<List<T>>(lista);

            return list;
        }

        public virtual IQueryable<TDb> Order(IQueryable<TDb> query)
        {
            return query;
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
