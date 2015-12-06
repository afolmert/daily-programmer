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


        struct Student
        {
            public string Name;

            public int[] Scores;

            // parses input string 
            // like WILLIAM 12 12 19 9 4 3 0 4 13 14
            public static Student Parse(string input)
            {
                string[] parts = input.Trim().Split(' ');

                string name = parts[0];
                int[] scores = parts.Skip(1).Select(n => int.Parse(n)).ToArray();
                // 
                return new Student() { Name = name, Scores = scores };
            }

            public override string ToString()
            {
                return this.Name + String.Join(":  ", this.Scores.Select(e => $"{e}"));
            }

        }


        static String ToString<T>(IEnumerable<T> s)
        {
            return String.Join(" ", s.Select(e => $"{e}"));
        }


        static void Main(string[] args)
        {


            if (args.Length < 1)
            {
                Console.WriteLine("Arguments not supplied ");
                Environment.Exit(1);
            }

            string inputFilePath = args[0];
            string content = File.ReadAllText(inputFilePath);

            string[] contentLines = content.Split('\n');
            string[] parts = contentLines[0].Split(' ');

            int studentsCount = int.Parse(parts[0]);
            int assignmentsCount = int.Parse(parts[1]);

            // parse students 
            List<Student> students = new List<Student>();

            foreach (string line in contentLines.Skip(1))
            {
                var student = Student.Parse(line.Trim());
                students.Add(student);
            }

            // print averages 
            var allScoresAvg = students.SelectMany(s => s.Scores).ToList().Average();
            Console.WriteLine(String.Format("{0:0.00}", allScoresAvg));

            foreach (Student student in students)
            {
                Console.WriteLine(student.Name + " " + String.Format("{0:00}", student.Scores.Average()));
            }


            Console.WriteLine("Press any key to continue ... ");
            Console.ReadKey();
        }

    }
}
