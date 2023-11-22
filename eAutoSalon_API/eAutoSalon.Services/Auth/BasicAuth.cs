using eAutoSalon.Services.Interfaces;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Auth
{
    public class BasicAuth : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        IKorisnikService _service;
        public BasicAuth(IKorisnikService service,IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock) : base(options, logger, encoder, clock)
        {
            _service = service;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.ContainsKey("Authorization"))
                return AuthenticateResult.Fail("Missing headers");

            var header = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
            var credByte = Convert.FromBase64String(header.Parameter);
            var creds = Encoding.UTF8.GetString(credByte).Split(":");

            var username = creds[0];
            var password = creds[1];

            var user = await _service.Login(username,password);

            if (user == null)
                return AuthenticateResult.Fail("Username and/or password incorrect");

            else
            {

                var claims = new List<Claim>()
                {
                    new Claim(ClaimTypes.Name,user.FirstName),
                    new Claim(ClaimTypes.NameIdentifier,user.Username)
                };

                foreach(var rola in user.KorisnikUloges)
                {
                    claims.Add(new Claim(ClaimTypes.Role, rola.Uloga.Naziv));
                }

                var claimsIdentity = new ClaimsIdentity(claims);
                var principal = new ClaimsPrincipal(claimsIdentity);
                var ticket = new AuthenticationTicket(principal,Scheme.Name);
                return AuthenticateResult.Success(ticket);
            }

        }
    }
}
