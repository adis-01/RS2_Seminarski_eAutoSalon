using eAutoSalon.Services;
using eAutoSalon.Services.Interfaces;
using eAutoSalon.Services.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [ApiController]
    public class BaseController<T,TSearch> : ControllerBase where T : class where TSearch : class
    {
       protected IBaseGetService<T,TSearch> _service;
        protected ILogger<BaseController<T,TSearch>> _logger;

        public BaseController(IBaseGetService<T,TSearch> service, ILogger<BaseController<T,TSearch>> logger)
        {
            _service = service;
            _logger = logger;
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }

        [HttpGet]
        public async Task<PagedList<T>> GetAll([FromQuery]TSearch? search = null)
        {
            return await _service.GetAll(search);
        }

    }
}
