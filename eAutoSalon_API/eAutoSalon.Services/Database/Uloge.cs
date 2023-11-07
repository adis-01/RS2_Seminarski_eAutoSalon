using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Uloge
{
    public int UlogaId { get; set; }

    public string NazivUloge { get; set; } = null!;

    public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; } = new List<KorisnikUloge>();
}
