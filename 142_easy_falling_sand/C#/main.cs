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

        public static void WriteArray(char[,] array)
        {
            for (int row = 0; row < array.GetLength(0); row++)
            {
                for (int col = 0; col < array.GetLength(1); col++)
                {
                    if (array[row, col] == ' ')
                    {
                        Console.Write('_');
                    }
                    else
                    {
                        Console.Write(array[row, col]);
                    }
                }
                Console.WriteLine();
            }
        }





        public static char[,] ParseArray(string inputFile)
        {
            string[] lines = File.ReadAllLines(inputFile);

            int size = int.Parse(lines[0]);

            // parse array
            char[,] dots = new char[size, size];

            int row = 0;
            foreach (string line in lines.Skip(1))
            {
                for (int col = 0; col < size; col++)
                {
                    dots[row, col] = col < line.Length ? line[col] : ' ';
                }
                row++;
            }

            return dots;
        }



        public static char[,] SimulateSand(char[,] array)
        {
            char[,] result = (char[,])array.Clone();
            int rowCount = result.GetLength(0);
            int colCount = result.GetLength(1);


            // go from top row to bottom

            for (int row = 1; row < rowCount; row++)
            {
               // for each column
 
                for (int col = 0; col < colCount; col++)
                {
                    // if encounters space, then shift the whole
                    // column down

                    if (result[row, col] == ' ')
                    {
                        // shift the whole column
                        for (int r = row - 1; r >= 0 && result[r, col] != '#'; r--)
                        {
                            result[r + 1, col] = result[r, col];
                            result[r, col] = ' ';
                        }
                    }
                }
            }

            return result;
        }



        public static void Main(string[] args)
        {

            // read input file
            string inputFile = "C:/Temp/CodeKatas/input.txt";
            char [,] dots = ParseArray(inputFile);

            // dump array
            WriteArray(dots);

            dots = SimulateSand(dots);

            Console.WriteLine("==============");

            WriteArray(dots);

            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);

        }

    }

}
