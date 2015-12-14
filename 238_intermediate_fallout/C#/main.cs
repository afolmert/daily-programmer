
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;



namespace Test
{


    class Program
    {


        static Random _random = new Random();


        static List<string> LoadRandomWords(int count, int wordLength)
        {
            string[] words =
                File.ReadLines("C:/Temp/enable1.txt")
                    .Where(l => l.Length == wordLength)
                    .ToArray();

            var result = new HashSet<string>();
            while (result.Count < count)
            {
                string word = words[_random.Next(words.Length)];

                result.Add(word.ToUpper());
            }

            return result.ToList();

        }


        public static void Main(string[] args)
        {

            int difficulty = 1;

            do
            {
                Console.Write("Select difficulty level (1-5)? ");
                difficulty = int.Parse(Console.ReadLine());

            } while (difficulty < 1 || difficulty > 5);


            List<string> words = LoadRandomWords(5 + difficulty * 2, 3 + difficulty);

            foreach (string word in words)
            {
                Console.WriteLine(word);
            }

            string secret = words[_random.Next(words.Count)];

            int guessesLeft = 4;
            while (guessesLeft > 0)
            {
                Console.Write(String.Format("Guess ({0} left)? ", guessesLeft));
                string guess = Console.ReadLine().ToUpper();

                if (!words.Contains(guess))
                {
                    Console.WriteLine("Word not from list!");
                    continue;
                }

                if (guess == secret)
                {
                    Console.WriteLine("Yes, that is the secret, you won!");
                    break;
                }
                else
                {
                    int matchingCount = 0;
                    for (int i = 0; i < secret.Length; i++)
                    {
                        if (secret[matchingCount] == guess[matchingCount])
                        {
                            matchingCount++;
                        }
                    }
                    Console.WriteLine(String.Format("{0}/{1} correct", matchingCount, secret.Length));

                }

                guessesLeft--;
            }

            if (guessesLeft == 0)
            {
                Console.WriteLine("Sorry, you lose, the secret was " + secret);
            }

            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);


        }
    }
}
