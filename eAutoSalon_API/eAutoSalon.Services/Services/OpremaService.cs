using AutoMapper;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class OpremaService : IOpremaService
    {
        private readonly EAutoSalonTestContext _context;
        private readonly IMapper _mapper;
        public OpremaService(EAutoSalonTestContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<VMOprema> GetOprema(int automobilId)
        {
            var entity = await _context.DodatnaOpremas.Where(x => x.AutomobilId == automobilId).FirstOrDefaultAsync();

            if(entity == null)
            {
                throw new Exception("Nema objekta sa tim id-om");
            }

            return _mapper.Map<VMOprema>(entity);
        }

        public async Task<VMOprema> Insert(DodatnaOpremaInsert req)
        {
            var entity = new DodatnaOprema();
            _mapper.Map(req,entity);
            await _context.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<VMOprema>(entity);
        }
    }
}
