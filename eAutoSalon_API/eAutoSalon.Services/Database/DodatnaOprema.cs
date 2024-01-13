﻿using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class DodatnaOprema
{
    public int OpremaId { get; set; }

    public bool Klima { get; set; }

    public bool Tempomat { get; set; }

    public bool ParkingSenzori { get; set; }

    public bool ParkingKamera { get; set; }

    public bool ZracniJastuk { get; set; }

    public bool Navigacija { get; set; }

    public bool Abskocinice { get; set; }

    public bool Alarm { get; set; }

    public bool NaslonjacRuka { get; set; }

    public bool Usbport { get; set; }

    public bool Bluetooth { get; set; }

    public bool KomandeVolan { get; set; }

    public bool PodizaciStakala { get; set; }

    public bool StartStop { get; set; }

    public int? AutomobilId { get; set; }

    public virtual Automobili? Automobil { get; set; }
}
