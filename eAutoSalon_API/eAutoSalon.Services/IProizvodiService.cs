using eAutoSalon.Models;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services
{
    public interface IProizvodiService
    {
        List<Models.ViewModels.VMProizvodi> GetAll();
        Models.ViewModels.VMProizvodi GetById(int id);
    }
}
