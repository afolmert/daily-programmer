
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;



namespace Test
{
     enum Notation
    {
        CamelCase,
        SnakeCase,
        CapitalizedSnakeCase
    };

     public static class Utils
     {
         public static string ToCapital(this string s)
         {
             if (String.IsNullOrEmpty(s))
             {
                 return s;

             }
             else
             {
                 return s.Substring(0, 1).ToUpper() + s.Substring(1);
             }
         }
     }

    class Program
    {
        public static string TranslateText(string input, Notation notation)
        {
            string result = null;
            switch (notation)
            {
                case Notation.CamelCase:
                    result = String.Join("", input.Split(' ').Select(s => s.ToCapital()));
                    break;
                case Notation.SnakeCase:
                    result = String.Join("_", input.Split(' '));
                    break;
                case Notation.CapitalizedSnakeCase:
                    result = String.Join("_", input.Split(' ').Select(s => s.ToCapital()));
                    break;
                default:
                    throw new ArgumentException("Invalid notation " + notation);

            }

            return result;
        }

        public static void Main(string[] args)
        {


            Console.WriteLine(TranslateText("map controller delegate manage", Notation.CamelCase));
            Console.WriteLine(TranslateText("hello world", Notation.CapitalizedSnakeCase));
            Console.WriteLine(TranslateText("user id", Notation.SnakeCase));



            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);


        }
    }
}
