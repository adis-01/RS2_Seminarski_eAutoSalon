using AutoMapper;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class UlogeService : BaseGetService<VMUloga, Uloge, UlogeSearchObject>, IUlogeService
    {
        public UlogeService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Uloge> AddFilter(IQueryable<Uloge> query, UlogeSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query=query.Where(x=>x.Naziv.Contains(search.Naziv));
            }
            return query;
        }
    }
}
