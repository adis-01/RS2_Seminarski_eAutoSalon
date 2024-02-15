using AutoMapper;
using eAutoSalon.Models;
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
    public class UposlenikService : BaseCRUDService<VMUposlenik, Uposlenici, UposlenikSearchObject, UposlenikInsert, UposlenikUpdate>, IUposlenikService
    {
        public UposlenikService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override async Task BeforeInsert(UposlenikInsert? req, Uposlenici entity)
        {
            if (req?.SlikaBase64 != null)
                entity.Slika = Convert.FromBase64String(req.SlikaBase64);
            entity.State = "Aktivan";
        }


        public async Task ChangePicture(int id, SlikaRequest req)
        {
            var entity = await _context.Uposlenicis.FindAsync(id);

            if (entity == null)
                throw new UserException("Korisnik sa unesenim id-em je nepostojeći");

            entity.Slika = Convert.FromBase64String(req.slika);

            await _context.SaveChangesAsync();
        }

        public async Task ChangeState(int userId)
        {
            var uposlenik = await _context.Uposlenicis.FindAsync(userId) ?? throw new UserException("Nema uposlenika sa tim ID poljem");
            uposlenik.State = "Izbrisan";
            await _context.SaveChangesAsync();
        }

        public async Task<PagedList<VMUposlenik>> getUposlene(UposlenikSearchObject? search = null)
        {
            var query = _context.Uposlenicis.Where(x => x.State == "Aktivan").OrderByDescending(x => x.UposlenikId).AsQueryable();

            var list = new PagedList<VMUposlenik>()
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

            list.List = _mapper.Map<List<VMUposlenik>>(lista);

            return list;
        }
    }
}
