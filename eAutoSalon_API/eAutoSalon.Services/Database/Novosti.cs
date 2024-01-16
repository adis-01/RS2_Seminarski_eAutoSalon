using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Novosti
{
    public int NovostiId { get; set; }

    public string Sadrzaj { get; set; } = null!;

    public string Tip { get; set; } = null!;

    public string Naslov { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public int? KorisnikId { get; set; }

    public DateTime? DatumObjave { get; set; }

    public virtual ICollection<Komentari> Komentaris { get; set; } = new List<Komentari>();

    public virtual Korisnici? Korisnik { get; set; }
}
