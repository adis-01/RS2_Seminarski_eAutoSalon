using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class KorisnikUloge
{
    public int KorisnikUlogeId { get; set; }

    public int UlogaId { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Uloge Uloga { get; set; } = null!;
}
