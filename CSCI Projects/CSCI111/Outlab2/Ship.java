
/**
 * This is the class to represent the individual ships
 * 
 * @author Joshua Harthan
 * @version 26 Sept 2016
 */
public class Ship
{
    //instance variables to name the indiviudal ships
    private String ship;        //ship name
    private int fuel;           //amount of fuel that the ship currently has
    private int fuelCapacity;   //amount of fuel that a ship can have
    private int fuelConsumed;   //amount of fuel that the ship consumed
    
    //constructors
    public Ship (String inShip, int inFuel)
    {
       ship = inShip;           //parameter for the name
       fuelCapacity = inFuel;   //parameter for the ship fuel
       fuel = inFuel;           //parameter to state the current fuel
    }
    
    //methods
    public String getShip()     //return ship name method
    {
        return ship;
    }
    public int getFuel()        //return fuel method
    {
        return fuel;
    }
    
    public int updateFuel()     //update fuel method
    {
        fuel = fuel/2;
        return fuel;
    }
    
    public void reFuel()        //method to refuel the ship
    {
        fuelConsumed = fuelCapacity - fuel;
        fuel = fuelCapacity;
    }
    
    public int getFuelConsumed() //tracks fuel consumed
    {
       return fuelConsumed;
    }
    
 
    


}
