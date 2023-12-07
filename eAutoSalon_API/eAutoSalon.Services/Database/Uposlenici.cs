﻿using System;
using System.Collections.Generic;

namespace eAutoSalon.Services.Database;

public partial class Uposlenici
{
    public int UposlenikId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string Title { get; set; } = null!;

    public string Kontakt { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public virtual ICollection<ZavrseniPoslovi> ZavrseniPoslovis { get; set; } = new List<ZavrseniPoslovi>();
}