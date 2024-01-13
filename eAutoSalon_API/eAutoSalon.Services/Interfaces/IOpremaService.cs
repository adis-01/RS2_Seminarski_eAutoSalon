using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IOpremaService 
    {
        public Task<VMOprema> GetOprema(int automobilId);
        public Task<VMOprema> Insert(DodatnaOpremaInsert req);
    }
}
