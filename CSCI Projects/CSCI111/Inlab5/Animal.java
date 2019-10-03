
/**
 * This class will represent an unknown animal.  It has some
 * number of legs, an environment it lives in, and a 
 * true/false assessment of whether it seems nice or not.
 * 
 * @author yaw 
 * @version 30 Sep 2016
 */
public class Animal
{
    private int numLegs;
    private String environment;     //"land", "air", "water"
    private boolean seemsNice;
    
    public Animal(int inNumLegs, String inEnvironment, boolean inSeemsNice)
    {
        numLegs = inNumLegs;
        environment = inEnvironment;
        seemsNice = inSeemsNice;
    }
    
    public int getNumLegs()
    {
        return numLegs;
    }
    
    public String getEnvironment()
    {
        return environment;
    }
    
    public boolean getSeemsNice()
    {
        return seemsNice;
    }
    
}