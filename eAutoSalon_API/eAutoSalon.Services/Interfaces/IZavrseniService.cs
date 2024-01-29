using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IZavrseniService
    {
        Task<List<VMZavrseni_Poslovi>> GetAll(ZavrseniSearchObject? search = null);
        Task<VMZavrseni_Poslovi> Insert(ZavrseniPosaoInsert req);
    }
}
