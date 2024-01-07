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
        
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Title { get; set; } = null!;
        public string Kontakt { get; set; } = null!;
        public string? SlikaBase64 { get; set; } = null!;
    }
}
