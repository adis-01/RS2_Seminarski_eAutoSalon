using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.UpdateRequests
{
    public class KorisnikPasswordRequest
    {
        [Required]
        public string Stari_Pass { get; set; }
        [Required]
        [Compare("Novi_Pass_Repeat",ErrorMessage = "Novi password i ponovljeni novi password se moraju poklapati")]
        public string Novi_Pass { get; set; }
        [Required]
        [Compare("Novi_Pass", ErrorMessage = "Novi password i ponovljeni novi password se moraju poklapati")]
        public string Novi_Pass_Repeat { get; set; }
    }
}
