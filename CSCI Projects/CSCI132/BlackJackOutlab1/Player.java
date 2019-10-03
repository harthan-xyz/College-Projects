
/**
 * The Player class for the Blackjack game to keep track of money and bets by the player.
 *
 * @author Joshua Harthan
 *  2/7/17
 */
import java.util.Scanner;

public class Player {

    private static Scanner scanner = new Scanner(System.in);
    private int points; //points to store the amount the user has
    private int bet; //bet to store the amount the user bet
    private int win = 0; //win variable to determine if the user won, lost, or tied

    //empty constructor
    public Player() {

    }
    //play class to inform user of the rules and set the amount of points the user has (500)
    public void play() {
        System.out.println("You are playing a type of blackjack where you must get closest or equal to 31 as opposed to the usual 21.");
        points = 500;
        
        //while win equals 0, run the code to prompt the player to bet points while the bet is not equal to 0 or not more than the amount of points they have
        while (win == 0) {
            System.out.println("You have " + points + " points to bet.");
            do {
                System.out.print("How many points would you like to bet? Enter '0' to exit. ");
                bet = scanner.nextInt();
                if (bet < 0 || bet > points) {
                    System.out.println("Please enter a value that is between 0 and " + points + ".");
                }
            } while (bet < 0 || bet > points);
            if (bet == 0) {
                break;
            }
            //create a new instance of gameplay and set win equal to the result of the playGame method
            Gameplay g1 = new Gameplay();
            win = g1.playGame();
            //switch statement to determine if the user loses the bet 
            switch (win) {
                case 0: //user wins 
                    points = points + bet;
                    break;
                case 1: //user loses
                    points = points - bet;
                    break;
                default: //break if not 1 or 2 (3 for a tie)
                    break;
            }
            //if the user has 0 points, end the game
            if (points == 0) {
                System.out.println("You are out of points and cannot bet.");
                break;
            }
        }
        //if the user decides to leave by betting 0 points
        System.out.println("You decide to leave with " + points + " points.");
    }
}
