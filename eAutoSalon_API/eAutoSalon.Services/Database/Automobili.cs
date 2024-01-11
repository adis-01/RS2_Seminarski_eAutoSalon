using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Automobili
{
    public int AutomobilId { get; set; }

    public string BrojSasije { get; set; } = null!;

    public string Boja { get; set; } = null!;

    public int GodinaProizvodnje { get; set; }

    public string SnagaMotora { get; set; } = null!;

    public string VrstaGoriva { get; set; } = null!;

    public int BrojVrata { get; set; }

    public int PredjeniKilometri { get; set; }

    public DateTime? DatumObjave { get; set; }

    public string Proizvodjac { get; set; } = null!;

    public string Model { get; set; } = null!;

    public string State { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public decimal? Cijena { get; set; }

    public virtual ICollection<DodatnaOprema> DodatnaOpremas { get; set; } = new List<DodatnaOprema>();

    public virtual ICollection<TestnaVoznja> TestnaVoznjas { get; set; } = new List<TestnaVoznja>();

    public virtual ICollection<ZavrseniPoslovi> ZavrseniPoslovis { get; set; } = new List<ZavrseniPoslovi>();
}
