﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class KorisnikInsert
    {
        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? Username { get; set; }
        public string? Password { get; set; }

        public string? RepeatPassword { get; set; }

        public string? Email { get; set; }
        public string? SlikaBase64 { get; set; }
    }
}
