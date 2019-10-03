
/**
 * Inlab6 number guessing game.
 * 
 * @author Joshua Harthan  
 * @version 11Oct16
 */
import java.util.Scanner;

public class GuessGame
{   
    //play1 method to play the first version of the game, 1 to 10
    public static void play1()
    {
        Scanner in = new Scanner(System.in);
        System.out.println("Version 1:");
        System.out.println("I am thinking of a number between 1 and 10.");
        System.out.println("What is your guess?");
        //set the value of the randomized number on the interval 1 to 10
        int correctNum = (int)((10-1) * Math.random() + 1);
        int num = in.nextInt();
        while (correctNum != num)   //while the number generated isnt met/guessed
        {
            if (num > correctNum)   //if the number guessed is larger than the one generated
            {
                System.out.println("Smaller!");
                System.out.println("What is your guess?");
                num = in.nextInt();
            }
            else if (num < correctNum)//if the number gussed is smaller than the one generated
            {
                System.out.println("Bigger!");
                System.out.println("What is your guess?");
                num = in.nextInt();
            }             
        }
        System.out.println("You guessed it!");
        System.out.println();
    }

    //play2 method to play the second version of the game, 5 to 25
    public static void play2()
    {
        Scanner in = new Scanner(System.in);
        System.out.println("Version 2:");
        System.out.println("I am thinking of a number between 5 and 25.");
        System.out.println("What is guess #1?");
        //set value of the randomized number on the interval 5 to 25
        int correctNum = (int)((25-5) * Math.random() + 5);
        int num = in.nextInt();
        for (int guess = 0; guess <= 3; guess++)
        {
            if (num > correctNum)   //if the number guessed is larger than the one generated
            {
                System.out.println("Smaller!");
                System.out.println("What is guess #" + (guess + 2) + "?");
                num = in.nextInt();
            }
            else if (num < correctNum)//if the number gussed is smaller than the one generated
            {
                System.out.println("Bigger!");
                System.out.println("What is guess #" + (guess + 2) + "?");
                num = in.nextInt();
            }
        }
        for (int guess = 4; guess <= 4; guess++)
        {
            if (num > correctNum || num < correctNum)//if the number guessed is not correct
            {
                System.out.println("Sorry, the correct number was " + correctNum + ".");
            }
            else if (num == correctNum)//if the number guessed is correct 
            {
                System.out.println("You guessed it!");
            }
        }
    }      
}

