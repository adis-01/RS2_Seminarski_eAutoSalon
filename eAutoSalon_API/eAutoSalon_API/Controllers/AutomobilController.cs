﻿using eAutoSalon.Models.InsertRequests;
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
    public class AutomobilController : BaseCRUDController<VMAutomobil, AutomobilSearchObject, AutomobilInsert, AutomobilUpdate>
    {
        IAutomobilService _service;
        public AutomobilController(IAutomobilService service, ILogger<BaseController<VMAutomobil, AutomobilSearchObject>> logger) : base(service, logger)
        {
            _service = service;
        }

        [Authorize(Roles ="Korisnik")]
        public override async Task<VMAutomobil> Insert([FromBody] AutomobilInsert req)
        {
            return await base.Insert(req);
        }

        [Authorize(Roles ="Administrator")]
        public override async Task<VMAutomobil> Update(int id, [FromBody] AutomobilUpdate req)
        {
            return await base.Update(id, req);
        }

        [Authorize(Roles = "Administrator")]
        public override async Task Delete(int id)
        {
            await base.Delete(id);
        }

        [Authorize(Roles ="Korisnik")]
        [HttpGet("Aktivni")]
        public async Task<PagedList<VMAutomobil>> GetAktivne([FromQuery]AutomobilSearchObject? search = null)
        {
            return await _service.GetAktivne(search);
        }

      
    }
}
