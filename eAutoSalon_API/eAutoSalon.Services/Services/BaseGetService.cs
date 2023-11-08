using AutoMapper;
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
    public class BaseGetService<T,TDb, TSearch> : IBaseGetService<T, TSearch> where T : class where TSearch : class where TDb : class
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
            var list = await _context.Set<TDb>().ToListAsync();  

            return _mapper.Map<List<T>>(list);
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            if (entity == null)
                return null;

            return _mapper.Map<T>(entity);
        }
    }
}
