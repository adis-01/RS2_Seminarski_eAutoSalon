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
    public class RecenzijaService : BaseCRUDService<VMRecenzije, Recenzije, RecenzijaSearchObject, RecenzijaInsert, RecenzijaUpdate>, IRecenzijaService
    {
        public RecenzijaService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Recenzije> Order(IQueryable<Recenzije> query)
        {
            query = query.OrderByDescending(x => x.RecenzijaId);
            return query;
        }

        public override IQueryable<Recenzije> AddFilter(IQueryable<Recenzije> query, RecenzijaSearchObject? search = null)
        {
            if(!search!.IsHiddenReviewsIncluded)
            {
                query = query.Where(x => x.State == "Aktivna");
            }
            else
            {
                query = query.Where(x => x.State == "Sakrivena");
            }
            return query;
        }

        public override IQueryable<Recenzije> AddInclude(IQueryable<Recenzije> query)
        {
            return query.Include("Korisnik");
        }

        public async Task<double> GetAverage()
        {
            double average = 0;
            List<int> ocjene = await _context.Recenzijes.Where(x=>x.State == "Aktivna").Select(o => o.Ocjena).ToListAsync();
            if (ocjene.Any())
            {
                average = ocjene.Average();
            }
            return average;
        }

        public async Task<List<VMRecenzije>> GetByKorisnik(int korisnikId)
        {
            var list = await _context.Recenzijes.Where(x => x.KorisnikId == korisnikId).
                Include("Korisnik").
                OrderByDescending(x=>x.RecenzijaId).
                ToListAsync();

            return _mapper.Map<List<VMRecenzije>>(list);
        }


        public async Task HideReview(int reviewId)
        {
            var entity = await _context.Recenzijes.FirstOrDefaultAsync(x=>x.RecenzijaId == reviewId) ?? throw new UserException("Nema recenzije sa tim ID poljem");
            entity.State = "Sakrivena";
            await _context.SaveChangesAsync();
        }

        public async Task ShowReview(int reviewId)
        {
            var entity = await _context.Recenzijes.FirstOrDefaultAsync(x => x.RecenzijaId == reviewId) ?? throw new UserException("Nema recenzije sa tim ID poljem");
            entity.State = "Aktivna";
            await _context.SaveChangesAsync();
        }
    }
}
