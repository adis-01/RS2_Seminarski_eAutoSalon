using eAutoSalon.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services
{
    public interface IProizvodiService
    {
        List<Proizvodi> GetAll();
        Proizvodi GetById(int id);
    }
}
