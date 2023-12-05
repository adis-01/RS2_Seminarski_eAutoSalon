using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Interfaces;
using Newtonsoft.Json;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.Services.Services
{
    public class MailService : IMailService
    {
        
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
