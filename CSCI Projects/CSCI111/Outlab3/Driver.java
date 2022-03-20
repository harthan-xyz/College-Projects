/**
 * Driver of the PetalsGame Class.  Also prints out menu and reads in user input.
 * 
 * @author Joshua Harthan
 * @version 10 Oct 2016
 */

import java.util.Scanner;       //Scanner import used later to read in user input

public class Driver
{    
    public static void main (String[] args)
    {
        Scanner in = new Scanner(System.in);    //used to read in user input
        
        PetalsGame game = new PetalsGame();     //create new instance of PetalsGame
        
        int choice = 2;                         //the player's menu choice, initially 2
        int guess = 3;                          //the player's menu choice, initially 3
        
        System.out.println("Petals Around the Rose");
        System.out.println("----------------------");
        
        while (choice != 1)     //while loop to play multiple times              
        {
            //menu options
            System.out.println("1. Quit.");
            System.out.println("2. Play.");
            System.out.println("3. Guess.");
            
            //read in user's menu choice and store in variable choice.
            System.out.print("\nPlease enter your choice > ");
            choice = in.nextInt();
            System.out.println();
            
            //program actions depending on user's choice
            switch (choice)
            {
                case 1:     //if player chose "1. Quit."
                    System.out.println("Thank you for playing.");
                    break;
                case 2:     //if player chose "2. Play."
                    game.rollDice();    //roll all five dice
                    game.printDice();   //print out values of the dice
                    System.out.println("The number of petals around the roses is " 
                                       + game.calculateAllPetals() + "\n"); 
                    break;
                case 3:     //if player chose "3. Guess."
                    game.rollDice();    //roll all five dice
                    game.printDice();   //print out the values of the dice
                    int correctPetals = game.calculateAllPetals();  //set the value of the petals
                    System.out.println("How many petals do you think are around the rose? > ");
                    guess = in.nextInt();
                    System.out.println();
                    if (guess == correctPetals) //if the player guesses correctly
                    {
                        System.out.println("Correct! Good job!");
                        System.out.println();
                    }
                    else                        //if the player guesses incorrectly
                    {
                        System.out.println("Sorry! The correct answer was " + correctPetals);
                        System.out.println();
                    }
                    break;
                    
                    default:
                    System.out.println("That is an invalid choice.  Please try again.\n");
            }
        }                
    }    
}