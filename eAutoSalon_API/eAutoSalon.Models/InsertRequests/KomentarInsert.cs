﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.InsertRequests
{
    public class KomentarInsert
    {
        public string Sadrzaj { get; set; } = null!;
        public string State { get; set; } = null!;

        public int KorisnikId { get; set; }

        public int NovostiId { get; set; }
    }
}
