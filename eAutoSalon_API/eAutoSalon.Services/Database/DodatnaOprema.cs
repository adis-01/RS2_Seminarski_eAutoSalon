using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class DodatnaOprema
{
    public int OpremaId { get; set; }

    public string Naziv { get; set; } = null!;

    public string Opis { get; set; } = null!;

    public int? AutomobilId { get; set; }

    public virtual Automobili? Automobil { get; set; }
}
