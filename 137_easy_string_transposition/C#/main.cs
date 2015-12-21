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

        static void Transpose(params string[] lines)
        {
            int maxLength = lines.Select(l => l.Length).Max();

            for (int row = 0; row < maxLength; row++)
            {
                foreach (string line in lines)
                {
                    if (row < line.Length)
                        Console.Write(line[row]);
                    else
                        Console.Write(' ');
                }
                Console.WriteLine();

            }
        }

        static void Main(string[] args)
        {


            Transpose("Kernel", "Microcontroller", "Register", "Memory", "Operator");

            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }

    }
}
