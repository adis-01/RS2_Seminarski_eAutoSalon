using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IBaseService<T,TFilter> where T : class where TFilter : class
    {
        Task<List<T>> GetAll(TFilter filter = null);
        Task<T> GetById(int id);
    }
}
