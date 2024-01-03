using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMUposlenik
    {
        public int UposlenikId { get; set; }
        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string Title { get; set; } = null!;

        public string Kontakt { get; set; } = null!;
    }
}
