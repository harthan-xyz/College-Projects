/**
 * Driver of the WordSearch class
 * 
 * @author yaw 
 * @version 22 Oct 2016
 */

import java.util.*;
import java.io.*;

public class Driver
{    
    public static void main (String[] args)
    {
        // try block needed to read in file
        try
        {
            //open the file "sampleSearch.txt"
            FileReader fileName = new FileReader("sampleSearch.txt");
            Scanner fileRead = new Scanner(fileName);
            
            //read in the number of rows
            int numRow = fileRead.nextInt();
            fileRead.nextLine();
            
            //read in the number of columns
            int numCol = fileRead.nextInt();
            fileRead.nextLine();
            
            //create a 2d array to hold the characters in the file
            char[][] array = new char[numRow][numCol];
            
            //for each row in the file
            for (int r = 0; r < numRow; r++)
            {
                //read in the row as a string
                String row = fileRead.nextLine();
                
                //parse the string into a sequence of characters
                for (int c = 0; c < numCol; c++)
                {
                    //store each character in the 2d array
                    array[r][c] = row.charAt(c);
                }
            }
            
            //create a new instance of the WordSearch class
            WordSearch ws = new WordSearch(array);
            
            //play the game
            ws.play();
        }
        catch (FileNotFoundException exception)
        {
            //error is thrown if file cannot be found.  See directions or email me...
            System.out.println("File Not Found");
        }
        
    }    
}