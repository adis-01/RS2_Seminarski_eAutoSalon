using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class NovostInsert
    {
        public string Sadrzaj { get; set; } = null!;

        public string Tip { get; set; } = null!;

        public string? SlikaPath { get; set; }
    }
}
