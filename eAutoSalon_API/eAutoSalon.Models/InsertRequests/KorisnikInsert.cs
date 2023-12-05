using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class KorisnikInsert
    {
        [Required]
        [MinLength(2,ErrorMessage ="Ime mora sadržavati minimalno 2 slova")]
        [MaxLength(40, ErrorMessage = "Ime mora sadržavati maksimalno 40 slova")]
        public string? FirstName { get; set; }

        [Required]
        [MinLength(2, ErrorMessage = "Prezime mora sadržavati minimalno 2 slova")]
        [MaxLength(60, ErrorMessage = "Prezime mora sadržavati maksimalno 60 slova")]
        public string? LastName { get; set; }

        [Required]
        [MinLength(5, ErrorMessage ="Korisničko ime ne smije biti kraće od 5 znakova"),MaxLength(20, ErrorMessage = "Korisničko ime ne smije biti duže od 20 znakova")]
        [RegularExpression(@"^[a-zA-Z][a-zA-Z0-9_.]*$", ErrorMessage = "Nevažeće korisničko ime, mora počinjati slovom, može sadržavati slova i brojeve, te znakove '.' i '_'.")]
        public string? Username { get; set; }

        [Required]
        [MinLength(5, ErrorMessage ="Lozinka mora biti duža od 5 znakova")]
        public string? Password { get; set; }

        [Required]
        [MinLength(5,ErrorMessage ="Lozinka mora biti duža od 5 znakova")]
        [Compare("Password", ErrorMessage = "Šifre se ne poklapaju.")]
        public string? RepeatPassword { get; set; }

        [EmailAddress (ErrorMessage = "Nepravilna email adresa")]
        [Required]
        public string? Email { get; set; }
        public string? SlikaBase64 { get; set; }
    }
}
