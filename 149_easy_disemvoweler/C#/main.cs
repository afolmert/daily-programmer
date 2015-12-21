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

        static Tuple<string, string> Disemvowel(string input)
        {
            Regex r1 = new Regex("[aeoi ]+");
            Regex r2 = new Regex("[^aeoi]+");
            return Tuple.Create(r1.Replace(input, ""), r2.Replace(input, ""));
        }

        static void Main(string[] args)
        {

            var result = Disemvowel("two drums and a cymbal fall off a cliff");
            Console.WriteLine(result);


            result = Disemvowel("did you hear about the excellent farmer who was outstanding in his field");
            Console.WriteLine(result);

            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }

    }
}
