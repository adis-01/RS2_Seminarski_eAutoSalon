using AutoMapper;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
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
    public class NovostService : BaseCRUDService<VMNovosti, Novosti, NovostiSearchObject, NovostInsert, NovostUpdate>, INovostService
    {
        public NovostService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Novosti> AddFilter(IQueryable<Novosti> query, NovostiSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.TipNovosti))
            {
                query = query.Where(x => x.Tip == search.TipNovosti);
            }
            return query;
        }

         
    }
}
