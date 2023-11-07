using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class KorisnikUloge
{
    public int KorisnikUlogeId { get; set; }

    public int KuKorisnikId { get; set; }

    public int KuUlogaId { get; set; }

    public virtual Korisnici KuKorisnik { get; set; } = null!;

    public virtual Uloge KuUloga { get; set; } = null!;
}
