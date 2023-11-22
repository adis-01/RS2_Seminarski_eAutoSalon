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
        public KorisnikService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

       

        public override async Task BeforeInsert(KorisnikInsert? req, Korisnici entity)
        {
            entity.PasswordSalt = Generator.GenerateSalt();
            entity.PasswordHash = Generator.GenerateHash(entity.PasswordSalt, req.Password);
        }

        public override async Task AddConnections(Korisnici entity)
        {
            var user_role = new KorisnikUloge()
            {
                KorisnikId = entity.KorisnikId,
                UlogaId = 2
            };

            await _context.KorisnikUloges.AddAsync(user_role);
            await _context.SaveChangesAsync();  
        }

        public async Task<VMKorisnik> Login(string username, string password)
        {
            var entity = await _context.Korisnicis.Include("KorisnikUloges.Uloga").FirstOrDefaultAsync(x => x.Username == username);

            if(entity == null) { return null; }

      

            var hash = Generator.GenerateHash(entity.PasswordSalt, password);

            if(hash!=entity.PasswordHash) { return null; }

            return _mapper.Map<VMKorisnik>(entity);

        }

        public override async Task<VMKorisnik> Update(int id, KorisnikUpdate req)
        {
            var korisnik = await _context.Korisnicis.FindAsync(id);
            _mapper.Map(req, korisnik);
            await _context.SaveChangesAsync();
            return _mapper.Map<VMKorisnik>(korisnik);
        }

        public override IQueryable<Korisnici> AddFilter(IQueryable<Korisnici> list, SearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Username))
                list = list.Where(x => x.Username.Contains(search.Username));

            if (!string.IsNullOrWhiteSpace(search?.FTS))
                list = list.Where(x => search.FTS.Contains(x.Username) || search.FTS.Contains(x.FirstName) || search.FTS.Contains(x.LastName));

            return list;
        }

        public override IQueryable<Korisnici> AddInclude(IQueryable<Korisnici> query)
        {
            return query.Include("KorisnikUloges.Uloga");
        }
    }
}
