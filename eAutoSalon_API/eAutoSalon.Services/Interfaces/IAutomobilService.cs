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
    public interface IAutomobilService : IBaseCRUDService<VMAutomobil,AutomobilSearchObject,AutomobilInsert,AutomobilUpdate>
    {
        Task<PagedList<VMAutomobil>> GetAktivne(AutomobilSearchObject? search = null);
        Task<PagedList<VMAutomobil>> GetProdane(AutomobilSearchObject? search = null);
        Task<PagedList<VMAutomobil>> GetFiltered(AutomobilSearchObject? search = null);
        Task<List<string>> GetProizvodjace();
        List<VMAutomobil> Recommend(int id);
        Task<int> GetUkupanBrojAktivnihOglasa();
    }
}
