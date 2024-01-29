using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class ZavrseniPosaoInsert
    {
        public double Iznos { get; set; }
        public bool? IsOnline { get; set; }
        public int? KorisnikId { get; set; }
        public int? AutomobilId { get; set; }
    }
}
