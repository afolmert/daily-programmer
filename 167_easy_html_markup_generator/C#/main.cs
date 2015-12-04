#define CONTRACTS_FULL
using System;
using System.Diagnostics.Contracts;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace ConsoleApplication2
{
    class Program
    {

        static string GeneratePage(string title, string paragraph)
        {
            var sb = new StringBuilder();

            sb.Append($"!<DOCTYPE html>\n<html>\n\t<head>\n\t\t<title>{title}</title>\n\t</head>\n");
            sb.Append($"\n\t<body>\n\t\t<p>{paragraph}</p>\n\t</body>\n");
            sb.Append("</html>");

            return sb.ToString();

        }

        static void Main(string[] args)
        {
            Console.WriteLine("Enter your paragraph: ");
            string paragraph = Console.ReadLine();

            Console.WriteLine("Enter your title: ");
            string title = Console.ReadLine();

            string page = GeneratePage(title, paragraph);

            Console.WriteLine("Your page is :");
            Console.WriteLine(page);

            done:
            

                Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }
    }
}
