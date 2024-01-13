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
    public class OpremaController : ControllerBase
    {
        private readonly IOpremaService _service;
        public OpremaController(IOpremaService service)
        {
            _service = service;
        }

        [HttpGet("{automobilId}")]
        [Authorize(Roles = "Administrator,Korisnik,Urednik")]
        public async Task<VMOprema> GetOprema(int automobilId)
        {
            return await _service.GetOprema(automobilId);
        }

        [HttpPost]
        [Authorize(Roles = "Korisnik")]
        public async Task<VMOprema> Insert([FromBody] DodatnaOpremaInsert req)
        {
            return await _service.Insert(req);
        }
    }
}
