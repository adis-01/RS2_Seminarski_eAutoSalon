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
            CreateMap<Automobili, VMAuto_Test>();

            CreateMap<Novosti, VMNovosti>();
            CreateMap<NovostInsert, Novosti>();
            CreateMap<NovostUpdate, Novosti>();
            CreateMap<Novosti, VMClanak_Komentar_Historija>();

            CreateMap<Komentari, VMKomentari>();
            CreateMap<KomentarInsert, Komentari>();
            CreateMap<Komentari, VMKomentar_Historija>();

            CreateMap<Uposlenici, VMUposlenik>();
            CreateMap<UposlenikInsert, Uposlenici>();
            CreateMap<UposlenikUpdate, Uposlenici>();
            CreateMap<Uposlenici, VMUposlenik_Test>();

            CreateMap<DodatnaOprema, VMOprema>();
            CreateMap<DodatnaOpremaInsert, DodatnaOprema>();
            CreateMap<DodatnaOpremaUpdate,DodatnaOprema>();

            CreateMap<TestnaVoznjaInsert,TestnaVoznja>();
            CreateMap<TestnaVoznja,VMTestnaVoznja>();

            CreateMap<Uloge, VMUloga>();
        }
    }
}
