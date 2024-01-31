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
    public interface IKorisnikService : IBaseCRUDService<VMKorisnik,SearchObject,KorisnikInsert,KorisnikUpdate>
    {
        Task<VMKorisnik> Login(string username, string password);
        Task<VMKorisnik> PasswordChange(int id,KorisnikPasswordRequest req);
        Task PictureChange(int id,SlikaRequest req);
        Task<List<string>> GetRoles(string username);
        Task<VMKorisnik> FetchUserProfile(string username);
        Task ChangeState(int userId);
        Task<PagedList<VMKorisnik>> getAktivne(SearchObject? search = null);
        Task<int> GetUserId(string username);
        Task<int> GetTotal();
    }
}
