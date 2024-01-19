using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMRecenzije
    {
        public int RecenzijaId { get; set; }

        public int Ocjena { get; set; }

        public string? Komentar { get; set; }

        public virtual VMRecenzija_Korisnik? Korisnik { get; set; }
    }
}
