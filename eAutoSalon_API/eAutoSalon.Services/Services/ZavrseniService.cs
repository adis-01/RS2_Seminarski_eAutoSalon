using AutoMapper;
using eAutoSalon.Models;
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
    public class ZavrseniService : IZavrseniService
    {
        private readonly EAutoSalonTestContext _context;
        private readonly IMapper _mapper;

        public ZavrseniService(EAutoSalonTestContext context, IMapper mapper)
        {
            _context=context;
            _mapper=mapper;
        }

        public async Task<VMZavrseniWithSum> GetAll(ZavrseniSearchObject? search = null)
        {
            var q = _context.ZavrseniPoslovis.
                OrderByDescending(x=>x.Id)
                .Include("Automobil")
                .Include("Korisnik")
                .AsQueryable();
            
            if(search?.Mjesec != 0)
            {
                q = q.Where(x => x.DatumProdaje.Month == search!.Mjesec);
            }

            decimal suma = await q.SumAsync(x => x.Iznos);

            var list = await q.ToListAsync();
            
            var mappedList = _mapper.Map<List<VMZavrseni_Poslovi>>(list);

            var result = new VMZavrseniWithSum
            {
                Zavrseni = mappedList,
                Sum = suma
            };

            return result;
        }

        public async Task<VMZavrseni_Poslovi> Insert(ZavrseniPosaoInsert req)
        {
            bool userExists = await _context.Korisnicis.AnyAsync(x => x.KorisnikId == req.KorisnikId);
            if (!userExists)
            {
                throw new UserException("Nema korisnika sa tim ID poljem");
            }
            ZavrseniPoslovi entity = new();
            _mapper.Map(req, entity);
            entity.DatumProdaje = DateTime.Now;
            _context.ZavrseniPoslovis.Add(entity);
            await _context.SaveChangesAsync();

            var state = await _context.Automobilis.FindAsync(req.AutomobilId);

            if (state != null)
            {
                state.State = "Prodano";
            }

            await _context.SaveChangesAsync();

            return _mapper.Map<VMZavrseni_Poslovi>(entity);
        }
    }
}
