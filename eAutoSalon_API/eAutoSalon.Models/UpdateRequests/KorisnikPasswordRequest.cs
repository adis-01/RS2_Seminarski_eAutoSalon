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
        
        public string Stari_Pass { get; set; }
        public string Novi_Pass { get; set; }
        public string Novi_Pass_Repeat { get; set; }
    }
}
