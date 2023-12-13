using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class TestnaVoznja
{
    public int TestnaVoznjaId { get; set; }

    public int? AutomobilId { get; set; }

    public int? KorisnikId { get; set; }

    public int? UposlenikId { get; set; }

    public DateTime DatumVrijeme { get; set; }

    public string Status { get; set; } = null!;

    public virtual Automobili? Automobil { get; set; }

    public virtual Korisnici? Korisnik { get; set; }

    public virtual Uposlenici? Uposlenik { get; set; }
}
