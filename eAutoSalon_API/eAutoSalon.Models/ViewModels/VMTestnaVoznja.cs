using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMTestnaVoznja
    {
        public int TestnaVoznjaId { get; set; }
        public DateTime DatumVrijeme { get; set; }

        public string Status { get; set; } = null!;

        public virtual VMAuto_Test? Automobil { get; set; }

        public virtual VMKorisnik_Komentar? Korisnik { get; set; }

        public virtual VMUposlenik_Test? Uposlenik { get; set; }
    }
}
