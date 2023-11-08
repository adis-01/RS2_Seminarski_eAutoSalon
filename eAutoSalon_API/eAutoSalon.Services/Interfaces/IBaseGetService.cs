using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IBaseGetService<T,TSearch> where T : class where TSearch : class
    {
        Task<List<T>> GetAll(TSearch? search = null);
        Task<T> GetById(int id);
    }
}
