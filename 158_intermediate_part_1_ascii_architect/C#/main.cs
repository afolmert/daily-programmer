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

    public static class StringExt
    {
        public static char CharacterAt(this string s, int pos)
        {
            if (String.IsNullOrEmpty(s) || pos < 0 || pos >= s.Length)
                return ' ';
            else
                return s[pos];
        }
    }

    class Program
    {

        static Dictionary<char, string> PatternMapping = new Dictionary<char, string>
        {
            ['a'] = "+",
            ['b'] = "++",
            ['c'] = "++-",
            ['d'] = "++--",
            ['e'] = "++--*",
            ['f'] = "++--**",
            ['g'] = "++--***",
            ['h'] = "++--***-",
            ['i'] = "++--***--",
            ['j'] = "++--***---"
        };

        struct Instruction
        {
            public int Spaces;
            public char Code;

            public override string ToString()
            {
                return "I: " + Spaces + Code;
            }

            public string GeneratePattern()
            {
                var sb = new StringBuilder();
                for (int i = 0; i < Spaces; i++)
                {
                    sb.Append(' ');
                }
                sb.Append(PatternMapping[Code]);
                return sb.ToString();
            }
        }


        static String ToString<T>(IEnumerable<T> s)
        {
            return String.Join(" ", s.Select(e => $"{e}"));
        }

        static List<Instruction> ParseInput(string input)
        {
            var result = new List<Instruction>();

            int spaces = 0;

            foreach (char c in input)
            {
                if (Char.IsNumber(c))
                {
                    spaces = int.Parse(c.ToString());
                }
                else
                {
                    Instruction i = new Instruction() { Code = c, Spaces = spaces };
                    result.Add(i);
                    spaces = 0;
                }
            }
            return result;

        }

        static void DrawPatterns(string input)
        {
            var instructions = ParseInput(input);

            string[] patterns = instructions.Select(i => i.GeneratePattern()).ToArray();
            int height = patterns.Select(p => p.Length).Max();

            for (int i = height; i >= 0; i--)
            {
                foreach (var pattern in patterns)
                {
                    Console.Write(pattern.CharacterAt(i));

                }
                Console.WriteLine();
            }

        }

        static void Main(string[] args)
        {
            string input = "j3f3e3e3d3d3c3cee3c3c3d3d3e3e3f3fjij3f3f3e3e3d3d3c3cee3c3c3d3d3e3e3fj";
            DrawPatterns(input);

            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }

    }
}
