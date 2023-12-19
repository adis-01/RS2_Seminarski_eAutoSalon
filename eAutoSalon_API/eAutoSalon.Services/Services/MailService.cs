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

        public void Contact(MailObject req)
        {
            string sender = req.Mail!;
            string content = req.Content!;
            string subject = "Mail Service Customer Support";

            SmtpClient client = new (serverAddress)
            {
                Port = port,
                Credentials = new NetworkCredential(mailSender, mailPass),
                EnableSsl = true,
            };

            MailMessage mailing = new (mailSender, sender)
            {
                Subject = subject,
                Body = content,
                IsBodyHtml = false
            };

            try
            {
                client.Send(mailing);
                Console.WriteLine("Mail sent");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex?.Message);
            }
        }

        public void SendToWorker(TestnaVoznjaInsert entity)
        {
            //TODO
            throw new NotImplementedException();
        }


        public async Task StartRabbitMQ(string email)
        {
            var factory = new ConnectionFactory { HostName = "localhost" };
            
            using var connection = factory.CreateConnection();
            using var channel = connection.CreateModel();

            channel.QueueDeclare(queue: "hello",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);

            VMEmail_Token obj = new VMEmail_Token()
            {
                Mail = email,
                Token = "game is the game"
            };

            string message = "Pozvana GET metoda " + DateTime.Now.ToString();
            var body = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(obj));

            channel.BasicPublish(exchange: string.Empty,
                                 routingKey: "hello",
                                 basicProperties: null,
                                 body: body);
        }

        
    }
}
