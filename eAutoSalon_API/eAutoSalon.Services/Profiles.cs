using AutoMapper;
using eAutoSalon.Models;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
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
            CreateMap<Korisnici, VMKorisnik>();
            CreateMap<KorisnikInsert, Korisnici>();
            CreateMap<KorisnikUpdate, Korisnici>();
            CreateMap<Korisnici, VMKorisnik_Komentar>();
            CreateMap<KorisnikUloge, VMKorisnikUloga>();

            CreateMap<Automobili, VMAutomobil>();
            CreateMap<AutomobilInsert, Automobili>();
            CreateMap<AutomobilUpdate, Automobili>();

            CreateMap<Novosti, VMNovosti>();
            CreateMap<NovostInsert, Novosti>();
            CreateMap<NovostUpdate, Novosti>();

            CreateMap<Komentari, VMKomentari>();
            CreateMap<KomentarInsert, Komentari>();

            CreateMap<Uloge, VMUloga>();
        }
    }
}
