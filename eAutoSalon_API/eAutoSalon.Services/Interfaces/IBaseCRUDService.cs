using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IBaseCRUDService<T,TSearch,TInsert,TUpdate> : IBaseGetService<T,TSearch> where T: class where TSearch : class
    {
        Task<T> Insert(TInsert req);
        Task<T> Update(int id,TUpdate req);
        Task Delete(int id);
    }
}
