using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class TestnaVoznjaInsert
    {
        public int? AutomobilId { get; set; }

        public int? KorisnikId { get; set; }

        public int? UposlenikId { get; set; }

        public DateTime DatumVrijeme { get; set; }
    }
}
