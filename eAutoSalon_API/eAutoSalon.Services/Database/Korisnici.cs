using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Korisnici
{
    public int KorisnikId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string Username { get; set; } = null!;

    public string PasswordHash { get; set; } = null!;

    public string PasswordSalt { get; set; } = null!;

    public string Email { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public DateTime? RegisteredOn { get; set; }

    public string? Token { get; set; }

    public bool? Isverified { get; set; }

    public string? State { get; set; }

    public virtual ICollection<Komentari> Komentaris { get; set; } = new List<Komentari>();

    public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; } = new List<KorisnikUloge>();

    public virtual ICollection<Novosti> Novostis { get; set; } = new List<Novosti>();

    public virtual ICollection<Recenzije> Recenzijes { get; set; } = new List<Recenzije>();

    public virtual ICollection<TestnaVoznja> TestnaVoznjas { get; set; } = new List<TestnaVoznja>();

    public virtual ICollection<Transakcije> Transakcijes { get; set; } = new List<Transakcije>();

    public virtual ICollection<ZavrseniPoslovi> ZavrseniPoslovis { get; set; } = new List<ZavrseniPoslovi>();
}
