
/**
 * The card class for the Blackjack game to hold values of cards.
 *
 * @author Joshua Harthan
 *  2/1/17
 */
public class Card {

    private int result; //variable to represent player score
    private String suit; //variable to represent the suit of the card
    private String card; //variable to represent the card e.g. "king" , "one"

    //empty constructor
    public Card() {

    }

    //getSuit method to return the value of the suit
    public String getSuit() {
        return suit;
    }

    //getCard methdo to return the value of the card
    public String getCard() {
        return card;
    }

    //getValue method to return how much the card is worth
    public int getValue(int cardValue) {
        //set result to parameter cardValue
        result = cardValue;
        //switch statement to determine thh value of the card
        switch (cardValue) {
            case 2:
                result = 2;
            case 3:
                result = 3;
            case 4:
                result = 4;
            case 5:
                result = 5;
            case 6:
                result = 6;
            case 7:
                result = 7;
            case 8:
                result = 8;
            case 9:
                result = 9;
            case 10:
            case 11: //jack
            case 12: //queen
            case 13: //king
                result = 10;
        }
        return result;
    }

    //showSuit method to determine the value of the suit
    public String showSuit(int card) {
        //switch statement to determine the suit 
        switch (card) {
            case 1:
                return "clubs";
            case 2:
                return "spades";
            case 3:
                return "hearts";
            case 4:
                return "diamonds";
            default:
                return "";
        }
    }
    
    //showCard method to show what the card is 
    public String showCard(int card) {
        switch (card) {
            case 1:
                return "Ace";
            case 2:
                return "2";
            case 3:
                return "3";
            case 4:
                return "4";
            case 5:
                return "5";
            case 6:
                return "6";
            case 7:
                return "7";
            case 8:
                return "8";
            case 9:
                return "9";
            case 10:
                return "10";
            case 11:
                return "Jack";
            case 12:
                return "Queen";
            case 13:
                return "King";
            default:
                return "";
        }
    }
}
