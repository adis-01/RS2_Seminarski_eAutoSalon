﻿using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IUlogeService : IBaseGetService<VMUloga,UlogeSearchObject>
    {
    }
}
