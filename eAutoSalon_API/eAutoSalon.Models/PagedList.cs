using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services
{
    public class PagedList<T>
    {
        public List<T> List { get; set; }
        public int? PageCount { get; set; }
        public int? TotalPages { get; set; }
    }
}
