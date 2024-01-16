using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMNovosti
    {
        public int NovostiId { get; set; }
        public string Naslov { get; set; }
        public string Sadrzaj { get; set; } = null!;
        public DateTime DatumObjave { get; set; } 

        public string Tip { get; set; } = null!;

    }
}
