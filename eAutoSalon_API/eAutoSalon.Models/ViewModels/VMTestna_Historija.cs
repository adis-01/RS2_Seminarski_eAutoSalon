using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMTestna_Historija
    {
        public DateTime DatumVrijeme { get; set; }
        public string Status { get; set; } = null!;
        public virtual VMUposlenik_Test? Uposlenik { get; set; }
        public virtual VMAuto_Test? Automobil { get; set; }
    }
}
