using eAutoSalon.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services
{
    public class ProizvodiService : IProizvodiService
    {
        List<Proizvodi> _proizvodiList = new List<Proizvodi>
        {
            new Proizvodi
            {
                ID = 0,
                Naziv="Mlijeko"
            },
            new Proizvodi
            {
                ID= 1,
                Naziv="Cokolada"
            }
        };
        public List<Proizvodi> GetAll()
        {
            return _proizvodiList;
        }

        public Proizvodi GetById(int id)
        {
            return _proizvodiList.FirstOrDefault(x => x.ID == id);
        }
    }
}
