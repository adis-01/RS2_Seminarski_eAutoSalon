using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class MailObject
    {
        public string Mail { get; set; }
        public string Content { get; set; }
        public string FullName { get; set; }
    }
}
