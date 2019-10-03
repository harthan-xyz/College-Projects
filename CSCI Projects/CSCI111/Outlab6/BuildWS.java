
/**
 * This is the BuildWS class to build a word search given user given amount of rows and columns.
 * 
 * @author Joshua Harthan 
 * @version 5Dec2016
 */
import java.util.Scanner; //import scanner to read uer input
import java.util.ArrayList; //import arraylist method
import java.util.List;   //import list method
public class BuildWS
{
    private char[][] wordSearch;    //array to create the wordsearch
    private int rows;               //variabe to represent the rows within the word search
    private int columns;            //variable to represent the columns within the word search
    private int randomRow;          //variable to generate random row
    private int randomCol;          //variable to generate random column
    private List<String> wordsInput = new ArrayList<>(); //create an arraylist to keep track of words input by user
    private int numWords;           //variable to represent the number of chars in the word input
    private boolean[][] checkWord;  //array to check if the spot is already filled

    public BuildWS ()
    {

    }

    public void build() //call the methods
    {
        readNumbers();
        readInput();
        createArray();
        putWordsIn();
        printArray();
    } 

    public void readNumbers() //read in user input to create an array given specific values
    {
        System.out.println("How many rows would you like? >");   //ask the user how many rows the word search should have
        Scanner rowInput = new Scanner(System.in);               //allows for user input for the number of rows
        rows = rowInput.nextInt();                               //sets the int rows to the number that the user input
        rows--;                                                  //subtract one from userInput rows to get rid of out of bounds exception
        System.out.println("How many columns would you like? >");//ask the user how many columns the word search should have
        Scanner columnInput = new Scanner(System.in);            //allows for user input for the number of columns
        columns = columnInput.nextInt();                         //sets the int columns to the number that the user input
        columns--;                                               //subtract one form userInput columns to get rid of out of bounds exception
        wordSearch = new char[rows + 1][columns + 1];            //creates the array given numbers input
        checkWord = new boolean[rows + 1][columns + 1];          //creates the boolean array given numbers input
    }

    public void readInput()
    {
        String userInput = "";  //varialbe to represent the words going to be implemented within the word search
        while(!userInput.equals("end"))
        {
            System.out.println("Add a word to your search (end to stop) >"); //asks for user input
            Scanner input = new Scanner (System.in);                 //allows for user input of a word to add to the word search
            userInput = input.nextLine();                                //sets the String userInput to the word the user input
            if(userInput.length() >= columns && userInput.length() >= rows)
            {
                System.out.println("That word is too long for the dimensions input. Type another word or type end to quit."); 
            }
            else
            {
                if(!userInput.equals("end"))
                {
                    wordsInput.add(userInput);  //if word input doesnt equal "end", take in words and set it equal to the array list
                    numWords++;                 //increase numWords by one per input
                }
            }
        } 
    }

    public void getRandomLocation()
    {
        randomRow = (int) (Math.random() * rows);       //generates a random location in the array for the rows
        randomCol = (int) (Math.random() * columns);    //generates a random location in the array for the columns
    }

    public void createArray()
    {
        String alphabet = "abcdefghijklmnopqrstuvwxyz"; //create a string that has all the letters in the alphabet  
        for (int row = 0; row <= rows; row++)
        {
            for (int col = 0; col <= columns; col++)
            {
                wordSearch[row][col] = alphabet.charAt((int)(Math.random() * alphabet.length()));   //populates array with random letters
            }
        }
    }

    public void putWordsIn()
    {
        int index = 0; //int variable for arraylist, determines what char is within the word
        checkSpot();   //run the checkSpot method
        while (index < numWords)
        {
            getRandomLocation();    //generate random location for the words input
            for (int row = 0; row <= rows; row++)
            {
                for (int col = 0; col <= columns; col++)
                {
                    int orientation = (int)(Math.random() * 3 + 1); //orientation variable to generate the random orientation of the word
                    if (orientation == 1) //horizontal
                    {
                        if ((row == randomRow) && (col == randomCol) && (columns - col > wordsInput.get(index).length()))
                        {
                            boolean insert = false; //creates a local boolean variable to check if spot is filled
                            int count = 0;          //creates a local int variable to increase everytime the word is allowed to be inserted
                            for (int n = 0; n < wordsInput.get(index).length(); n++)
                            {
                                if(checkWord[row][col + n] == true || wordSearch[row][col + n] == wordsInput.get(index).charAt(n))
                                {
                                    count++;    //if char is allowed to be inserted, increase count by one
                                }
                                if(count == wordsInput.get(index).length())
                                {
                                    insert = true;  //if count is equal to the length of teh word, set insert to true
                                }
                            }
                            if(insert == true)  //if insert is true
                            {
                                for (int n = 0; n < wordsInput.get(index).length(); n++)
                                {
                                    wordSearch[row][col + n] = wordsInput.get(index).charAt(n); //put the word in the array
                                    checkWord[row][col + n] = false;    //set that spot to false
                                }
                                index++;    //increase the index number by one
                            }
                        }
                    }
                    if (orientation == 2) //vertical
                    {
                        if ((row == randomRow) && (col == randomCol) && (rows - row > wordsInput.get(index).length()))
                        {
                            boolean insert = false; //creates a local boolean variable to check if spot is filled
                            int count = 0;          //creates a local int variable to increase everytime the word is allowed to be inserted
                            for (int n = 0; n < wordsInput.get(index).length(); n++)
                            {
                                if(checkWord[row + n][col] == true || wordSearch[row + n][col] == wordsInput.get(index).charAt(n))
                                {
                                    count++; //if char is allowed to be inserted, increase count by one
                                }
                                if(count == wordsInput.get(index).length())
                                {
                                    insert = true; //if count is equal to the length of teh word, set insert to true
                                }
                            }
                            if(insert == true) //if insert is true
                            {
                                for (int n = 0; n < wordsInput.get(index).length(); n++)
                                {
                                    wordSearch[row + n][col] = wordsInput.get(index).charAt(n); //put the word in the array
                                    checkWord[row + n][col] = false; //set that spot to false
                                }
                                index++; //increase the index number by one
                            }
                        }
                    }
                    if (orientation == 3) //diagonal
                    {
                        if ((row == randomRow) && (col == randomCol) && (col - columns > wordsInput.get(index).length()) && (rows - row > wordsInput.get(index).length()))
                        {
                            boolean insert = false; //creates a local boolean variable to check if spot is filled
                            int count = 0;          //creates a local int variable to increase everytime the word is allowed to be inserted
                            for (int n = 0; n < wordsInput.get(index).length(); n++)
                            {
                                if(checkWord[row + n][col + n] == true || wordSearch[row + n][col + n] == wordsInput.get(index).charAt(n))
                                {
                                    count++; //if char is allowed to be inserted, increase count by one
                                }
                                if(count == wordsInput.get(index).length())
                                {
                                    insert = true; //if count is equal to the length of teh word, set insert to true
                                }
                            }
                            if(insert == true) //if insert is true
                            {
                                for (int n = 0; n < wordsInput.get(index).length(); n++)
                                {
                                    wordSearch[row + n][col + n] = wordsInput.get(index).charAt(n); //put the word in the array
                                    checkWord[row + n][col + n] = false; //set that spot to false
                                }
                                index++; //increase the index number by one
                            }
                        }
                    }
                }
            }
        }
    }

    public void printArray()
    {
        for (int row = 0; row <= rows; row++)
        {
            for (int col = 0; col <= columns; col++)
            {
                System.out.print(wordSearch[row][col]); //print out the array one time
            }
            System.out.println();   //create a line after printing the array
        }
    }

    public void checkSpot() //creates an array filled with true values
    {
        for (int row = 0; row <= rows; row++)
        {
            for (int col = 0; col <= columns; col++)
            {
                checkWord[row][col] = true;
            }
        }
    }
}
