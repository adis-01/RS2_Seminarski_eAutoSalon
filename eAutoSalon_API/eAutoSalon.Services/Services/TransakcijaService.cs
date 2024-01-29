using AutoMapper;
using eAutoSalon.Models.InsertRequests;
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
    public class TransakcijaService : ITransakcijaService
    {
        private readonly EAutoSalonTestContext _context;
        private readonly IMapper _mapper;

        public TransakcijaService(EAutoSalonTestContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<VMTransakcija> Insert(TransakcijaInsert req)
        {
            Transakcije transakcija = new();
            _mapper.Map(req, transakcija);
            transakcija.DatumTransakcije = DateTime.Now;
            _context.Add(transakcija);
            await _context.SaveChangesAsync();
            return _mapper.Map<VMTransakcija>(req);
        }
    }
}
