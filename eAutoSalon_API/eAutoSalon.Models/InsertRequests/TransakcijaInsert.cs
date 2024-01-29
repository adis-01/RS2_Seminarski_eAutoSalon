using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class TransakcijaInsert
    {
        public string BrojTransakcije { get; set; } = null!;

        public string Iznos { get; set; } = null!;

        public string Valuta { get; set; } = null!;

        public string TipTransakcije { get; set; } = null!;
        public int KorisnikId { get; set; }
    }
}
