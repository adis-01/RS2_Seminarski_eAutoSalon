using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class ZavrseniPoslovi
{
    public int Id { get; set; }

    public int? AutomobilId { get; set; }

    public int? KorisnikId { get; set; }

    public int? UposlenikId { get; set; }

    public int Iznos { get; set; }

    public DateTime DatumProdaje { get; set; }

    public bool? IsOnline { get; set; }

    public virtual Automobili? Automobil { get; set; }

    public virtual Korisnici? Korisnik { get; set; }

    public virtual Uposlenici? Uposlenik { get; set; }
}
