using AutoMapper;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
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
    public class TestnaVoznjaService : BaseGetService<VMTestnaVoznja,TestnaVoznja,TestnaVoznjaSearchObject>,ITestnaVoznjaService
    {
        public TestnaVoznjaService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<TestnaVoznja> AddInclude(IQueryable<TestnaVoznja> query)
        {
            return query.Include("Korisnik")
                        .Include("Automobil")
                        .Include("Uposlenik");
        }

        public async Task Cancel(int id)
        {
            var entity = await _context.TestnaVoznjas.FindAsync(id);
            entity!.Status = "Otkazano";
            await _context.SaveChangesAsync();
        }

        public async Task Complete(int id)
        {
            var entity = await _context.TestnaVoznjas.FindAsync(id);
            entity!.Status = "Zavrseno";
            await _context.SaveChangesAsync();
        }

        public List<string> GetDostupne(int id, DateTime datum)
        {
            DateTime pocetak = datum.AddHours(8);
            DateTime kraj = datum.AddHours(16);

            if (datum.DayOfWeek == DayOfWeek.Sunday || datum.DayOfWeek == DayOfWeek.Saturday)
            {
                return new List<string>();
            }

            var postojeci_termini = _context.TestnaVoznjas
                .Where(x => x.AutomobilId == id && x.DatumVrijeme.Date == datum.Date)
                .Select(d => d.DatumVrijeme.TimeOfDay)
                .ToList();

            var dostupni_termini = new List<string>();

            for (DateTime i = pocetak; i < kraj; i = i.AddHours(1))
            {
                var timeOfDay = i.TimeOfDay;

                if (!postojeci_termini.Any(x => x.Hours == timeOfDay.Hours))
                {
                    dostupni_termini.Add(timeOfDay.ToString(@"hh\:mm"));
                }
            }

            return dostupni_termini;
        }

        public async Task Insert(TestnaVoznjaInsert req)
        {
            var testna = new TestnaVoznja();
            _mapper.Map(req, testna);
            await _context.TestnaVoznjas.AddAsync(testna);
            testna.Status = "Rezervisano";
            await _context.SaveChangesAsync();
        }
    }
}
