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
    public interface INovostService : IBaseCRUDService<VMNovosti,NovostiSearchObject,NovostInsert,NovostUpdate>
    {
        Task<PagedList<VMNovosti>> getVlastite(string username, NovostiSearchObject? search = null);
        Task<PagedList<VMNovosti>> getOstale(string username, NovostiSearchObject? search = null);
        Task<int> getUserId(string username);
    }
}
