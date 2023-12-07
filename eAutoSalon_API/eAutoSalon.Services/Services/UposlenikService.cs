using AutoMapper;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class UposlenikService : BaseCRUDService<VMUposlenik, Uposlenici, UposlenikSearchObject, UposlenikInsert, UposlenikUpdate>, IUposlenikService
    {
        public UposlenikService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override async Task BeforeInsert(UposlenikInsert? req, Uposlenici entity)
        {
            if (req?.SlikaBase64 != null)
                entity.Slika = Convert.FromBase64String(req.SlikaBase64);
        }
    }
}
