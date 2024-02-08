using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authorization.Infrastructure;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [Authorize(Roles = "Korisnik,Urednik,Administrator")]
    public class TestnaVoznjaController : BaseController<VMTestnaVoznja,TestnaVoznjaSearchObject>
    {
        ITestnaVoznjaService _service;
        public TestnaVoznjaController(ITestnaVoznjaService service,ILogger<BaseController<VMTestnaVoznja,TestnaVoznjaSearchObject>> logger) : base(service,logger)
        {
            _service=service;
        }

        [HttpGet("GetAvailableAppointments/{id}")]
        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        public List<string> Get(int id,[FromQuery] DateTime datum)
        {
            return _service.GetDostupne(id, datum);
        }

        [HttpPost]
        [Authorize(Roles = "Korisnik")]
        public async Task<VMTestnaVoznja> Insert([FromBody] TestnaVoznjaInsert req)
        {
            return await _service.NovaTestna(req);
        }

        [HttpGet("GetAktivne")]
        [Authorize(Roles ="Administrator")]
        public async Task<PagedList<VMTestnaVoznja>> GetAktivne([FromQuery] TestnaVoznjaSearchObject? search = null)
        {
            return await _service.GetAktivneTestne(search);
        }

        [HttpGet("GetZavrsene")]
        [Authorize(Roles ="Administrator")]
        public async Task<PagedList<VMTestnaVoznja>> GetZavrsene([FromQuery] TestnaVoznjaSearchObject? search = null)
        {
            return await _service.GetZavrseneTestne(search);
        }

        [HttpPut("Cancel/{id}")]
        [Authorize(Roles = "Administrator")]
        public async Task Cancel(int id)
        {
            await _service.Cancel(id);
        }

        [HttpPut("Complete/{id}")]
        [Authorize(Roles = "Administrator")]
        public async Task Complete (int id)
        {
            await _service.Complete(id);
        }

        [HttpGet("GetHistory/{id}")]
        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        public async Task<List<VMTestna_Historija>> GetHistory(int id)
        {
            return await _service.GetHistory(id);
        }
    }
}
