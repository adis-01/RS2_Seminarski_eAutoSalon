using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Transakcije
{
    public int TransakcijaId { get; set; }

    public string BrojTransakcije { get; set; } = null!;

    public string Iznos { get; set; } = null!;

    public string Valuta { get; set; } = null!;

    public string TipTransakcije { get; set; } = null!;

    public DateTime DatumTransakcije { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Korisnici? Korisnik { get; set; }
}
