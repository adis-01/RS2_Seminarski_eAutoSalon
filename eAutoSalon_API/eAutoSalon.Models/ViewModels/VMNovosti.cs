using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMNovosti
    {
        public string Sadrzaj { get; set; } = null!;

        public string Tip { get; set; } = null!;

        public string? SlikaPath { get; set; } = null!;
    }
}
