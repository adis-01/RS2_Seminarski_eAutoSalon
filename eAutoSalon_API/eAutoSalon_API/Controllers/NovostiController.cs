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
    [Authorize(Roles ="Korisnik,Urednik,Administrator")]
    public class NovostiController : BaseCRUDController<VMNovosti, NovostiSearchObject, NovostInsert, NovostUpdate>
    {
        INovostService _service;
        public NovostiController(INovostService service, ILogger<BaseController<VMNovosti, NovostiSearchObject>> logger) : base(service, logger)
        {
            _service = service;
        }

        [Authorize(Roles ="Korisnik")]
        public override async Task<VMNovosti> Insert([FromBody] NovostInsert req)
        {
            return await base.Insert(req);
        }

        [Authorize(Roles = "Korisnik")]
        [HttpGet("GetVlastite")]
        public async Task<PagedList<VMNovosti>> getvl([FromQuery] string username, [FromQuery] NovostiSearchObject? search = null)
        {
            return await _service.getVlastite(username, search);
        }

        [Authorize(Roles = "Korisnik")]
        [HttpGet("GetOstale")]
        public async Task<PagedList<VMNovosti>> getos([FromQuery] string username, [FromQuery] NovostiSearchObject? search = null)
        {
            return await _service.getOstale(username, search);
        }

        [Authorize(Roles ="Korisnik")]
        public override async Task<VMNovosti> Update(int id, [FromBody] NovostUpdate req)
        {
            return await base.Update(id, req);
        }

        [Authorize(Roles = "Korisnik")]
        [HttpGet("userID")]
        public async Task<int> getUserId([FromQuery] string username)
        {
            return await _service.getUserId(username);
        }
            
    }
}
