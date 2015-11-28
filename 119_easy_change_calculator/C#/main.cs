#define CONTRACTS_FULL
using System;
using System.Diagnostics.Contracts;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication2
{


    class Program
    {

        static bool IsNumeric(string s)
        {
            return !String.IsNullOrEmpty(s) && s.All(c => Char.IsDigit(c) || c == '.');
        }


        static Tuple<int, string> t(int i, string s)
        {
            return new Tuple<int, string>(i, s);

        }

        static void CalculateChange(string money)
        {
            Contract.Requires(!String.IsNullOrEmpty(money));
            Contract.Requires(IsNumeric(money));
            Contract.Requires(!money.Contains('.') 
                                 || (money.Contains('.') && money.IndexOf('.') >= money.Length - 3));

            Tuple<int, string>[] coins = { t(25, "quarters"), t(10, "dimes"), t(5, "nickels"), t(1, "pennies") };

            int amount = (int)(Double.Parse(money) * 100);

            foreach (var c in coins)
            {
                Console.WriteLine(amount / c.Item1 + " " + c.Item2);
                amount = amount % c.Item1;

            }
        }

        static void Main(string[] args)
        {
            CalculateChange("1.23");
            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }
    }
}
