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
        [Required]
        public string BrojSasije { get; set; } = null!;
        [Required]
        public string Boja { get; set; } = null!;
        [Required]
        public int GodinaProizvodnje { get; set; }
        [Required]
        public string SnagaMotora { get; set; } = null!;
        [Required]
        public string VrstaGoriva { get; set; } = null!;
        [Required]
        public int BrojVrata { get; set; }
        [Required]
        public int PredjeniKilometri { get; set; }
    }
}
