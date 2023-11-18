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
        [MinLength(2)]
        [MaxLength(30)]
        public string FirstName { get; set; }
        [Required]
        [MinLength(2)]
        [MaxLength(30)]
        public string LastName { get; set; }
        [Required]
        public string? Username { get; set; }
        [Required]
        public string? Password { get; set; }
        [Required]
        [Compare("Password", ErrorMessage = "Šifre se ne poklapaju.")]
        public string? RepeatPassword { get; set; }
    }
}
