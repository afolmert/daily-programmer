using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;


/*

Write a program that concatenates all text files (*.txt) in a directory, numbering file names in alphabetical order. Print a header containing some basic information above each file.
For example, if you have a directory like this:
~/example/abc.txt
~/example/def.txt
~/example/fgh.txt

And call your program like this:
nooodl:~$ ./challenge97easy example
The output would look something like this:
=== abc.txt (200 bytes)
(contents of abc.txt)

=== def.txt (300 bytes)
(contents of def.txt)

=== ghi.txt (400 bytes)
(contents of ghi.txt)
For extra credit, add a command line option '-r' to your program that makes it recurse into subdirectories alphabetically, too, printing larger headers for each subdirectory.

*/



namespace Test
{

    class Program
    {
        public static void Error(string message)
        {
            Console.WriteLine(message);
            Environment.Exit(1);
        }



        public static void DumpFiles(string directory, string extension, bool shouldRecurse)
        {
            string[] files = Directory.GetFiles(directory);

            foreach (string file in files)
            {
                if (file.EndsWith(extension))
                {
                    FileInfo fi = new FileInfo(file);
                    Console.WriteLine(String.Format("{0} ========================= ({1} bytes)", file, fi.Length));
                    Console.Write(File.ReadAllText(file));
                    Console.WriteLine();
                }
            }


            if (shouldRecurse)
            {
                string[] subdirs = Directory.GetDirectories(directory);
                foreach (string subdir in subdirs)
                {
                    DumpFiles(subdir, extension, shouldRecurse);
                }
            }
        }



        public static void Main(string[] args)
        {

           args = new string[] { "-r", "C:/Temp" };

            bool shouldRecurse = false;
            string directory = null;
            string extension = "txt";


            if (args.Length < 1)
            {
                Error("Not enough arguments provided");
            }


            if (args[0] == "-r")
            {
                if (args.Length < 2)
                {
                    Error("Not enough arguments provided");
                }

                directory = args[1];
                shouldRecurse = true;
            }
            else
            {
                directory = args[0];
            }


            if (!Directory.Exists(directory))
            {
                Error("Directory does not exist " + directory);
            }

            DumpFiles(directory, extension, shouldRecurse);



            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);
        }

    }

}
