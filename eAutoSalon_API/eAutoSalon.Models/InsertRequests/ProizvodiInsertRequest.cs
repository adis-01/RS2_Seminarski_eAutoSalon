using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class ProizvodiInsertRequest
    {
        public int ID { get; set; }
        public string Naziv { get; set; }
        public double? CijenaProizvoda { get; set; } = null;
    }
}
