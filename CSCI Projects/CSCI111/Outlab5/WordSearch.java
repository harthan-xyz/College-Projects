
/**
 * This is the WordSearch class to search for words in an array.
 * 
 * @author Joshua Harthan
 * @version 14Nov2016
 */
import java.util.Scanner;   //import scanner to read user input

public class WordSearch
{
    private char[][] array; // variable for word search block
    private static String userInput =  ""; // variable for user input

    // constructor that takes a 2-dimensional character array
    public WordSearch(char[][] inArray)
    {
        array = inArray; // sets array to array from driver
    }

    public void play()
    {
        // prints array in word search format
        while(!userInput.equals("end"))
        {
            for (int row = 0; row < array.length; row++)
            {
                for (int col = 0; col < array[row].length; col++)
                {
                    System.out.print(array[row][col]);  // iterate through the 2d array and print it
                }
                System.out.println();
            }
            System.out.println();
            System.out.println("What word do you want to search for? (Type end to quit)");

            Scanner input = new Scanner(System.in); // allows for user input
            userInput = input.next(); // sets String userInput to the user's input

            int a = 0; // variable to see if the current word was found or not, determines whether to print out a statement or not
            int n = 0; // variable for current letter, checks to see if the number of char is equal to userInput.length()
            boolean match = true;//boolean to see if the word array matches userInput

            //horizontal
            for (int row = 0; row < array.length; row++)
            {
                for (int col = 0; col < array[row].length; col++)
                {
                    match = false;
                    //finds if userInput is within the array horizontally
                    if (n < userInput.length())
                    {
                        char word = array[row][col];//sets a char variable equal to the array
                        if (userInput.charAt(n) == word)    //if character at a current point of userInput equals the word array
                        {
                            match = true;   //set boolean match to true
                            n++;            //add one to the value of n
                        }
                        else
                        {
                            match = false; //else set the boolean match to false
                            n = 0;         //reset value of n to 0
                        }
                        if ((n == userInput.length()) && (match == true)) //if the length of n equals the length of userInput and match is true
                        {
                            System.out.println(userInput + " found horizontally at row " + row + " and column " + (col - (userInput.length() - 1)) + "!"); 
                            a++;    //if found, increment a by one
                        }
                    }
                }
            }
            n = 0; //reset the value of n equal to 0

            //vertical
            for (int col = 0; col < array.length + 5; col++)
            {
                for (int row = 0; row < array.length; row++)
                {
                    match = false;
                    //finds if userInput is within the array vertically
                    if (n < userInput.length())
                    {
                        char word = array[row][col];//sets a char variable equal to the array
                        if (userInput.charAt(n) == word)    //if character at a certain point of userInput equals the word array
                        {
                            match = true;   //set boolean match to true
                            n++;            //add one to the the value of n
                        }
                        else
                        {
                            match = false;  //else set the boolean match to false
                            n = 0;          //reset value of n to 0
                        }
                        if ((n == userInput.length()) && (match == true))   //if the length of n equals the length of userInput and match is true
                        {
                            System.out.println(userInput + " found vertically at row " + (row - (userInput.length() - 1)) + " and column " + col + "!"); 
                            a++;    //if found, increment a by one
                        }
                    }
                }
            }
            n = 0; //reset the value of n equal to 0

            //attempt at diagonal
            for (int row = 0; row < array.length; row++)
            {
                for (int col = 0; col < array[row].length; col++)
                {
                    match = false;
                    //finds if userInput is within the array diagonally
                    if (n < userInput.length())
                    {
                        int i = 0;  //variable that moves where the array is checking
                        char word = array[row + i][col + i];//sets a char variable equal to the array
                        if (userInput.charAt(n) == word) //if character at a certain point of userInput equals the word array
                        {
                            i++;            //add one to the value of i
                            n++;            //add one to the value of n
                        }
                        else
                        {
                            match = false;  //else set the boolean match to false
                            n = 0;          //reset value of n to 0
                        }
                        if (n == i) // if the value of n equals the value of i
                        {
                            match = true;
                        }
                    }
                    if ((n == userInput.length()) && (match == true))   //if the length of n equals the length of userInput and match is true
                    {
                        System.out.println(userInput + " found diagonally at row " + (row - (userInput.length() - 1)) + " and column " + col + "!"); 
                        a++;    //if found, increment a by one
                    }
                }
            }
            if(a == 0 && !userInput.equals("end")) //if the boolean match is still false and the value of n = 0 and userInput does not equal "end"
            {
                System.out.println(userInput + " not found!");  //print out the word not being found
            }
            System.out.println();
        }
    }
}

