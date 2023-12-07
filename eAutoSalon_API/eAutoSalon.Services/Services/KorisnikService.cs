using AutoMapper;
using eAutoSalon.Models;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Helpers;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class KorisnikService : BaseCRUDService<VMKorisnik,Korisnici,SearchObject,KorisnikInsert,KorisnikUpdate>, IKorisnikService
    {
        IMailService _service;
        public KorisnikService(EAutoSalonTestContext context, IMapper mapper,IMailService service) : base(context, mapper)
        {
            _service = service;
        }


        public override async Task DeleteConns(int id)
        {
            var context = await _context.KorisnikUloges.Where(x => x.KorisnikId == id).FirstOrDefaultAsync();
            _context.Remove(context);
        }

        public async Task AddConnections(Korisnici entity)
        {
            var user_role = new KorisnikUloge()
            {
                KorisnikId = entity.KorisnikId,
                UlogaId = 2
            };

            //await _service.StartRabbitMQ(entity.Email);

            await _context.KorisnikUloges.AddAsync(user_role);
            await _context.SaveChangesAsync();
        }


        public override async Task<VMKorisnik> Insert(KorisnikInsert req)
        {
            if (await _context.Korisnicis.AnyAsync(x => x.Username == req.Username))
            {
                throw new UserException("Uneseni username je već postojeći, molimo odaberite neki drugi");
            }

            if (await _context.Korisnicis.AnyAsync(x => x.Email == req.Email))
            {
                throw new UserException("Uneseni email je već postojeći, molimo odaberite neki drugi");
            }

            var korisnik = new Korisnici();

            _mapper.Map(req,korisnik);

            korisnik.PasswordSalt = Generator.GenerateSalt();
            korisnik.PasswordHash = Generator.GenerateHash(korisnik.PasswordSalt, req.Password!);
            if (req?.SlikaBase64!=null) { korisnik.Slika = Convert.FromBase64String(req.SlikaBase64!); }
            

            await _context.Korisnicis.AddAsync(korisnik);
            await _context.SaveChangesAsync();

            await AddConnections(korisnik);

            return _mapper.Map<VMKorisnik>(korisnik);
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

        public async Task<VMKorisnik> PasswordChange(int id, KorisnikPasswordRequest req)
        {
            var entity = await _context.Korisnicis.FindAsync(id);

            if (entity == null)
            {
                throw new UserException("Korisnik sa id poljem je nepostojeći.");
            }

            var hash = Generator.GenerateHash(entity.PasswordSalt, req.Stari_Pass);

            if(hash!=entity.PasswordHash)
            {
                throw new UserException("Stari password se ne poklapa sa postojećim.");
            }

            entity.PasswordHash = Generator.GenerateHash(entity.PasswordSalt,req.Novi_Pass);

            await _context.SaveChangesAsync();

            return _mapper.Map<VMKorisnik>(entity);
        }

        public async Task PictureChange(int id, SlikaRequest req)
        {
            var entity = await _context.Korisnicis.FindAsync(id);

            if (entity == null)
                throw new UserException("Korisnik sa unesenim id-em je nepostojeći");

            entity.Slika = Convert.FromBase64String(req.slika);

            await _context.SaveChangesAsync();
        }
    }
}
