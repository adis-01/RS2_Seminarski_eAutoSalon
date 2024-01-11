using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class AutomobilInsert
    {
       
        public string BrojSasije { get; set; } = null!;
        public string Boja { get; set; } = null!;
        public int GodinaProizvodnje { get; set; }
        public string SnagaMotora { get; set; } = null!;
        public string VrstaGoriva { get; set; } = null!;
        public int BrojVrata { get; set; }
        public int PredjeniKilometri { get; set; }
        public string Proizvodjac { get; set; } = null!;
        public string Model { get; set; } = null!;
        public string? slikaBase64 { get; set; } = null!;
        public decimal Cijena { get; set; }
    }
}
