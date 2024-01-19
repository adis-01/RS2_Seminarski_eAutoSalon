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
    public class RecenzijaService : BaseCRUDService<VMRecenzije, Recenzije, RecenzijaSearchObject, RecenzijaInsert, RecenzijaUpdate>, IRecenzijaService
    {
        public RecenzijaService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Recenzije> AddInclude(IQueryable<Recenzije> query)
        {
            return query.Include("Korisnik");
        }

        public async Task<double> GetAverage()
        {
            double average = 0;
            List<int> ocjene = await _context.Recenzijes.Select(o => o.Ocjena).ToListAsync();
            if (ocjene.Any())
            {
                average = ocjene.Average();
            }
            return average;
        }
    }
}
