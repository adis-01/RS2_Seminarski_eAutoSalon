using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [ApiController]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : class
    {
        protected IBaseCRUDService<T, TSearch, TInsert, TUpdate> _service;
        ILogger<BaseController<T, TSearch>> _logger;

        public BaseCRUDController(IBaseCRUDService<T,TSearch,TInsert,TUpdate> service, ILogger<BaseController<T, TSearch>> logger) : base(service, logger)
        {
            _service = service;
            _logger = logger;
        }

        [HttpDelete("{id}")]
        public virtual async Task Delete(int id)
        {
            await _service.Delete(id);
        }

        [HttpPost]
        public virtual async Task<T> Insert(TInsert req)
        {
            return await _service.Insert(req);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, TUpdate req)
        {
            return await _service.Update(id, req);
        }

        
    }
}
