using System;
using System.IO;
using System.Text;

namespace Test
{
    class Program
    {
		
        private static char ToChar(byte b)
        {
            char r = Convert.ToChar(b);

            if (Char.IsControl(r) || Char.IsWhiteSpace(r)) 
            {
                return ' ';
            } else 
            {
                return r;
            }
			    
        }
		
		
        public static string DumpFile(string filepath, int width)
        {
            var bytes = File.ReadAllBytes(filepath);
			
            var hexLine = new StringBuilder();
            var textLine = new StringBuilder();
            var result = new StringBuilder();

            int column = 0;
			
            foreach (byte b in bytes) 
            {
                hexLine.AppendFormat("{0,2:X2} ", b);
                textLine.Append(ToChar(b));
				
                column++;
                if (column >= width) 
                {
                    result.Append(hexLine + "    " + textLine + "\n");
                    textLine.Clear();
                    hexLine.Clear();
                    column = 0;
                }
				
            }
			
            result.Append(hexLine.ToString().PadRight(width * 3, ' ')
            + "    "
            + textLine + "\n");
			

            return result.ToString();
			
        }
		
        public static void Main(string[] args)
        {

            if (args.Length < 1) 
            {
                Console.WriteLine("No arguments provided");
                Environment.Exit(1);
            }
					
            var p = new Program();
			
            string result = DumpFile(args[1], 80);
			
            Console.Write("Press any key to continue . . . ");
            Console.ReadKey(true);
			

        }
    }
}