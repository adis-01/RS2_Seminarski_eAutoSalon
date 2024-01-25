using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IRecenzijaService : IBaseCRUDService<VMRecenzije,RecenzijaSearchObject,RecenzijaInsert,RecenzijaUpdate>
    {
        Task<double> GetAverage();
        Task<List<VMRecenzije>> GetByKorisnik(int korisnikId);
    }
}
