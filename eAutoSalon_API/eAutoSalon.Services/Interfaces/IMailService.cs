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
        Task StartRabbitMQ(string email);
        void SendToWorker(TestnaVoznjaInsert entity);
        void Contact(MailObject req);
    } 
}
