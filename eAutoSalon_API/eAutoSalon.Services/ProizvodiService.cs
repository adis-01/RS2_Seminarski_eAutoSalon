using AutoMapper;
using eAutoSalon.Models;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services
{
    public class ProizvodiService : IProizvodiService
    {
        private IMapper _mapper;
        public ProizvodiService(IMapper mapper) {
            _mapper = mapper;
        }
        List<Models.Proizvodi> _proizvodiList = new List<Models.Proizvodi>
        {
            new Models.Proizvodi
            {
                ID = 0,
                Naziv="Mlijeko",
                CijenaProizvoda=3.00,
            },
            new Models.Proizvodi
            {
                ID= 1,
                Naziv="Cokolada",
                SifraProizvoda="3AABFO032F",
                CijenaProizvoda=2.50
            }
        };
        public List<Models.ViewModels.VMProizvodi> GetAll()
        {
            var proizvodi = _proizvodiList.ToList();

            return _mapper.Map<List<Models.ViewModels.VMProizvodi>>(proizvodi);
        }

        public Models.ViewModels.VMProizvodi GetById(int id)
        {
            var proizvod =  _proizvodiList.FirstOrDefault(x => x.ID == id);
            return _mapper.Map<Models.ViewModels.VMProizvodi>(proizvod);
        }
    }
}
