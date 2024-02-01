using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class VerificationRequest
    {
        public string Email { get; set; }
        public int Token { get; set; }
    }
}
