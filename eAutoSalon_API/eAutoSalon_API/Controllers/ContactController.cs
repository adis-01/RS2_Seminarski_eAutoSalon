using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eAutoSalon_API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize(Roles ="Korisnik")]
    public class ContactController : ControllerBase
    {
        IMailService _service;
        public ContactController(IMailService service)
        {
            _service = service;
        }

        [HttpPost("SendMailSupport")]
        public void SendMailSupport([FromBody] MailObject req)
        {
            _service.Contact(req);
        }
    }
}
