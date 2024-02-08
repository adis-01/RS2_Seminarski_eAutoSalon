using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ZavrseniPosloviController : ControllerBase
    {
        private readonly IZavrseniService _service;
        public ZavrseniPosloviController(IZavrseniService service)
        {
            _service=service;
        }

        [HttpGet]
        [Authorize(Roles = "Administrator")]
        public async Task<VMZavrseniWithSum> GetAll([FromQuery]ZavrseniSearchObject? search = null)
        {
            return await _service.GetAll(search);
        }

        [HttpPost]
        [Authorize(Roles = "Korisnik,Administrator")]
        public async Task<VMZavrseni_Poslovi> Insert([FromBody] ZavrseniPosaoInsert req)
        {
            return await _service.Insert(req);
        }
    }
}
