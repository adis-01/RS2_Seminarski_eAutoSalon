using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    public class KorisniciController : BaseCRUDController<VMKorisnik, SearchObject, KorisnikInsert, KorisnikUpdate>
    {
        IKorisnikService _service;
        public KorisniciController(IKorisnikService service, ILogger<BaseController<VMKorisnik, SearchObject>> logger) : base(service, logger)
        {
            _service = service;
        }


        [HttpPost("ChangePassword/{id}")]
        [Authorize(Roles ="Korisnik")]
        public async Task<VMKorisnik> ChangePass(int id, [FromBody] KorisnikPasswordRequest req)
        {
            return await _service.PasswordChange(id, req);
        }

        [Authorize(Roles ="Korisnik")]
        public override Task<PagedList<VMKorisnik>> GetAll([FromQuery] SearchObject? search = null)
        {
            return base.GetAll(search);
        }


        [HttpPost("ChangePicture/{id}")]
        [Authorize(Roles = "Korisnik")]
        public async Task ChangePicture(int id, [FromBody] SlikaRequest req)
        {
            await _service.PictureChange(id,req);
        }

        [Authorize(Roles ="Administrator")]
        public override async Task Delete(int id)
        {
            await base.Delete(id);
        }

        [Authorize(Roles ="Korisnik,Administrator,Urednik")]
        [HttpGet("GetRoles")]
        public async Task<List<string>> GetRoles([FromQuery] string username)
        {
            return await _service.GetRoles(username);
        }

        [HttpGet("UserProfile")]
        [Authorize(Roles ="Korisnik,Administrator")]
        public async Task<VMKorisnik> GetUserProfile([FromQuery] string username)
        {
            return await _service.FetchUserProfile(username);
        }

        [Authorize(Roles = "Korisnik")]
        public override async Task<VMKorisnik> Update(int id, [FromBody]KorisnikUpdate req)
        {
            return await base.Update(id, req);
        }

    }
}
