using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TestnaVoznjaController : ControllerBase
    {
        ITestnaVoznjaService _service;
        public TestnaVoznjaController(ITestnaVoznjaService service)
        {
            _service=service;
        }

        [HttpGet("GetAvailableAppointments/{id}")]
        public List<string> Get(int id,[FromQuery] DateTime datum)
        {
            return _service.GetDostupne(id, datum);
        }

        [HttpPost]
        public async Task Insert(TestnaVoznjaInsert req)
        {
            await _service.Insert(req);
        }
    }
}
