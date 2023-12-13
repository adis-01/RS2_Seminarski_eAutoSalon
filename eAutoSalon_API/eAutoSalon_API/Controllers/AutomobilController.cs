﻿using eAutoSalon.Models.InsertRequests;
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
    public class AutomobilController : BaseCRUDController<VMAutomobil, AutomobilSearchObject, AutomobilInsert, AutomobilUpdate>
    {
        public AutomobilController(IAutomobilService service, ILogger<BaseController<VMAutomobil, AutomobilSearchObject>> logger) : base(service, logger)
        {
        }

        [Authorize(Roles ="Administrator")]
        public override async Task<VMAutomobil> Insert(AutomobilInsert req)
        {
            return await base.Insert(req);
        }

        [Authorize(Roles ="Administrator")]
        public override async Task<VMAutomobil> Update(int id, AutomobilUpdate req)
        {
            return await base.Update(id, req);
        }

        [Authorize(Roles = "Administrator")]
        public override async Task Delete(int id)
        {
            await base.Delete(id);
        }
    }
}
