using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    public class BaseController<T,TFilter> : ControllerBase where T : class where TFilter : class
    {
        private IBaseService<T,TFilter> _service;
        private readonly ILogger<BaseController<T, TFilter>> _logger;
        public BaseController(IBaseService<T, TFilter> service, ILogger<BaseController<T, TFilter>> logger)
        {
            _service = service;
            _logger = logger;
        }

        [HttpGet]
        public async Task<List<T>> GetAll()
        {
            return await _service.GetAll();
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
