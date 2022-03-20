
/**
 * This is a class to represent a player
 * 
 * @author Joshua Harthan 
 * @version 27 Sept 2016
 */
public class Player
{
    //instance variables
    private String name;            //variable to represent player name
    private int numAtBat;           //variable to represent a player's at bat
    private int numHit;             //variable to represent a player's hits
    private double battingAvg;      //variable to represent a player's batting average
    
    //constructors
    public Player (String inName)
    {
        name = inName;
    }
    
    //methods
    public String getName()             //get name method
    {
        return name;
    }
    
    public int getAtBats()              //get at bat method
    {
        return numAtBat;
    }
    
    public int getHits()                //get hit method
    {
        return numHit;
    }
    
    public double getAvg()              //get batting average method
    {
        return battingAvg;
    }
    
    public double addBattingAvg()       //method to calculate the player's batting average
    {
        battingAvg = ((double)getHits() / getAtBats());
        return battingAvg;
    }
    
    public int addAtBats (int inAtBats) //method to add players' at bat
    {
        numAtBat = inAtBats;
        return numAtBat;
    }
    
    public int addHits (int inHits)     //method to add players' hits
    {
        numHit = inHits;
        return numHit;
    }
}
