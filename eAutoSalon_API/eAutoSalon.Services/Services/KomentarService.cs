using AutoMapper;
using eAutoSalon.Models;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RabbitMQ.Client;
using System.Text;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace eAutoSalon.Services.Services
{
    public class KomentarService : BaseCRUDService<VMKomentari, Komentari, KomentariSearchObject, KomentarInsert, KomentarUpdate>, IKomentarService
    {
        public KomentarService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Komentari> AddInclude(IQueryable<Komentari> query)
        {
            return query.Include("Korisnik");
        }

        public override IQueryable<Komentari> Order(IQueryable<Komentari> query)
        {
            query = query.OrderByDescending(x => x.KomentarId);
            return query;
        }

        public async Task<PagedList<VMKomentari>> GetAllKomentari_Novost(int id, KomentariSearchObject? searchObject = null)
        {
            var comms =  _context.Komentaris.Where(x=>x.NovostiId==id).Include("Korisnik").OrderByDescending(x=>x.KomentarId).AsQueryable();

            var list = new PagedList<VMKomentari>
            {
                PageCount = await comms.CountAsync()
            };

            if (searchObject?.PageSize != null)
            {
                double? pageCount = list.PageCount;
                double? pageSize = searchObject.PageSize;
                if (pageCount.HasValue && pageSize.HasValue)
                {
                    list.TotalPages = (int)Math.Ceiling(pageCount.Value / pageSize.Value);
                }
            }

            if (searchObject?.Page.HasValue == true && searchObject?.PageSize.HasValue == true)
            {
                comms = comms.Skip(searchObject.PageSize.Value * (searchObject.Page.Value - 1)).Take(searchObject.PageSize.Value);
                list.HasNext = searchObject.Page.Value < list.TotalPages;
            }



            var result = await comms.ToListAsync();

            
            list.List = _mapper.Map<List<VMKomentari>>(result);


            return list;
        }

        public async Task<List<VMKomentar_Historija>> GetHistorijuKomentara(int id)
        {
            var list =  _context.Komentaris
                .OrderByDescending(x=>x.KomentarId)
                .Where(x => x.KorisnikId == id)
                .Include("Novosti")
                .AsQueryable();

            await list.ToListAsync();

            return _mapper.Map<List<VMKomentar_Historija>>(list);
        }

        public async Task<int> TotalNumber(int novostId)
        {
            var list = _context.Komentaris.Where(x => x.NovostiId == novostId);

            int count = await list.CountAsync();

            return count;
        }

        public async Task HideComment(int commentId)
        {
            var entity = await _context.Komentaris.FirstOrDefaultAsync(x => x.KomentarId == commentId) ?? throw new UserException("Nema komentara sa tim ID poljem");
            entity.State = "Sakriven";
            await _context.SaveChangesAsync();
        }
    }
}
