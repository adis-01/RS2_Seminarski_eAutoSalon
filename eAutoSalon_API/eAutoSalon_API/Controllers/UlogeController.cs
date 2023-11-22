using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]

    public class UlogeController : BaseController<VMUloga, UlogeSearchObject>
    {
        public UlogeController(IUlogeService service, ILogger<BaseController<VMUloga, UlogeSearchObject>> logger) : base(service, logger)
        {
        }
    }
}
