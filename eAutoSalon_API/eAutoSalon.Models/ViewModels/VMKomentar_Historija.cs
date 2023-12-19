using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMKomentar_Historija
    {
        public string? Sadrzaj { get; set; }
        public VMClanak_Komentar_Historija? Novosti { get; set; }
    }
}
