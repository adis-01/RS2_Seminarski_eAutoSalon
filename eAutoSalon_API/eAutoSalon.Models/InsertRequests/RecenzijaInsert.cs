using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class RecenzijaInsert
    {
        public int Ocjena { get; set; }

        public string? Komentar { get; set; } = null!;

        public int KorisnikId { get; set; }
    }
}
