using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface ITestnaVoznjaService : IBaseGetService<VMTestnaVoznja,TestnaVoznjaSearchObject>
    {
        List<string> GetDostupne(int id, DateTime datum);
        Task<PagedList<VMTestnaVoznja>> GetAktivneTestne(TestnaVoznjaSearchObject? search = null);
        Task<PagedList<VMTestnaVoznja>> GetZavrseneTestne(TestnaVoznjaSearchObject? search = null);
        Task Insert(TestnaVoznjaInsert req);
        Task Complete(int id);
        Task Cancel(int id);
        Task<List<VMTestna_Historija>> GetHistory(int korisnikId);
    }
}
