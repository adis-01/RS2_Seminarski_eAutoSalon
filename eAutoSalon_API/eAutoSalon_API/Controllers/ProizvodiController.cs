using eAutoSalon.Models;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [ApiController]
    [Route("[controller]/")]
    [Authorize]
    public class ProizvodiController : ControllerBase
    {
        private IProizvodiService _service;

        private readonly ILogger<WeatherForecastController> _logger;

        public ProizvodiController(ILogger<WeatherForecastController> logger,IProizvodiService service)
        {
            _logger = logger;
            _service = service;
        }


        [HttpGet]
        public List<VMProizvodi> GetAll()
        {
            return _service.GetAll();
        }

        [HttpGet("{id}")]
        public VMProizvodi GetById(int id)
        {
            return _service.GetById(id);   
        }

       
        [HttpPost]
        public VMProizvodi Insert(ProizvodiInsertRequest req)
        {
            return _service.Insert(req);
        }
        
    }
}