using eAutoSalon.Models.ViewModels;
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
            string serverAddress = "smtp.gmail.com";
            string mailSender = "eautosalon.verif@gmail.com";
            string mailPass = "frhaexjyedayript";
            int port = 587;
            string to = obj.Mail;
            string subject = "Mail Verification";
            string content = "Hvala na ukazanoj prilici, vaš verifikacijski token je " + obj.Token;

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
                IsBodyHtml = false
            };

            try
            {
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
