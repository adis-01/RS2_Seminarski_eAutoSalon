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
            entity!.Status = "Otkazana";
            await _context.SaveChangesAsync();
        }

        public async Task Complete(int id)
        {
            var entity = await _context.TestnaVoznjas.FindAsync(id);
            entity!.Status = "Zavrsena";
            await _context.SaveChangesAsync();
        }

        public async Task<PagedList<VMTestnaVoznja>> GetAktivneTestne(TestnaVoznjaSearchObject? search = null)
        {
            var query = _context.TestnaVoznjas.Where(x=>x.Status=="Aktivna")
                .Include("Korisnik").Include("Automobil").Include("Uposlenik")
                .OrderByDescending(i => i.TestnaVoznjaId).AsQueryable();

            var list = new PagedList<VMTestnaVoznja>
            {
                PageCount = await query.CountAsync()
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

            list.List = _mapper.Map<List<VMTestnaVoznja>>(lista);

            return list;
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

        public async Task<List<VMTestna_Historija>> GetHistory(int korisnikId)
        {
            var list = await _context.TestnaVoznjas.Where(x => x.KorisnikId == korisnikId)
                       .Include("Automobil")
                       .Include("Uposlenik")
                       .ToListAsync();

            return _mapper.Map<List<VMTestna_Historija>>(list);
        }

        public async Task<PagedList<VMTestnaVoznja>> GetZavrseneTestne(TestnaVoznjaSearchObject? search = null)
        {
            var query = _context.TestnaVoznjas.Where(x => x.Status == "Zavrsena" || x.Status == "Otkazana")
                .Include("Korisnik").Include("Automobil").Include("Uposlenik")
                .OrderByDescending(i => i.TestnaVoznjaId).AsQueryable();

            var list = new PagedList<VMTestnaVoznja>
            {
                PageCount = await query.CountAsync()
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

            query.Include("Korisnik")
                .Include("Automobil")
                .Include("Uposlenik");

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.PageSize.Value * (search.Page.Value - 1)).Take(search.PageSize.Value);
                list.HasNext = search.Page.Value < list.TotalPages; 
            }



            var lista = await query.ToListAsync();

            list.List = _mapper.Map<List<VMTestnaVoznja>>(lista);

            return list;
        }

        public async Task<VMTestnaVoznja> NovaTestna(TestnaVoznjaInsert req)
        {
            var testna = new TestnaVoznja();
            _mapper.Map(req, testna);
            testna.UposlenikId = await _context.Uposlenicis.Where(x => x.Title == "Testiranje").Select(i=>i.UposlenikId).FirstOrDefaultAsync();
            testna.DatumVrijeme = DateTime.Parse(req.datum);
            await _context.TestnaVoznjas.AddAsync(testna);
            testna.Status = "Aktivna";
            await _context.SaveChangesAsync();
            return _mapper.Map<VMTestnaVoznja>(testna);
        }
    }
}
