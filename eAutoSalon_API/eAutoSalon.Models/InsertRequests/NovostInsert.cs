using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class NovostInsert
    {
        [Required]
        [MinLength(5,ErrorMessage = "Naslov mora imati minimalno 5 znakova")]
        [MaxLength(30,ErrorMessage = "Naslov može imati maksimalno 30 znakova")]
        public string Naslov { get; set; }
        [Required]
        public string Sadrzaj { get; set; } = null!;
        [Required]
        public string Tip { get; set; } = null!;

    }
}
