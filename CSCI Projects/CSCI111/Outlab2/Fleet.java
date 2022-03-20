
/**
 * This is the class to represent the entire fleet
 * 
 * @author Joshua Harthan 
 * @version 26 Sept 2016
 */
public class Fleet
{
    //instance variables to identify the ships and their fuel
    private Ship ship1;       //ship 1 variable
    private Ship ship2;       //ship 2 variable
    private Ship ship3;       //ship 3 variable
    private Ship ship4;       //ship 4 variable

    //constructors
    public Fleet (Ship inShipName1, Ship inShipName2, Ship inShipName3, Ship inShipName4 )
    {
        ship1 = inShipName1;    //parameter for ship1
        ship2 = inShipName2;    //parameter for ship2
        ship3 = inShipName3;    //parameter for ship3
        ship4 = inShipName4;    //parameter for ship4
    }

    //methods
    public void deploy() //deploy method to deploy the fleet, updates and tracks the fuel consumed when deployed
    {
        ship1.updateFuel();
        ship1.getFuelConsumed();
        ship2.updateFuel();
        ship2.getFuelConsumed();
        ship3.updateFuel();
        ship3.getFuelConsumed();
        ship4.updateFuel();
        ship4.getFuelConsumed();
    }
    
    public void reFuel() //refuel method to refuel the fleet
    {
       ship1.reFuel();
       ship2.reFuel();
       ship3.reFuel();
       ship4.reFuel();
    }
    
    public void printSummary()  //print the name of the ship and fuel units consumed
    {
        System.out.println("Fleet Summary:");
        System.out.println(ship1.getShip() + " has consumed " + ship1.getFuelConsumed() + " fuel units");
        System.out.println(ship2.getShip() + " has consumed " + ship2.getFuelConsumed() + " fuel units");
        System.out.println(ship3.getShip() + " has consumed " + ship3.getFuelConsumed() + " fuel units");
        System.out.println(ship4.getShip() + " has consumed " + ship4.getFuelConsumed() + " fuel units");
    }
}
    
    


