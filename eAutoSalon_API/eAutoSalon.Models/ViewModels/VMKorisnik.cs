using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMKorisnik
    {
        public int KorisnikId { get; set; }
        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string Username { get; set; } = null!;
        public string Email { get; set; } = null!;
        public byte[] Slika { get; set; } = null!;
        public DateTime? RegisteredOn { get; set; }

        public virtual ICollection<VMKorisnikUloga> KorisnikUloges { get; set; } = new List<VMKorisnikUloga>();
    }
}
