using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.UpdateRequests
{
    public class AutomobilUpdate
    {
        public int PredjeniKilometri { get; set; }
        public string SnagaMotora { get; set; } = null!;
        public string Proizvodjac { get; set; } = null!;
        public string BrojSasije { get; set; } = null!;
        public string Model { get; set; } = null!;
        public int GodinaProizvodnje { get; set; } 

    }
}
