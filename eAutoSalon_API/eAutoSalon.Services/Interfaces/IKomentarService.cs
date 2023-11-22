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
    public interface IKomentarService : IBaseCRUDService<VMKomentari,KomentariSearchObject,KomentarInsert,KomentarUpdate>
    {
        Task<PagedList<VMKomentari>> GetAllKomentari_Novost(int id, KomentariSearchObject? searchObject = null);
    }
}
