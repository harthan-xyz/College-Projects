
/**
 * The Gameplay class for the Blackjack game to run the game.
 *
 * @author Joshua Harthan
 *  2/7/17
 */
import java.util.Scanner; //import to take in user input
import java.util.ArrayList; //import to create arraylists

public class Gameplay {

    private static Scanner scanner = new Scanner(System.in); //create a scanner that is used throughout the class
    private ArrayList<String> playerCards = new ArrayList<>(52); //create an arraylist containing instances of cards for the player
    private ArrayList<String> dealerCards = new ArrayList<>(52); //creates an arralyist containg instances of cards for the dealer
    Card c1 = new Card(); //
    private int currentPosition; //variable to differentiate where in the deck a certain card is
    private int[] deck; //deck array that holds ints to point to different cards

    //empty constructor
    public Gameplay() {

    }

    public int playGame() {
        //call the genDeck and shuffleDeck methods to begin the game
        genDeck();
        shuffleDeck();
        
        //give the dealer and the player three cards to start out with
        dealerCards.add(dealCard(), c1.showSuit(1));
        dealerCards.add(dealCard(), c1.showSuit(2));
        dealerCards.add(dealCard(), c1.showSuit(3));
        playerCards.add(dealCard(), c1.showSuit(1));
        playerCards.add(dealCard(), c1.showSuit(2));
        playerCards.add(dealCard(), c1.showSuit(3));
        
        //if the dealer has a hand equal to 31, print out the dealer hand and print out your own, returning a one to represent a loss
        if (value(dealerCards) == 31) {
            System.out.println("The dealer has the " + c1.showCard(getCard(dealerCards, 0)) + " of " + c1.showSuit(getCard(dealerCards, 0)) + ", the " + c1.showCard(getCard(dealerCards, 1)) + " of " + c1.showSuit(getCard(dealerCards, 1)) + " and the " + c1.showCard(getCard(dealerCards, 2)) + " of " + c1.showSuit(getCard(dealerCards, 2)));
            System.out.println("You have the " + c1.showCard(getCard(playerCards, 0)) + " of " + c1.showSuit(getCard(playerCards, 0)) + ", the " + c1.showCard(getCard(playerCards, 1)) + " of " + c1.showSuit(getCard(playerCards, 1)) + " and the " + c1.showCard(getCard(playerCards, 2)) + " of " + c1.showSuit(getCard(playerCards, 2)));
            System.out.println("The dealer wins!");
            System.out.println();
            return 1; //return a loss
        }
        
        //if the player has a hand equal to 31, print out the dealer hand and print out your own, returning a zero to represent a win
        if (value(playerCards) == 31) {
            System.out.println("The dealer has the " + c1.showCard(getCard(dealerCards, 0)) + " of " + c1.showSuit(getCard(dealerCards, 0)) + ", the " + c1.showCard(getCard(dealerCards, 1)) + " of " + c1.showSuit(getCard(dealerCards, 1)) + " and the " + c1.showCard(getCard(dealerCards, 2)) + " of " + c1.showSuit(getCard(dealerCards, 2)));
            System.out.println("You have the " + c1.showCard(getCard(playerCards, 0)) + " of " + c1.showSuit(getCard(playerCards, 0)) + ", the " + c1.showCard(getCard(playerCards, 1)) + " of " + c1.showSuit(getCard(playerCards, 1)) + " and the " + c1.showCard(getCard(playerCards, 2)) + " of " + c1.showSuit(getCard(playerCards, 2)));
            System.out.println("You win!");
            System.out.println();
            return 0; //return a win
        }

        //while loop to run when the game is not a win or loss
        while (true) {
            System.out.println();
            //display the player's cards for the amount of cards within the player's hand
            System.out.println("Your cards are:");
            for (int i = 0; i < playerCards.size(); i++) {
                System.out.println("The " + c1.showCard(getCard(playerCards, i)) + " of " + c1.showSuit(getCard(playerCards, i)));
            }
            //gives total value of the hand and prompts the user to hit or stand
            System.out.println("Your total is: " + value(playerCards));
            System.out.println("The dealer is showing the " + c1.showCard(getCard(dealerCards, 0)) + " of " + c1.showSuit(getCard(dealerCards, 0)));
            System.out.println("Would you like to hit (h) or stand? (s)");
            //create a string variable to store the user input
            String userInput;
            //do-while loop to prompt user to enter s or h if they entered input not equal to s or h
            do {
                userInput = scanner.nextLine();
                if (!"h".equals(userInput) && !"s".equals(userInput)) {
                    System.out.println("Please input a valid response.");
                }
            } while ((!"h".equals(userInput) && !"s".equals(userInput)));
            
            //if else statement to determine whether the user hit or stood
            if (userInput.equals("s")) {
                break; //exit loop if stand
            } else { //run code if user hit
                //deal a new card to the user, show the value of the card, and display the total
                int newCard = dealCard();
                playerCards.add(dealCard(), c1.showSuit(4));
                System.out.println("You decide to hit. Your new card is " + c1.showCard(newCard) + " of " + c1.showSuit(newCard));
                System.out.println("Your total is " + value(playerCards));
                //if the user's hand has a value greater than 31, tell player they bust and display dealer's cards. return one to represent a loss
                if (value(playerCards) > 31) {
                    System.out.println("You have busted!");
                    System.out.println("The dealer's other cards were the " + c1.showCard(getCard(dealerCards, 1)) + " of " + c1.showSuit(getCard(dealerCards, 1)) + " and the " + c1.showCard(getCard(dealerCards, 2)) + " of " + c1.showSuit(getCard(dealerCards, 2)));
                    return 1; //return loss
                }
            }
        }
        //exit the loop, state the user stands and display the dealer's cards
        System.out.println("You decide to stand.");
        System.out.println("The dealer's cards are: ");
        System.out.println("    " + c1.showCard(getCard(dealerCards, 0)));
        System.out.println("    " + c1.showCard(getCard(dealerCards, 1)));
        System.out.println("    " + c1.showCard(getCard(dealerCards, 2)));
        //while the value of the dealer's hand is less than 26, continue drawing cards
        while (value(dealerCards) <= 26) {
            int newCard = dealCard();
            System.out.println("The dealer hits and gets the " + c1.showCard(newCard));
            dealerCards.add(dealCard(), c1.showSuit(4));
        }
        System.out.println("The dealer's total is " + value(dealerCards));

        if (value(dealerCards) > 31) { //if the dealer's hand goes over 31, return a 0 to represent a win
            System.out.println("The dealer busted! You win!");
            return 0; //return a win
        } else if (value(dealerCards) == value(playerCards)) { //if the dealer's hand value is equal to the player's hand, return a 3 to represent a tie
            System.out.println("You both have the same value of cards. Nobody wins.");
            return 3; //return a tie
        } else if (value(dealerCards) > value(playerCards)) { //if the dealer's hand value is greater than the player's hand, return a 1 to represent a loss
            System.out.println("The dealer wins with " + value(dealerCards) + " as opposed to your " + value(playerCards));
            return 1; //return a loss
        } else { //else the user wins
            System.out.println("You have won with " + value(playerCards) + " as opposed to the dealer's " + value(dealerCards));
            return 0; //return a win
        }
    }

    //value method to display the value of a hand
    public int value(ArrayList<String> hand) {
        //create local variables
        int value = 0; //value of cards start at 0
        boolean aceFlag = false; //aceflag to determine if the player has an ace in hand or not
        int cards = hand.size(); //amount of cards = the hand size amount

        //for loop to 
        for (int i = 0; i < cards; i++) {
            int card; //the ith card
            int cardValue; //the value of the ith card
            card = getCard(hand, i);
            cardValue = c1.getValue(card);
            //if the value of the card is greater than 10 (Jack, Queen, King)
            if (cardValue > 10) {
                cardValue = 10; //set the value equal to 10
            }
            if (cardValue == 1) { //if the card is an ace
                aceFlag = true; //aceFlag is true
            }
            value = value + cardValue;
        }
        //if you have an ace and the value doesnt put you over 31
        if (aceFlag == true && value + 10 <= 31) {
            value = value + 10; //set the value of the ace to 11
        }
        return value; //return the value of the card
    }

    //getCard method to return an int to represent a card
    public int getCard(ArrayList<String> hand, int position) {
        if (position >= 0 && position <= hand.size()) {
            return hand.indexOf(position);
        } else {
            return 0;
        }
    }
    
    //dealCard method to give players and dealer cards
    public int dealCard() {
        deck = new int[52];
        if (currentPosition == 52) {
            shuffleDeck();
        }
        currentPosition++;
        return deck[currentPosition - 1];
    }
    
    //genDeck method to generate cards
    public void genDeck() {
        deck = new int[52]; 
        int cardCount = 0; //variable for the current amount of cards generated
        //for the 4 suits and for the 13 different values create a deck array at that point
        for (int suit = 0; suit <= 3; suit++) {
            for (int value = 1; value <= 13; value++) {
                deck[cardCount] = value;
                cardCount++;
            }
        }
        currentPosition = 0; //currentposition of the deck is 0
    }
        //shuffleDeck method to create a deck array of random values of cards
        public void shuffleDeck() {
        for (int i = 51; i >= 0; i--) {
            int random = (int) (Math.random() * (i + 1));
            int temp;
            temp = deck[i];
            deck[i] = deck[random];
            deck[random] = temp;
        }
        currentPosition = 0; //currentposition of the deck is 0
    }
}
