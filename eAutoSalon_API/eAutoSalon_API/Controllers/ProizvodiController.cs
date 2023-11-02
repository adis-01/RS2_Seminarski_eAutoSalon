using eAutoSalon.Models;
using eAutoSalon.Services;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [ApiController]
    [Route("[controller]")]
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
        public List<Proizvodi> GetAll()
        {
            return _service.GetAll();
        }

        [HttpGet("{id}")]
        public Proizvodi GetById(int id)
        {
            return _service.GetById(id);   
        }

        
    }
}