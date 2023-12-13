using eAutoSalon.Models.InsertRequests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface ITestnaVoznjaService
    {
        List<string> GetDostupne(int id, DateTime datum);
        Task Insert(TestnaVoznjaInsert req);
        Task Complete(int id);
        Task Cancel(int id);
    }
}
