using eAutoSalon.Models;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IProizvodiService
    {
        List<VMProizvodi> GetAll();
        Task<List<Uloge>> GetSve();
        VMProizvodi GetById(int id);
        VMProizvodi Insert(ProizvodiInsertRequest req);
    }
}
