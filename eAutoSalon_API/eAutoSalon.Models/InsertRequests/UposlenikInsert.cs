using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class UposlenikInsert
    {
        [Required]
        [MinLength(3,ErrorMessage = "Ime mora sadržavati minimalno 3 slova"), MaxLength(30, ErrorMessage = "Ime može sadržavati maksimalno 30 znakova")]
        public string FirstName { get; set; } = null!;
        [Required]
        [MinLength(3,ErrorMessage = "Prezime mora sadržavati minimalno 3 slova"), MaxLength(40,ErrorMessage = "Prezime može sadržavati maksimalno 40 znakova")]
        public string LastName { get; set; } = null!;
        [Required]
        public string Title { get; set; } = null!;
        [Required]
        public string Kontakt { get; set; } = null!;
        public string? SlikaBase64 { get; set; } = null!;
    }
}
