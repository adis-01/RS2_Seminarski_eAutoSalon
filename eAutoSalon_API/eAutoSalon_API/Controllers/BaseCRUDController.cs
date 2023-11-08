using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [ApiController]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : class
    {
        protected readonly IBaseCRUDService<T, TSearch, TInsert, TUpdate> _service;
        ILogger<BaseController<T, TSearch>> _logger;

        public BaseCRUDController(IBaseCRUDService<T,TSearch,TInsert,TUpdate> service, ILogger<BaseController<T, TSearch>> logger) : base(service, logger)
        {
            _service = service;
            _logger = logger;
        }

        [HttpDelete("{id}")]
        public async Task Delete(int id)
        {
            await _service.Delete(id);
        }

        [HttpPost]
        public async Task<T> Insert(TInsert req)
        {
            return await _service.Insert(req);
        }
    }
}
