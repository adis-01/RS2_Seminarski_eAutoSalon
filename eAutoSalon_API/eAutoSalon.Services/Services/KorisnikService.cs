using AutoMapper;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Helpers;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class KorisnikService : BaseCRUDService<VMKorisnik,Korisnici,SearchObject,KorisnikInsert,KorisnikUpdate>, IKorisnikService
    {
        public KorisnikService(EAutoSalonDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        //public async Task Delete(int id)
        //{
        //    var entity = await _context.Korisnicis.FindAsync(id);
        //    _context.Remove(entity);
        //    await _context.SaveChangesAsync();
        //}

        //public async Task<VMKorisnik> Insert(KorisnikInsert req)
        //{
        //    var korisnik = new Korisnici();
        //    _mapper.Map(req, korisnik);
        //    korisnik.PasswordSalt = Generator.GenerateSalt();
        //    korisnik.PasswordHash = Generator.GenerateHash(korisnik.PasswordSalt, req.Password);
        //    await _context.AddAsync(korisnik);
        //    await _context.SaveChangesAsync();
        //    return _mapper.Map<VMKorisnik>(korisnik);
        //}

        public override async Task BeforeInsert(KorisnikInsert? req, Korisnici entity)
        {
            entity.PasswordSalt = Generator.GenerateSalt();
            entity.PasswordHash = Generator.GenerateHash(entity.PasswordSalt, req.Password);
        }

        public Task<VMKorisnik> Login(string username, string password)
        {
            throw new NotImplementedException();
        }
    }
}
