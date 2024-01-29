using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMZavrseni_Poslovi
    {
        public DateTime DatumProdaje { get; set; }
        public virtual VMAuto_Test? Automobil { get; set; }
        public virtual VMKorisnik_Komentar? Korisnik { get; set; }
        public double Iznos { get; set; }
    }
}
