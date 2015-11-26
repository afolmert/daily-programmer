using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;


 /*
  *  125 easy word analytics 
 Number of words
 Number of letters
 Number of symbols (any non-letter and non-digit character, excluding white spaces)
 Top three most common words (you may count "small words", such as "it" or "the")
 Top three most common letters
 Most common first word of a paragraph (paragraph being defined as a block of text with an empty line above it) (Optional bonus)
 Number of words only used once (Optional bonus)
 All letters not used in the document (Optional bonus)
 */


namespace Test
{
    class Program
    {

        private static void IncFreq<T>(IDictionary<T, int> dict, T key) 
        {
            if (dict.ContainsKey(key))
            {
                dict[key] += 1;
                    
            }
            else
            {
                dict[key] = 1;
                
            }
        }
        
        private static string ToStr<T>(IEnumerable<T> en)
        {
            var sb = new StringBuilder();
            foreach (var e in en)
            {
                sb.AppendFormat(" {0} ", e.ToString());
                
            }
            return sb.ToString();
        }
        
        private static IList<T> GetMostFrequent<T>(IDictionary<T, int> dict, int count) 
        {
            var odict = new Dictionary<int, List<T>>();
            
            // inverse dictionary  
            foreach (var v in dict)
            {
                if (!odict.ContainsKey(v.Value))
                {
                    odict.Add(v.Value, new List<T>());
                }
                odict[v.Value].Add(v.Key);
            }
            
            var result = new List<T>();
            
            foreach (int key in odict.Keys.OrderByDescending(o => o))
            {
                foreach (T v1 in odict[key])
                {
                    result.Add(v1);
                    if (result.Count >= count)
                    {
                        goto outer;
                    }
                }

                
            }
        outer:
            return result;
        }
        
        public static void DumpDictionary<K, V>(Dictionary<K, V> dict)
        {
            foreach (var v in dict)
            {
                Console.Write(String.Format(" {0} -> {1} ", v.Key, v.Value));
            }
        }
        
        public static string AnalyzeFile(string filepath) 
        {
            
            if (filepath == null) 
                throw new ArgumentException("Cannot enter null filepath");
            
            int wordCount = 0;
            int letterCount = 0;
            int symbolCount = 0;
            string word = "";
            

            var wordsFreq = new Dictionary<string, int>();
            var letterFreq = new Dictionary<char, int>();
            
            
            
            var content = File.ReadAllText(filepath);
            bool wasWhiteSpace = false;
            
            foreach (char c in content) 
            {
                IncFreq(letterFreq, c);


                if (Char.IsLetter(c))
                {
                    letterCount++;
                }
                else if (Char.IsSymbol(c))
                {
                    symbolCount++;
                }
                else if (Char.IsWhiteSpace(c) && !wasWhiteSpace)
                {
                    IncFreq(wordsFreq, word);
                    word = "";
                    wordCount++;
                }
                wasWhiteSpace = Char.IsWhiteSpace(c);
                
                if (!Char.IsWhiteSpace(c))
                {
                    word += c;
                }
                Console.Write(c.ToString() + ' ');
                
            }
            
            
            if (!wasWhiteSpace)
            {
                IncFreq(wordsFreq, word);
                wordCount++;
            }
            
            
            IList<string> maxWords = GetMostFrequent(wordsFreq, 5);
            IList<char> maxChars = GetMostFrequent(letterFreq, 5);
            
            
            return String.Format("LetterCount: {0} WordCount: {1}, SymbolCount: {2} Most freq Words: {3}, Most freq Chars: {4}", 
                                 letterCount, 
                                 wordCount, 
                                 symbolCount, 
                                 ToStr(maxWords),
                                 ToStr(maxChars));
                                        
        }
        
		
        public static void Main(string[] args)
        {
    
            string stats = AnalyzeFile(args[1]);
            
            Console.WriteLine("STATISTICS");
            Console.WriteLine(stats);

			
            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);
			

        }
    }
}