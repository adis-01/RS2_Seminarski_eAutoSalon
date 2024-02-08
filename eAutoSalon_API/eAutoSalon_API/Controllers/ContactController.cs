using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ContactController : ControllerBase
    {
        IMailService _service;
        public ContactController(IMailService service)
        {
            _service = service;
        }

        [HttpPost("ContactPage")]
        [Authorize(Roles = "Korisnik,Administrator,Urednik")]
        public async Task SendMailSupport([FromBody] MailObject req)
        {
           await _service.Contact(req);
        }
    }
}
