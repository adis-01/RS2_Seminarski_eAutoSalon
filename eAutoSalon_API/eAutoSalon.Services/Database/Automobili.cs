using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Automobili
{
    public int AutomobilId { get; set; }

    public string BrojSasije { get; set; } = null!;

    public string Boja { get; set; } = null!;

    public int GodinaProizvodnje { get; set; }

    public string SnagaMotora { get; set; } = null!;

    public string VrstaGoriva { get; set; } = null!;

    public int BrojVrata { get; set; }

    public int PredjeniKilometri { get; set; }
}
