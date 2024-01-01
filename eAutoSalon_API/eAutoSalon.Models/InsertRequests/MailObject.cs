using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class MailObject
    {
        // string mail, string sadrzaj
        [Required(ErrorMessage = "Polje Mail je obavezno")]
        [EmailAddress(ErrorMessage = "Mail mora biti u validnom formatu, npr. ime.prezime@gmail.com")]
        public string? Mail { get; set; }

        [Required(ErrorMessage = "Polje Sadržaj je obavezno")]
        [MinLength(5,ErrorMessage = "Minimalan broj znakova koji morate unijeti je 5")]
        public string? Content { get; set; }
    }
}
