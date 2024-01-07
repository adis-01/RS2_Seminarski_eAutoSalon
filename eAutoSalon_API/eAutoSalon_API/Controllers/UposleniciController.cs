using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [Authorize(Roles = "Korisnik,Urednik,Administrator")]
    public class UposleniciController : BaseCRUDController<VMUposlenik, UposlenikSearchObject, UposlenikInsert, UposlenikUpdate>
    {
        IUposlenikService _service;
        public UposleniciController(IUposlenikService service, ILogger<BaseController<VMUposlenik, UposlenikSearchObject>> logger) : base(service, logger)
        {
            _service = service;
        }

        [Authorize(Roles ="Korisnik")]
        public override async Task<VMUposlenik> Insert([FromBody] UposlenikInsert req)
        { 
            return await base.Insert(req);    
        }

        [Authorize(Roles = "Korisnik")]
        public override async Task Delete(int id)
        {
            await base.Delete(id);
        }

        [Authorize(Roles = "Korisnik")]
        public override async Task<VMUposlenik> Update(int id, [FromBody] UposlenikUpdate req)
        {
            return await base.Update(id, req);
        }

        [HttpPost("ChangePic/{id}")]
        [Authorize(Roles ="Korisnik,Administrator")]
        public async Task ChangePicture (int id, [FromBody] SlikaRequest req)
        {
            await _service.ChangePicture(id, req);
        }

    }
}
