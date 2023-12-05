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
        public string Sadrzaj { get; set; } = null!;
        [Required]
        public string Tip { get; set; } = null!;

        public string? SlikaPath { get; set; }
    }
}
