// See https://aka.ms/new-console-template for more information
using RabbitMQ.Client.Events;
using RabbitMQ.Client;
using System.Text;
using Newtonsoft.Json;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.RabbitMQ_C;

string serverAddress = "smtp-mail.outlook.com";
string mailSender = "eautosalon@outlook.com";
string mailPass = "test_mail_123";
int port = 587;

Console.WriteLine("Hello, World!");

var factory = new ConnectionFactory { HostName = "localhost" };
using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();

channel.QueueDeclare(queue: "hello",
                     durable: false,
                     exclusive: false,
                     autoDelete: false,
                     arguments: null);

Console.WriteLine(" [*] Waiting for messages.");

var consumer = new EventingBasicConsumer(channel);
consumer.Received += (model, ea) =>
{
    var body = ea.Body.ToArray();
    var message = Encoding.UTF8.GetString(body);
    var entitet = JsonConvert.DeserializeObject<VMEmail_Token>(message);

    Mail.Send(entitet);
};
channel.BasicConsume(queue: "hello",
                     autoAck: true,
                     consumer: consumer);

Console.WriteLine(" Press [enter] to exit.");
Console.ReadLine();