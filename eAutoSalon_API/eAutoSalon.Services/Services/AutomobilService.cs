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

        public async Task<List<string>> GetProizvodjace()
        {
            var list = new List<string>
            {
                "Svi"
            };
            var proizvodjaci = await _context.Automobilis.Where(x=>x.State=="Aktivan").Select(p=>p.Proizvodjac).Distinct().ToListAsync();
            foreach(var item in proizvodjaci)
            {
                list.Add(item);
            }

            return list;
        }

        public override async Task<VMAutomobil> Insert(AutomobilInsert req)
        {
            Automobili entity = new();

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

        

        public async Task<PagedList<VMAutomobil>> GetProdane(AutomobilSearchObject? search = null)
        {
            var query = _context.Automobilis.Where(x => x.State == "Prodano").OrderByDescending(x => x.AutomobilId).AsQueryable();

            

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

        public async Task PromijeniStatus(int automobilId)
        {
            var entity = await _context.Automobilis.FindAsync(automobilId) ?? throw new Exception("Nema automobila sa tim ID poljem");
            entity.State = "Prodano";
            await _context.SaveChangesAsync();
        }

        public async Task<PagedList<VMAutomobil>> GetFiltered(AutomobilSearchObject? search = null)
        {
            var query = _context.Automobilis.Where(x => x.State == "Aktivan").OrderByDescending(x => x.AutomobilId).AsQueryable();

            if (!string.IsNullOrWhiteSpace(search?.Proizvodjac))
            {
                if(search.Proizvodjac != "Svi")
                {
                    query = query.Where(x => x.Proizvodjac == search.Proizvodjac);
                }
            }

            if(!string.IsNullOrWhiteSpace(search?.TipGoriva))
            {
                if(search.TipGoriva != "Svi")
                {
                    query = query.Where(x => x.VrstaGoriva == search.TipGoriva);
                }
            }

            if (search?.PredjenaKilometraza.HasValue == true)
            {
                query = query.Where(x => x.PredjeniKilometri < search.PredjenaKilometraza);
            }

            if (search?.BrojVrata.HasValue == true)
            {
                query = query.Where(x => x.BrojVrata == search.BrojVrata);
            }

            if (search?.GodinaProizvodnje.HasValue == true)
            {
                query = query.Where(x => x.GodinaProizvodnje < search.GodinaProizvodnje);
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
