using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class KomentariController : BaseCRUDController<VMKomentari, KomentariSearchObject, KomentarInsert, KomentarUpdate>
    {
        IKomentarService _service;
        public KomentariController(IKomentarService service, ILogger<BaseController<VMKomentari, KomentariSearchObject>> logger) : base(service, logger)
        {
            _service = service;
        }


        [HttpGet("Komentari_Novost/{id}")]
        public async Task<PagedList<VMKomentari>> GetComms(int id, [FromQuery]KomentariSearchObject? searchObject = null)
        {
            return await _service.GetAllKomentari_Novost(id,searchObject);
        }
    }
}
