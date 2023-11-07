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

    public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; } = new List<KorisnikUloge>();
}
