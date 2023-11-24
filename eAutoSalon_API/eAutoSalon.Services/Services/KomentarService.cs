using AutoMapper;
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

        public async Task<PagedList<VMKomentari>> GetAllKomentari_Novost(int id, KomentariSearchObject? searchObject = null)
        {
            var comms =  _context.Komentaris.Where(x=>x.NovostiId==id).Include("Korisnik").AsQueryable();

            var list = new PagedList<VMKomentari>();

            list.PageCount = await comms.CountAsync();

            if (searchObject?.Page.HasValue == true && searchObject?.PageSize.HasValue == true)
            {
                comms = comms.Skip(searchObject.PageSize.Value * (searchObject.Page.Value - 1)).Take(searchObject.PageSize.Value);
            }

        

            var result = await comms.ToListAsync();

            
            list.List = _mapper.Map<List<VMKomentari>>(result);


            return list;
        }
    }
}
