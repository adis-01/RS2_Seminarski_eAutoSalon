using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace eAutoSalon.RabbitMQ_C
{
    public class Mail
    {
        public static void Send(VMEmail_Token obj)
        {
            string serverAddress = Environment.GetEnvironmentVariable("SERVER_ADDRESS") ?? "smtp.gmail.com";
            string mailSender = Environment.GetEnvironmentVariable("MAIL_SENDER") ?? "eautosalon.verif@gmail.com";
            string mailPass = Environment.GetEnvironmentVariable("MAIL_PASS") ?? "frhaexjyedayript";
            int port = int.Parse(Environment.GetEnvironmentVariable("MAIL_PORT") ?? "587");

            string to = obj.Mail;
            string subject = "Mail Verification";
            string content = $"<p>Poštovani,</p> <br>Hvala Vam na pruženoj prilici i registraciji. Kako biste kompletirali registraciju, potrebno je da iskoristite token u nastavku maila. <br>" +
                                    $"<p>Verifikacijski Token: {obj.Token} </p> <br> <br> <p> S poštovanjem, eAutoSalon </p>";

            SmtpClient client = new SmtpClient(serverAddress)
            {
                Port = port,
                Credentials = new NetworkCredential(mailSender, mailPass),
                EnableSsl = true,
            };

            MailMessage mail = new MailMessage(mailSender, to)
            {
                Subject = subject,
                Body = content,
                IsBodyHtml = true
            };

            try
            {
                Console.WriteLine("ADDRESS: " + serverAddress + "| SENDER: " + mailSender + "| PASS: " + mailPass + "| PORT: " + port.ToString());
                client.Send(mail);
                Console.WriteLine("Mail uspješno poslan na " + obj.Mail);
            }
			catch (Exception ex)
			{
                Console.WriteLine("Error: " + ex.Message);
                Console.WriteLine("StackTrace " + ex.StackTrace);
			}
        }
    }
}
