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
        public string Naslov { get; set; }
        public string Sadrzaj { get; set; } = null!;
        public string Tip { get; set; } = null!;

    }
}
