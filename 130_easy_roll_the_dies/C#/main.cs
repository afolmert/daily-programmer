#define CONTRACTS_FULL
using System;
using System.Diagnostics.Contracts;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication2
{

    public struct Dice
    {
        private static Random _random = new Random();

        public int Rolls { get; set; }
        public int Sides { get; set; }

        public Dice(int n, int m)
        {
            Rolls = n;
            Sides = m;

        }

        [ContractInvariantMethod]
        private void ObjectInvariant()
        {
            Contract.Invariant(Rolls >= 1 && Rolls <= 100);
            Contract.Invariant(Sides >= 2 && Sides <= 100);

        }

        public static Dice Parse(string input)
        {
            Contract.Requires(!String.IsNullOrEmpty(input));
            Contract.Requires(input.Length >= 3);
            Contract.Requires(input.ToUpper().Contains('D'));

            string[] parts = input.ToUpper().Split('D');

            Contract.Assert(parts.Length == 2);
            int n = Int32.Parse(parts[0]);
            int m = Int32.Parse(parts[1]);

            return new Dice(n, m);
        }

        public IEnumerable<int> Roll()
        {
            var result = new List<int>();

            for (int i = 0; i < Rolls; i++)
            {
                result.Add(_random.Next(1, Sides + 1));
            }
            return result;
        }
    }


    class Program
    {
        static string ToString<T>(IEnumerable<T> en)
        {
            var sb = new StringBuilder();
            foreach (var e in en)
            {
                sb.Append(e.ToString() + " ");
            }
            return sb.ToString().TrimEnd();
        }

        static void RollDice(string input)
        {
            Dice d = Dice.Parse(input);
            var res = d.Roll();
            Console.WriteLine(input + ": " + ToString(res));
        }

        static void Main(string[] args)
        {
            RollDice("14d2");
            RollDice("2d20");
            RollDice("5d6");
            RollDice("7d3");
            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }
    }
}
