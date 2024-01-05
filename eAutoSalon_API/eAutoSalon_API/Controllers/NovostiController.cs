using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [Authorize(Roles ="Korisnik,Urednik,Administrator")]
    public class NovostiController : BaseCRUDController<VMNovosti, NovostiSearchObject, NovostInsert, NovostUpdate>
    {
        public NovostiController(INovostService service, ILogger<BaseController<VMNovosti, NovostiSearchObject>> logger) : base(service, logger)
        {
        }

        [Authorize(Roles ="Urednik")]
        public override async Task<VMNovosti> Insert([FromBody] NovostInsert req)
        {
            return await base.Insert(req);
        }

        [Authorize(Roles ="Urednik")]
        public override async Task<VMNovosti> Update(int id, [FromBody] NovostUpdate req)
        {
            return await base.Update(id, req);
        }
    }
}
