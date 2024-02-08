using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TransakcijeController : ControllerBase
    {
        private readonly ITransakcijaService _service;

        public TransakcijeController(ITransakcijaService service)
        {
            _service= service;
        }

        [HttpPost]
        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        public async Task<VMTransakcija> Insert([FromBody] TransakcijaInsert req)
        {
           return await _service.Insert(req);
        }

        [Authorize(Roles = "Administrator")]
        [HttpGet]
        public async Task<List<VMTransakcija>> GetAll()
        {
            return await _service.GetAll();
        }
    }
}
