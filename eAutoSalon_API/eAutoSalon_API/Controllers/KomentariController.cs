using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [Authorize(Roles = "Korisnik,Urednik,Administrator")]
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


        [HttpGet("TotalNumber/{id}")]
        public async Task<int> Total(int id)
        {
           return await _service.TotalNumber(id);
        }

        [HttpGet("History/{id}")]
        public async Task<List<VMKomentar_Historija>> GetHistory(int id)
        {
            return await _service.GetHistorijuKomentara(id);
        }
       
    }
}
