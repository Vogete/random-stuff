using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Playfair_Cipher
{
    class Program
    {
        static void Main(string[] args)
        {
            do
            {
                Console.Write("Write the text to encrypt: ");
                string text = Console.ReadLine();
                Console.Write("Write a key: ");
                string key = Console.ReadLine();

                // Original Playfair cipher with 5×5 table
                //string encText = Original.Encipher(text, key);
                //string decText = Original.Decipher(encText, key);

                // Extended Playfair cipher with 6×6 table
                string encText = Encipher(text, key);
                string decText = Decipher(encText, key);

                Console.WriteLine($"The encrypted text: {encText}");
                Console.WriteLine($"The decrypted (encrypted) text: {decText}");

                Console.WriteLine("Press enter key to continue, or type 'exit' to exit!");

            } while (Console.ReadLine().ToLower() != "exit");

        }



        private static string defaultKeySquare = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private static int tableSize = 6;

        private static string Cipher(string input, string key, bool encipher)
        {
            string retVal = string.Empty;
            char[,] keySquare = GenerateKeySquare(key);
            string tempInput = RemoveOtherChars(input);
            int e = encipher ? 1 : -1;

            if ((tempInput.Length % 2) != 0)
                tempInput += "X";

            for (int i = 0; i < tempInput.Length; i += 2)
            {
                int row1 = 0;
                int col1 = 0;
                int row2 = 0;
                int col2 = 0;

                GetPosition(ref keySquare, char.ToUpper(tempInput[i]), ref row1, ref col1);
                GetPosition(ref keySquare, char.ToUpper(tempInput[i + 1]), ref row2, ref col2);

                if (row1 == row2 && col1 == col2)
                {
                    retVal += new string(SameRowColumn(ref keySquare, row1, col1, e));
                }
                else if (row1 == row2)
                {
                    retVal += new string(SameRow(ref keySquare, row1, col1, col2, e));
                }
                else if (col1 == col2)
                {
                    retVal += new string(SameColumn(ref keySquare, col1, row1, row2, e));
                }
                else
                {
                    retVal += new string(DifferentRowColumn(ref keySquare, row1, col1, row2, col2));
                }
            }
            retVal = AdjustOutput(input, retVal);

            return retVal;

        }

        private static void CalculateTableSize(string keyset)
        {
            int i = keyset.Length;
            tableSize = Convert.ToInt32(Math.Floor(Math.Sqrt(i)));
        }

        private static char[,] GenerateKeySquare(string key)
        {
            char[,] keySquare = new char[tableSize, tableSize];

            string tempKey = string.IsNullOrEmpty(key) ? "CIPHER" : key.ToUpper();

            tempKey += defaultKeySquare;

            for (int i = 0; i < tableSize*tableSize; ++i)
            {
                List<int> indexes = FindAllOccurrences(tempKey, defaultKeySquare[i]);
                tempKey = RemoveAllDuplicates(tempKey, indexes);
            }

            tempKey = tempKey.Substring(0, tableSize* tableSize);

            for (int i = 0; i < tableSize* tableSize; ++i)
                keySquare[(i / tableSize), (i % tableSize)] = tempKey[i];

            DrawTable(keySquare);            

            return keySquare;
        }

        private static List<int> FindAllOccurrences(string str, char value)
        {
            List<int> indexes = new List<int>();

            int index = 0;
            while ((index = str.IndexOf(value, index)) != -1)
                indexes.Add(index++);

            return indexes;
        }

        private static string RemoveAllDuplicates(string str, List<int> indexes)
        {
            string retVal = str;

            for (int i = indexes.Count - 1; i >= 1; i--)
                retVal = retVal.Remove(indexes[i], 1);

            return retVal;
        }

        private static string RemoveOtherChars(string input)
        {
            string output = input;
            int n;
            for (int i = 0; i < output.Length; ++i)
                if (!char.IsLetter(output[i]) && !int.TryParse(output[i].ToString(), out n) )
                    output = output.Remove(i, 1);

            return output;
        }

        private static void GetPosition(ref char[,] keySquare, char ch, ref int row, ref int col)
        {

            for (int i = 0; i < tableSize; ++i)
                for (int j = 0; j < tableSize; ++j)
                    if (keySquare[i, j] == ch)
                    {
                        row = i;
                        col = j;
                    }
        }


        private static char[] SameRow(ref char[,] keySquare, int row, int col1, int col2, int encipher)
        {
            return new char[] { keySquare[row, Mod((col1 + encipher), tableSize)], keySquare[row, Mod((col2 + encipher), tableSize)] };
        }

        private static char[] SameColumn(ref char[,] keySquare, int col, int row1, int row2, int encipher)
        {
            return new char[] { keySquare[Mod((row1 + encipher), tableSize), col], keySquare[Mod((row2 + encipher), tableSize), col] };
        }

        private static char[] SameRowColumn(ref char[,] keySquare, int row, int col, int encipher)
        {
            return new char[] { keySquare[Mod((row + encipher), tableSize), Mod((col + encipher), tableSize)], keySquare[Mod((row + encipher), tableSize), Mod((col + encipher), tableSize)] };
        }

        private static char[] DifferentRowColumn(ref char[,] keySquare, int row1, int col1, int row2, int col2)
        {
            return new char[] { keySquare[row1, col2], keySquare[row2, col1] };
        }

        private static int Mod(int a, int b)
        {
            return (a % b + b) % b;
        }

        private static string AdjustOutput(string input, string output)
        {
            StringBuilder retVal = new StringBuilder(output);

            for (int i = 0; i < input.Length; ++i)
            {
                int n;
                if (!char.IsLetter(input[i]) && !int.TryParse(input[i].ToString(), out n))
                    retVal = retVal.Insert(i, input[i].ToString());

                if (char.IsLower(input[i]))
                    retVal[i] = char.ToLower(retVal[i]);
            }

            return retVal.ToString();
        }


        public static string Encipher(string input, string key)
        {
            CalculateTableSize(defaultKeySquare);
            return Cipher(input, key, true);
        }

        public static string Decipher(string input, string key)
        {
            CalculateTableSize(defaultKeySquare);
            return Cipher(input, key, false);
        }

        private static void DrawTable(char[,] keySquare)
        {
            Console.WriteLine("----------");
            for (int i = 0; i < tableSize; i++)
            {
                for (int j = 0; j < tableSize; j++)
                {
                    Console.Write($"{keySquare[i,j]} ");
                }
                Console.WriteLine();
            }
        }
    }
}