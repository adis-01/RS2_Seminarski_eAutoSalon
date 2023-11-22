using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMKorisnikUloga
    {
        public int KorisnikUlogeId { get; set; }
        public virtual VMUloga Uloga { get; set; } = null!;
    }
}
