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
        [Required]
        [EmailAddress]
        public string? Mail { get; set; }

        [Required]
        [MinLength(5,ErrorMessage = "Minimalan broj znakova koji morate unijeti je 5")]
        public string? Content { get; set; }
    }
}
