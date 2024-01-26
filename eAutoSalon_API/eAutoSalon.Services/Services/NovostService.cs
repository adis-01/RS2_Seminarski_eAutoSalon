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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

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
                if(search?.TipNovosti != "Svi")
                {
                    query = query.Where(x => x.Tip == search!.TipNovosti);
                }
            }
            return query;
        }

        public override IQueryable<Novosti> AddInclude(IQueryable<Novosti> query)
        {
            return query.Include("Korisnik");
        }

        public override IQueryable<Novosti> Order(IQueryable<Novosti> query)
        {
            query = query.OrderByDescending(x => x.NovostiId);
            return query;
        }

        public override async Task<VMNovosti> Insert(NovostInsert req)
        {
            var novost = new Novosti();
            _mapper.Map(req, novost);
            novost.DatumObjave = DateTime.Now;
            if(!string.IsNullOrWhiteSpace(req?.slikaBase64)) { novost.Slika = Convert.FromBase64String(req.slikaBase64!); }
            await _context.AddAsync(novost);
            await _context.SaveChangesAsync();
            return _mapper.Map<VMNovosti>(novost);
        }

        public async Task<PagedList<VMNovosti>> getVlastite(string username, NovostiSearchObject? search = null)
        {
            var q = _context.Novostis.Where(x => x.Korisnik.Username == username).OrderByDescending(x=>x.NovostiId).Include("Korisnik").AsQueryable();

            var list = new PagedList<VMNovosti>()
            {
                PageCount = await q.CountAsync(),
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
                q = q.Skip(search.PageSize.Value * (search.Page.Value - 1)).Take(search.PageSize.Value);
                list.HasNext = search.Page.Value < list.TotalPages;
            }

            var lista = await q.ToListAsync();

            list.List = _mapper.Map<List<VMNovosti>>(lista);

            return list;

        }

        public async Task<PagedList<VMNovosti>> getOstale(string username, NovostiSearchObject? search = null)
        {
            var q = _context.Novostis.Where(x => x.Korisnik.Username != username).OrderByDescending(x=>x.NovostiId).Include("Korisnik").AsQueryable();

            var list = new PagedList<VMNovosti>()
            {
                PageCount = await q.CountAsync(),
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
                q = q.Skip(search.PageSize.Value * (search.Page.Value - 1)).Take(search.PageSize.Value);
                list.HasNext = search.Page.Value < list.TotalPages;
            }

            var lista = await q.ToListAsync();

            list.List = _mapper.Map<List<VMNovosti>>(lista);

            return list;
        }

        public async Task<int> getUserId(string username)
        {
            var entity = await _context.Korisnicis.Where(x => x.Username == username).FirstOrDefaultAsync() ?? throw new Exception("No users with that username");

            int id = entity.KorisnikId;
            return id;
        }
    }
}
