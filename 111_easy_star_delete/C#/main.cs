#define CONTRACTS_FULL
using System;
using System.Diagnostics.Contracts;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;
using System.Media;

namespace ConsoleApplication2
{


    class Program
    {

        static string RemoveStars(string input)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < input.Length; i++)
            {
                if (input[i] == '*' ||
                        (i > 0 && input[i - 1] == '*') ||
                        (i < input.Length - 1 && input[i + 1] == '*'))
                    continue;
                sb.Append(input[i]);

            }
            return sb.ToString();

        }

        static string RemoveStars2(string input)
        {
            Regex r = new Regex(@".?\*+.?");
            return r.Replace(input, "");
        }

        static void Main(string[] args)
        {

            Console.WriteLine(RemoveStars("adf*lp"));
            Console.WriteLine(RemoveStars2("adf*lp"));
            Console.WriteLine(RemoveStars("a*o"));
            Console.WriteLine(RemoveStars2("a*o"));
            Console.WriteLine(RemoveStars("*dech*"));
            Console.WriteLine(RemoveStars2("*dech*"));
            Console.WriteLine(RemoveStars("de**po"));
            Console.WriteLine(RemoveStars2("de**po"));

            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }

    }
}
