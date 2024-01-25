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
    [ApiController]
    public class RecenzijaController : BaseCRUDController<VMRecenzije, RecenzijaSearchObject, RecenzijaInsert, RecenzijaUpdate>
    {
        IRecenzijaService _service;
        public RecenzijaController(IRecenzijaService service, ILogger<BaseController<VMRecenzije, RecenzijaSearchObject>> logger) : base(service, logger)
        {
            _service = service;
        }

        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        public override Task<VMRecenzije> Insert([FromBody] RecenzijaInsert req)
        {
            return base.Insert(req);
        }

        [Authorize(Roles = "Korisnik,Administrator")]
        public override Task Delete(int id)
        {
            return base.Delete(id);
        }

        [Authorize(Roles ="Korisnik,Administrator,Urednik")]
        [HttpGet("Average")]
        public async Task<double> GetAverage()
        {
            return await _service.GetAverage();
        }

        [Authorize(Roles ="Korisnik,Administrator,Urednik")]
        [HttpGet("ByKorisnik/{id}")]
        public async Task<List<VMRecenzije>> getByKorisnik(int id)
        {
            return await _service.GetByKorisnik(id);
        }
    }
}
