using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMKomentari
    {
        public int KomentarId { get; set; }
        public string Sadrzaj { get; set; } = null!;

        public virtual VMKorisnik_Komentar Korisnik { get; set; } = null!;

    }
}
