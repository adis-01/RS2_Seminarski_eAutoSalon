using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMTransakcija
    {
        public string BrojTransakcije { get; set; } = null!;

        public string Iznos { get; set; } = null!;

        public string Valuta { get; set; } = null!;

        public string TipTransakcije { get; set; } = null!;
    }
}
