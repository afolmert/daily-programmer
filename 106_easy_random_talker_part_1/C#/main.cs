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


        const string Text = @" Your program will be responsible for analyzing a small chunk of text, the text of this entire dailyprogrammer 
            description.Your task is to output the distinct words in this description, from highest to lowest count with the number 
            of occurrences for each.Punctuation will be considered as separate words where they are not a part of the word.

            The following will be considered their own words:  . , : ; ! ? ( ) [ ] { }

            For anything else, consider it as part of a word.

           Extra Credit:

            Process the text of the ebook Metamorphosis, by Franz Kafka and determine the top 10 most frequently used words and their counts. 
            (This will help for part 2)";

        static Dictionary<string, int> freq = new Dictionary<string, int>();

        static void IncFreq(Dictionary<string, int> freq, string word)
        {
            if (freq.ContainsKey(word))
            {
                freq[word] += 1;
            }
            else
            {
                freq[word] = 1;

            }

        }


        static void DumpFreq(Dictionary<string, int> freq)
        {
            var list = freq.Select(v => Tuple.Create(v.Value, v.Key)).ToList();

            foreach (var el in list)
            {
                Console.WriteLine(el);

            }
            list.Sort((t1, t2) => t2.Item1.CompareTo(t1.Item1));

            foreach (var t in list)
            {
                Console.WriteLine(t.Item1 + ": " + t.Item2);

            }
        }

        static List<string> ParseText(string text)
        {
            var punctuation = new HashSet<char> { '.', ',', ':', ';', '!', '?', '(', ')', '[', ']', '{', '}' };
            var result = new List<string>();
            var current = "";

            foreach (var c in text)
            {
                if (Char.IsWhiteSpace(c) || punctuation.Contains(c))
                {

                    if (!String.IsNullOrEmpty(current))
                    {
                        result.Add(current);
                        current = "";

                    }

                    if (punctuation.Contains(c))
                        result.Add(c.ToString());

                } else
                {
                    current += c;
                }

            }

            if (!String.IsNullOrEmpty(current))
            {
                result.Add(current);
            }

            return result;

        }


        static void Main(string[] args)
        {

            List<string> words = ParseText(Text);
            Console.WriteLine("Listing all words ");
            foreach (var w in words)
            {
                Console.Write(w);
                Console.Write(" ** ");

                IncFreq(freq, w);

            }

            DumpFreq(freq);

            done:


            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }
    }
}
