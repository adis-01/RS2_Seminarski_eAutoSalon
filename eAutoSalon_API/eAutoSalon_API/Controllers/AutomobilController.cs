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
    [ApiController]
    [Authorize(Roles = "Korisnik")]
    public class AutomobilController : BaseCRUDController<VMAutomobil, AutomobilSearchObject, AutomobilInsert, AutomobilUpdate>
    {
        public AutomobilController(IAutomobilService service, ILogger<BaseController<VMAutomobil, AutomobilSearchObject>> logger) : base(service, logger)
        {
        }
    }
}
