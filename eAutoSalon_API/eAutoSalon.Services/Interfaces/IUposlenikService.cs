﻿using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IUposlenikService : IBaseCRUDService<VMUposlenik,UposlenikSearchObject,UposlenikInsert,UposlenikUpdate>
    {
    }
}