
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;



namespace Test
{

    static class Utils
    {
        public static T[] SubArray<T>(this T[] data, int index, int length)
        {
            T[] result = new T[length];
            Array.Copy(data, index, result, 0, length);
            return result;
        }
    }

    class Program
    {
        public static string ToBinaryString(int value)
        {
            var bits = new char[32];
            int i = 0;
            while (value != 0)
            {
                bits[i++] = (value & 1) == 1 ? '1' : '0';
                value >>= 1;
            }

            Array.Reverse(bits, 0, i);

            return new string(bits.SubArray(0, i));
        }


        public static void DrawPicture(string input)
        {
            string[] hexValues = input.Split(' ');
            foreach (string hexValue in hexValues)
            {
                int value = int.Parse(hexValue, System.Globalization.NumberStyles.AllowHexSpecifier);

                string binaryString = ToBinaryString(value);
                binaryString = binaryString.PadLeft(16, '_');

                foreach (char c in binaryString)
                {
                    if (c == '1')
                        Console.Write('x');
                    else
                        Console.Write(' ');

                }
                Console.WriteLine();
            }
        }


        public static void Main(string[] args)
        {


            DrawPicture("18 3C 7E 7E 18 18 18 18");

            DrawPicture("FF 81 BD A5 A5 BD 81 FF");
            DrawPicture("AA 55 AA 55 AA 55 AA 55");
            DrawPicture("3E 7F FC F8 F8 FC 7F 3E");
            DrawPicture("93 93 93 F3 F3 93 93 93");


            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);


        }
    }
}
