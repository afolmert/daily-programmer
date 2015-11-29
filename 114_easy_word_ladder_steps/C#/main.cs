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
        static bool AreNext(string w1, string w2)
        {
            Contract.Requires(w1 != null);
            Contract.Requires(w2 != null);
            Contract.Requires(w1.Length == w2.Length);

            bool diffFound = false;
            for (int i = 0; i < w1.Length; i++)
            {
                if (w1[i] != w2[i])
                {
                    if (diffFound)
                        return false;
                    else
                        diffFound = true;
                }
            }
            return diffFound;

        }

        static string ToString<T>(IEnumerable<T> en)
        {
            return String.Join("", en.Select(e => String.Format("{0} ", e)).ToArray<string>()); 
        }

        static IList<string> GetNextWordsSlow(string word, HashSet<string> wordSet)
        {
            var result = new List<string>();
            foreach (string w in wordSet)
            {
                if (AreNext(word, w))
                {
                    result.Add(w);
                }

            }
            return result;
        }

        static IList<string> GetNextWords(string word, HashSet<string> wordSet)
        {
            var result = new List<string>();

            for (int i = 0; i < word.Length; i++)
            {
                StringBuilder tmp = new StringBuilder(word);
                for (char c = 'a'; c <= 'z'; c++)
                {
                    if (word[i] != c) // ignoring the same word 
                    {
                        tmp[i] = c;
                        if (wordSet.Contains(tmp.ToString()))
                            result.Add(tmp.ToString());
                    }


                }

            }
            return result;
        }


        static IList<string> GetNextWords(IEnumerable<string> words, HashSet<string> wordSet)
        {
            var result = new List<string>();

            foreach (var w in words)
            {
                result.AddRange(GetNextWords(w, wordSet));
            }

            return result;
        }
            

        static HashSet<string> ReadWords(string filepath)
        {
            Contract.Requires(!String.IsNullOrEmpty(filepath));
            Contract.Requires(File.Exists(filepath));

            StreamReader sr = new StreamReader(filepath);
            string line;

            var result = new HashSet<string>();

            while ((line = sr.ReadLine()) != null)
            {
                if (!String.IsNullOrWhiteSpace(line))
                    result.Add(line);

            }
            return result;
        }

        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Not enough arguments ");
                Environment.Exit(1);

            }
            string ladderFilePath = args[0];

            HashSet<string> ladderWords = ReadWords(ladderFilePath);

            // find words for 'puma'
            var nextWords = GetNextWords("puma", ladderWords);
            Console.WriteLine("puma: " + ToString(nextWords));

            // find which word has distance 33 
            foreach (var word in ladderWords)
            {
                nextWords = GetNextWords(word, ladderWords);
                if (nextWords.Count == 33)
                {
                    Console.WriteLine(word + ": " + ToString(nextWords));
                }
            }

            // how many words can be reached , starting from 'best' , in 3 
            // or less steps 
            IList<string> best1 = GetNextWords("best", ladderWords);
            IList<string> best2 = GetNextWords(best1, ladderWords);
            IList<string> best3 = GetNextWords(best2, ladderWords);

            var hs = new HashSet<string>();
            hs.UnionWith(best1);
            hs.UnionWith(best2);
            hs.UnionWith(best3);
            Console.WriteLine("best: " + ToString(hs));



            done:

                Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }
    }
}
