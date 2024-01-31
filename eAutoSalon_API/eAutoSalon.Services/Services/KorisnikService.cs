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
using System.Reflection.Metadata.Ecma335;
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

        public async Task<VMKorisnik> FetchUserProfile(string username)
        {
            var entity = await _context.Korisnicis.Where(x=>x.Username == username).FirstOrDefaultAsync(); 

            if(entity == null)
            {
                throw new UserException("Nema korisnika sa tim username-om");
            }

            return _mapper.Map<VMKorisnik>(entity);
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

        public async Task<List<string>> GetRoles(string username)
        {
            var entity = await _context.Korisnicis.Include(x => x.KorisnikUloges).ThenInclude(s => s.Uloga).Where(x => x.Username == username).FirstOrDefaultAsync();
            if (entity != null)
            {
                List<string> roles = new List<string>();
                foreach (var item in entity.KorisnikUloges)
                {
                    roles.Add(item.Uloga.Naziv);
                }
                return roles;
            }
            return new List<string>();
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
            korisnik.RegisteredOn = DateTime.Now;
            korisnik.State = "Aktivan";
            

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

        public async Task ChangeState(int userId)
        {
            var entity = await _context.Korisnicis.FindAsync(userId) ?? throw new Exception("Nema korisnika sa tim ID poljem");
            entity.State = "Izbrisan";
            await _context.SaveChangesAsync();
        }

        public async Task<PagedList<VMKorisnik>> getAktivne(SearchObject? search = null)
        {
            var query = _context.Korisnicis.Where(x => x.State == "Aktivan").OrderByDescending(x => x.KorisnikId).AsQueryable();

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                string fts = search.FTS.ToLower();
                query = query.Where(x => fts.Contains(x.Username.ToLower()) || fts.Contains(x.FirstName.ToLower()) || fts.Contains(x.LastName.ToLower()));
            }

            var list = new PagedList<VMKorisnik>()
            {
                PageCount = await query.CountAsync(),
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

            list.List = _mapper.Map<List<VMKorisnik>>(lista);

            return list;
        }

        public async Task<int> GetUserId(string username)
        {
            var entity = await _context.Korisnicis.Where(x=>x.Username==username).FirstOrDefaultAsync() ?? throw new UserException("Nepostojeće ID polje");
            return entity.KorisnikId;
        }

        public async Task<int> GetTotal()
        {
            int total = await _context.Korisnicis.Where(x=>x.State=="Aktivan").CountAsync();

            return total;
        }
    }
}
