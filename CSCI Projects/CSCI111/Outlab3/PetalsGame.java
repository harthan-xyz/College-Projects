
/**
 * Petals game class. Rolls dice and calculates the amount of petals around the dice.
 * 
 * @author Joshua Harthan
 * @version 10 Oct 2016
 */
public class PetalsGame
{    
    private int roll1;      //die value of die one
    private int roll2;      //die value of die two
    private int roll3;      //die value of die three
    private int roll4;      //die value of die four
    private int roll5;      //die value of die five
    
    public static int petalValue;  //value of the petals
    public static int currentRole; //value of the current role
    
    // roll dice funciton to find a random value
    public int rollDice()
    {   
        //random roll between 1 and six for each 5 dice
        roll1 = (int) (Math.random() * 6 + 1);
        if (roll1 == 3)
        {
           petalValue += 2;    //a value of 2 is achieved after rolling a 3
        }
        else if (roll1 == 5)
        {
            petalValue += 4;   //a  value of 4 is achieved after rolling a 5 
        }
        else 
        {
            petalValue += 0;   //a value of 0 is acheived for any other die roll
        }
        roll2 = (int) (Math.random() * 6 + 1);
        if (roll2 == 3)
        {
           petalValue += 2;    //a value of 2 is achieved after rolling a 3
        }
        else if (roll2 == 5)
        {
            petalValue += 4;   //a  value of 4 is achieved after rolling a 5 
        }
        else 
        {
            petalValue += 0;   //a value of 0 is acheived for any other die roll
        }        
        roll3 = (int) (Math.random() * 6 + 1);
        if (roll3 == 3)
        {
           petalValue += 2;    //a value of 2 is achieved after rolling a 3
        }
        else if (roll3 == 5)
        {
            petalValue += 4;   //a  value of 4 is achieved after rolling a 5 
        }
        else 
        {
            petalValue += 0;   //a value of 0 is acheived for any other die roll
        }        
        roll4 = (int) (Math.random() * 6 + 1);
        if (roll4 == 3)
        {
           petalValue += 2;    //a value of 2 is achieved after rolling a 3
        }
        else if (roll4 == 5)
        {
            petalValue += 4;   //a  value of 4 is achieved after rolling a 5 
        }
        else 
        {
            petalValue += 0;   //a value of 0 is acheived for any other die roll
        }        
        roll5 = (int) (Math.random() * 6 + 1);
        if (roll5 == 3)
        {
           petalValue += 2;    //a value of 2 is achieved after rolling a 3
        }
        else if (roll5 == 5)
        {
            petalValue += 4;   //a  value of 4 is achieved after rolling a 5 
        }
        else 
        {
            petalValue += 0;   //a value of 0 is acheived for any other die roll
        }
        return petalValue;
    }
    
    //print out the value of the rolls you randomly rolled
    public void printDice()
    {
        System.out.println("You rolled the following: " + roll1 + ", " + roll2 + ", " + roll3 + ", " + roll4 + ", " + roll5);
    }
    
    //calculate the value of the petals of the dice
    public static int calculateAllPetals()
    {
        currentRole = petalValue;
        petalValue = 0;         //resets the value of the petals per role
        return currentRole;
    }

}
