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

        static IEnumerable<int> Factorize(int number)
        {
            List<int> result = new List<int>();

            int factor = 2;
            while (number > 1)
            {
                if (number % factor == 0)
                {
                    result.Add(factor);
                    number = number / factor;
                }
                else
                {
                    factor++;
                }

            }
            return result;
        }

        static void Do(int number)
        {
            var result = Factorize(number);
            string[] factors = result.Select(i => i.ToString()).ToArray();
            Console.WriteLine(number + " = " + string.Join(" * ", factors));

        }

        static void Main(string[] args)
        {
            Do(12);
            Do(14);
            Do(20);


            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }

    }
}
