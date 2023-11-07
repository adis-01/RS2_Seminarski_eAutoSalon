﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models
{
    public class Proizvodi
    {
        public int ID { get; set; }
        public string Naziv { get; set; }
        public string? SifraProizvoda { get; set; } = null;
        public double? CijenaProizvoda { get; set; } = null;


    }
}