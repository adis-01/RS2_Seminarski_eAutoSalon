using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMZavrseniWithSum
    {
        public List<VMZavrseni_Poslovi> Zavrseni { get; set; }
        public decimal Sum { get; set; }    
    }
}
