using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Recenzije
{
    public int RecenzijaId { get; set; }

    public int Ocjena { get; set; }

    public string? Komentar { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Korisnici? Korisnik { get; set; }
}
