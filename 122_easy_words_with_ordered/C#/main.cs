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

        static IList<string> ReadLines(string filepath)
        {
            var result = new List<string>();
            string line = "";

            if (File.Exists(filepath))
            {
                StreamReader file = null;
                try
                {
                    file = new StreamReader(filepath);
                    while ((line = file.ReadLine()) != null)
                    {
                        result.Add(line);

                    }

                }
                finally
                {
                    if (file != null)
                        file.Close();

                }

            }
            return result;

        }



        static bool Matches(string word)
        {
            var allowed = new HashSet<char>() { 'a', 'e', 'i', 'o', 'u', 'y' };
            var word2 = new String(word.Where(c => allowed.Contains(c)).ToArray());
            return "aeiouy".Equals(word2);


        }

        static void Main(string[] args)
        {
            string filepath = "c:/Users/folmead1/OneDrive/CodeKatas/Practice/DailyProgrammer/Tasks/122_easy_words_with_ordered/words.txt";

            IList<string> words = ReadLines(filepath);

            var i = 0;

            foreach (string word in words)
            {
                if (Matches(word))
                    Console.WriteLine(word);
            }

            done:
            

                Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }
    }
}
