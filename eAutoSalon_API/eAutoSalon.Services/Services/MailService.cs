using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Newtonsoft.Json;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class MailService : IMailService
    {
       private readonly string serverAddress = "smtp.gmail.com";
       private readonly string mailSender = "eautosalon.verif@gmail.com";
       private readonly string mailPass = "frhaexjyedayript";
       private readonly int port = 587;

        public async Task Contact(MailObject req)
        {
            string content = $"<p>From: <b>{req.FullName}</b> | Mail Address: <b>{req.Mail}</b>,</p><br><p>{req.Content}</p>";
            string subject = "Contact Us Customer Support Form";


            var message = new MailMessage()
            {
               From = new MailAddress(req.Mail),
               To = { new MailAddress("eautosalon.verif@gmail.com") },
               Subject = subject,
               Body = content,
               IsBodyHtml = true
            };

            var smtpClient = new SmtpClient(serverAddress, port)
            {
                Credentials = new NetworkCredential(mailSender,mailPass),
                EnableSsl = true
            };

            try
            {
                await smtpClient.SendMailAsync(message);
                Console.WriteLine("Mail sent");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex?.Message);
            }
        }

  

    
        public void StartRabbitMQ(VMEmail_Token obj)
        {
            var factory = new ConnectionFactory { HostName = "localhost" };
            
            using var connection = factory.CreateConnection();
            using var channel = connection.CreateModel();

            channel.QueueDeclare(queue: "email_sending",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);
            


            
            var body = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(obj));

            channel.BasicPublish(exchange: string.Empty,
                                 routingKey: "email_sending",
                                 basicProperties: null,
                                 body: body);
        }




    }
}
