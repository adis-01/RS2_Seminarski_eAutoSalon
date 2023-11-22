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

    public string? SlikaPath { get; set; }

    public virtual ICollection<Komentari> Komentaris { get; set; } = new List<Komentari>();

    public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; } = new List<KorisnikUloge>();
}
