using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class KorisniciController : BaseCRUDController<VMKorisnik, SearchObject, KorisnikInsert, KorisnikUpdate>
    {
        IKorisnikService _service;
        public KorisniciController(IKorisnikService service, ILogger<BaseController<VMKorisnik, SearchObject>> logger) : base(service, logger)
        {
            _service = service;
        }


        [HttpPost("ChangePassword/{id}")]
        public async Task<VMKorisnik> ChangePass(int id, [FromBody] KorisnikPasswordRequest req)
        {
            return await _service.PasswordChange(id, req);
        }

        
    }
}
