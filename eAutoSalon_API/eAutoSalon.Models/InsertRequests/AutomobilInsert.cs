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
        [MaxLength(17,ErrorMessage ="Broj šasije mora imati tačno 17 znakova"),MinLength(17,ErrorMessage ="Broj šasije mora imati tačno 17 znakova")]
        public string BrojSasije { get; set; } = null!;
        [Required]
        [RegularExpression("[a-zA-Z]",ErrorMessage ="Samo tekst, nisu dozvoljeni brojevi")]
        public string Boja { get; set; } = null!;
        [Required]
        [RegularExpression("[0-9]",ErrorMessage ="Samo brojevi, tekst nije dozvoljen")]
        public int GodinaProizvodnje { get; set; }
        [Required]
        public string SnagaMotora { get; set; } = null!;
        [Required]
        public string VrstaGoriva { get; set; } = null!;
        [Required]
        [Range(2,9, ErrorMessage ="Molimo unesite validan broj, minimalno 2, maksimalno 9")]
        public int BrojVrata { get; set; }
        [Required]
        public int PredjeniKilometri { get; set; }
        [Required]
        [MinLength(3,ErrorMessage = "Marka automobila mora imati minimalno 3 slova"),MaxLength(30,ErrorMessage = "Marka automobila može imati maksimalno 30 slova")]
        public string Proizvodjac { get; set; } = null!;
        [Required]
        [MaxLength(15, ErrorMessage = "Marka automobila može imati maksimalno 15 slova")]
        public string Model { get; set; } = null!;
    }
}
