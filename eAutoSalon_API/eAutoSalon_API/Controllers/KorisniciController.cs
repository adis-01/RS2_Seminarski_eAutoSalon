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
        [Authorize(Roles ="Korisnik,Administrator, Urednik")]
        public async Task<VMKorisnik> ChangePass(int id, [FromBody] KorisnikPasswordRequest req)
        {
            return await _service.PasswordChange(id, req);
        }

        [Authorize(Roles ="Administrator")]
        public override Task<PagedList<VMKorisnik>> GetAll([FromQuery] SearchObject? search = null)
        {
            return base.GetAll(search);
        }

        [AllowAnonymous]
        [HttpPost("Verify")]
        public async Task Verify(VerificationRequest req)
        {
            await _service.Verify(req);
        }



        [HttpPost("ChangePicture/{id}")]
        [Authorize(Roles = "Korisnik, Administrator, Urednik")]
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

        [Authorize(Roles ="Administrator")]
        [HttpGet("GetAktivne")]
        public async Task<PagedList<VMKorisnik>> GetAktivne([FromQuery]SearchObject? search = null)
        {
            return await _service.getAktivne(search);
        }

        [Authorize(Roles = "Administrator")]
        [HttpPut("ChangeState/{id}")]
        public async Task ChangeState(int id)
        {
            await _service.ChangeState(id);
        }

        [HttpGet("UserProfile")]
        [Authorize(Roles ="Korisnik,Administrator,Urednik")]
        public async Task<VMKorisnik> GetUserProfile([FromQuery] string username)
        {
            return await _service.FetchUserProfile(username);
        }

        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        public override async Task<VMKorisnik> Update(int id, [FromBody]KorisnikUpdate req)
        {
            return await base.Update(id, req);
        }

        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        [HttpGet("getUserId")]
        public async Task<int> GetUserId([FromQuery] string username)
        {   
            return await _service.GetUserId(username);
        }

        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        [HttpGet("GetTotalNumber")]
        public async Task<int> GetTotal()
        {
            return await _service.GetTotal();
        }

    }
}
