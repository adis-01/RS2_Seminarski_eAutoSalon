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

        [Authorize(Roles ="Administrator")]
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

        [Authorize(Roles ="Korisnik,Administrator,Urednik")]
        [HttpGet("Recommend/{id}")]
        public List<VMAutomobil> Recommend(int id)
        {
            return  _service.Recommend(id);
        }

        [Authorize(Roles ="Administrator,Korisnik,Urednik")]
        [HttpGet("Aktivni")]
        public async Task<PagedList<VMAutomobil>> GetAktivne([FromQuery]AutomobilSearchObject? search = null)
        {
            return await _service.GetAktivne(search);
        }

        [Authorize(Roles = "Administrator")]
        [HttpGet("Zavrseni")]
        public async Task<PagedList<VMAutomobil>> GetProdane([FromQuery] AutomobilSearchObject? search = null)
        {
            return await _service.GetProdane(search);
        }


        [Authorize(Roles ="Korisnik,Administrator,Urednik")]
        [HttpGet("GetProizvodjace")]
        public async Task<List<string>> GetProizvodjace()
        {
            return await _service.GetProizvodjace();
        }

        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        [HttpGet("GetFiltered")]
        public async Task<PagedList<VMAutomobil>> GetFiltered([FromQuery]AutomobilSearchObject? search = null)
        {
            return await _service.GetFiltered(search);
        }

        [Authorize(Roles = "Administrator")]
        [HttpGet("TotalNumber")]
        public async Task<int> GetTotal()
        {
            return await _service.GetUkupanBrojAktivnihOglasa();
        }
      
    }
}
