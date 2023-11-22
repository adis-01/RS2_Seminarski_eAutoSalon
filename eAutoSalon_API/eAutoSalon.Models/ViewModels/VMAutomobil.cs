﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.ViewModels
{
    public class VMAutomobil
    {
        public string BrojSasije { get; set; } = null!;

        public string Boja { get; set; } = null!;

        public int GodinaProizvodnje { get; set; }

        public string SnagaMotora { get; set; } = null!;

        public string VrstaGoriva { get; set; } = null!;

        public int BrojVrata { get; set; }

        public int PredjeniKilometri { get; set; }
    }
}
