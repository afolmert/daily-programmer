#define CONTRACTS_FULL
using System;
using System.Diagnostics.Contracts;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;

namespace ConsoleApplication2
{

    class IndexedString
    {
        private string[] _words;

        public string this[int key]
        {
            get
            {
                if (key < 0 || key >= _words.Length)
                {
                    return "";

                }
                else
                {
                    return _words[key];

                }

            }

        }

        public IndexedString(string input)
        {
            var regex = new Regex("[^A-Za-z]+");
            _words = regex.Split(input);

        }

    }


    class Program
    {


        static void Main(string[] args)
        {
            Console.WriteLine("Hello world ");


            var a = new IndexedString("hello world ");

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine(i + ": " + a[i]);
            }


            var b = new IndexedString("...You...!!!@!3124131212 Hello have this is a --- string Solved " + 
                "!!...? to test @\n\n\n#!#@#@%$**#$@ Congratz this!!!!!!!!!!!!!!!!one ---Problem\n\n");

            for (int i = 0; i < 20; i++)
            {
                Console.WriteLine(i + ": " + b[i]);

            }

            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }

    }
}
