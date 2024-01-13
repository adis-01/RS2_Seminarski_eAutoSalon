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

        public override async Task<VMAutomobil> Insert(AutomobilInsert req)
        {
            Automobili entity = new Automobili();

            _mapper.Map(req, entity);
            if (!string.IsNullOrEmpty(req?.slikaBase64)) { entity.Slika = Convert.FromBase64String(req.slikaBase64);}
            entity.DatumObjave = DateTime.Now;
            entity.State = "Aktivan";
            await _context.AddAsync(entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<VMAutomobil>(entity);
        }

        public async Task<PagedList<VMAutomobil>> GetAktivne(AutomobilSearchObject? search = null)
        {
            var query = _context.Automobilis.Where(x=>x.State == "Aktivan").OrderByDescending(x=>x.AutomobilId).AsQueryable();

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.
                    Where(x => search.FTS.Contains(x.Boja) ||
                    search.FTS.Contains(x.GodinaProizvodnje.ToString()) ||
                    search.FTS.Contains(x.VrstaGoriva) ||
                    search.FTS.Contains(x.PredjeniKilometri.ToString()));
            }

            var list = new PagedList<VMAutomobil>()
            {
               PageCount = await query.CountAsync(),
            };

            if (search?.PageSize != null)
            {
                double? pageCount = list.PageCount;
                double? pageSize = search.PageSize;
                if (pageCount.HasValue && pageSize.HasValue)
                {
                    list.TotalPages = (int)Math.Ceiling(pageCount.Value / pageSize.Value);
                }
            }

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.PageSize.Value * (search.Page.Value - 1)).Take(search.PageSize.Value);
                list.HasNext = search.Page.Value < list.TotalPages;
            }

            var lista = await query.ToListAsync();

            list.List = _mapper.Map<List<VMAutomobil>>(lista);

            return list;
        }
    }
}
