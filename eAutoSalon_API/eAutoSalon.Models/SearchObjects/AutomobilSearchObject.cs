using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.SearchObjects
{
    public class AutomobilSearchObject : BaseSearchObject
    {
        public string? Boja { get; set; } = null!;
        public int? GodinaProizvodnje { get; set; }
        public string? VrstaGoriva { get; set; } = null!;
        public int? BrojVrata { get; set; }
        public string? FTS { get; set; }
    }
}
