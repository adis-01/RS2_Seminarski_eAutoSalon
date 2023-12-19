using AutoMapper;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
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
    public class AutomobilService : BaseCRUDService<VMAutomobil, Automobili, AutomobilSearchObject, AutomobilInsert, AutomobilUpdate>, IAutomobilService
    {
        public AutomobilService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Automobili> AddFilter(IQueryable<Automobili> query, AutomobilSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.
                    Where(x => search.FTS.Contains(x.Boja) ||
                    search.FTS.Contains(x.GodinaProizvodnje.ToString()) ||
                    search.FTS.Contains(x.VrstaGoriva) ||
                    search.FTS.Contains(x.PredjeniKilometri.ToString()));
            }
            return query;
        }

        public override IQueryable<Automobili> Order(IQueryable<Automobili> query)
        {
            query = query.OrderByDescending(x => x.AutomobilId);
            return query;
        }
    }
}
