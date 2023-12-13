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
    public class UposleniciController : BaseCRUDController<VMUposlenik, UposlenikSearchObject, UposlenikInsert, UposlenikUpdate>
    {
        public UposleniciController(IUposlenikService service, ILogger<BaseController<VMUposlenik, UposlenikSearchObject>> logger) : base(service, logger)
        {
        }

        [Authorize(Roles ="Administrator")]
        public override async Task<VMUposlenik> Insert(UposlenikInsert req)
        {
            return await base.Insert(req);
        }

        [Authorize(Roles = "Administrator")]
        public override async Task Delete(int id)
        {
            await base.Delete(id);
        }

        [Authorize(Roles = "Administrator")]
        public override async Task<VMUposlenik> Update(int id, UposlenikUpdate req)
        {
            return await base.Update(id, req);
        }

    }
}
