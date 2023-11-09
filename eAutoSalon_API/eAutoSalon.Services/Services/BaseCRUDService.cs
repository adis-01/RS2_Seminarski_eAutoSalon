using AutoMapper;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using Microsoft.EntityFrameworkCore.SqlServer.Query.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class BaseCRUDService<T,TDb, TSearch, TInsert, TUpdate> : BaseGetService<T,TDb,TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
    {
        public BaseCRUDService(EAutoSalonDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public async Task Delete(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            if (entity != null)
            {
                _context.Set<TDb>().Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public virtual async Task<T> Insert(TInsert req)
        {
            var db = _context.Set<TDb>();

            var entity = _mapper.Map<TDb>(req);

            await BeforeInsert(req,entity);

            db.Add(entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }

        public virtual async Task BeforeInsert(TInsert? req, TDb entity)
        {
            
        }

        public virtual async Task<T> Update(int id,TUpdate req)
        {
            throw new NotImplementedException(); //TODO
        }
    }
}
