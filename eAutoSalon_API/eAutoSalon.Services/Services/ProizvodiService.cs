using AutoMapper;
using eAutoSalon.Models;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class ProizvodiService : IProizvodiService
    {
        private IMapper _mapper;
        private readonly EAutoSalonDbContext _dbContext;
        public ProizvodiService(IMapper mapper,EAutoSalonDbContext dbContext)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }
        List<Proizvodi> _proizvodiList = new List<Proizvodi>
        {
            new Proizvodi
            {
                ID = 0,
                Naziv="Mlijeko",
                CijenaProizvoda=3.00,
            },
            new Proizvodi
            {
                ID= 1,
                Naziv="Cokolada",
                SifraProizvoda="3AABFO032F",
                CijenaProizvoda=2.50
            }
        };
        public List<VMProizvodi> GetAll()
        {
            var proizvodi = _proizvodiList.ToList();

            return _mapper.Map<List<VMProizvodi>>(proizvodi);
        }

        public async Task<List<Uloge>> GetSve()
        {
            var uloge = await _dbContext.Uloges.ToListAsync();

            return uloge;
        }

        public VMProizvodi GetById(int id)
        {
            var proizvod = _proizvodiList.FirstOrDefault(x => x.ID == id);
            return _mapper.Map<VMProizvodi>(proizvod);
        }

        public VMProizvodi Insert(ProizvodiInsertRequest req)
        {
            Proizvodi proizvod = new Proizvodi();
            _mapper.Map(req, proizvod);
            _proizvodiList.Add(proizvod);
            return _mapper.Map<VMProizvodi>(proizvod);
        }
    }
}
