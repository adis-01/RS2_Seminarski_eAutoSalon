﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Models.SearchObjects
{
    public class SearchObject : BaseSearchObject
    {
        public string? Username { get; set; } 
        public string? FTS { get; set; }  
    }
}
