using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Interfaces
{
    public interface IMailService
    {
        void StartRabbitMQ(VMEmail_Token obj);
        Task Contact(MailObject req);
    } 
}
