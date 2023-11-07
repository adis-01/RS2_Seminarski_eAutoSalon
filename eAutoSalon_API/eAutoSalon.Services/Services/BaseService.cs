using eAutoSalon.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class BaseService<T, TFilter> : IBaseService<T,TFilter> where T : class where TFilter : class
    {
        public async Task<List<T>> GetAll(TFilter filter = null)
        {
            throw new NotImplementedException();
        }

        public async Task<T> GetById(int id)
        {
            throw new NotImplementedException();
        }
    }
}
