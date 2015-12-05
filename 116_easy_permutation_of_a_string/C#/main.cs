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

        static HashSet<string> Permutations(string input)
        {
            if (String.IsNullOrEmpty(input))
                throw new ArgumentNullException(input);

            var result = new HashSet<string>();

            if (input.Length == 1)
                return new HashSet<string> { input };

            string prefix = input.Substring(0, input.Length - 1);
            char suffix = input[input.Length - 1];

            HashSet<string> perfixPerms = Permutations(prefix);

            foreach (string perm in perfixPerms)
            {
                for (int i = 0; i < perm.Length; i++)
                {
                    result.Add(perm.Substring(0, i) + suffix + perm.Substring(i, perm.Length - i));
                }
                result.Add(perm + suffix);
            }

            return result;

        }

        static String ToString<T>(IEnumerable<T> s)
        {
            return String.Join(" ", s.Select(e => $"{e}"));

        }


        static void Main(string[] args)
        {

            var perms = Permutations("abbccc");
            Console.WriteLine(ToString(perms));

            done:


            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }
    }
}
