﻿using eAutoSalon.Models.InsertRequests;
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
        void StartRabbitMQ(string email);
        Task Contact(MailObject req);
    } 
}
