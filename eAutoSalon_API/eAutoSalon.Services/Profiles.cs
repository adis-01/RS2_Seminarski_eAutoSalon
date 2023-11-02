using AutoMapper;
using eAutoSalon.Models;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services
{
    public class Profiles : Profile
    {
        public Profiles()
        {
            CreateMap<Models.Proizvodi, Models.ViewModels.VMProizvodi>();
        }
    }
}
