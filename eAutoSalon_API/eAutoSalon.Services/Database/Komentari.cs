using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Komentari
{
    public int KomentarId { get; set; }

    public string Sadrzaj { get; set; } = null!;

    public int KorisnikId { get; set; }

    public int NovostiId { get; set; }

    public string State { get; set; } = null!;

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Novosti Novosti { get; set; } = null!;
}
