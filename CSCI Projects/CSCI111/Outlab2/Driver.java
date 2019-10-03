/**
 * Driver for Outlab2.
 * 
 * @author yaw
 * @version 12 Sep 2016
 */
public class Driver
{
    public static void main(String[] args)
    {
        // Create 4 instances of Ship class.
        Ship ship1 = new Ship("Carrier", 150);
        Ship ship2 = new Ship("Anti-Submarine", 35);
        Ship ship3 = new Ship("Patrol", 22);
        Ship ship4 = new Ship("Destroyer", 83);
        
        // Create instance of Fleet class.
        Fleet fleet1 = new Fleet(ship1, ship2, ship3, ship4);
        
        // Deploy the fleet twice.
        fleet1.deploy();
        fleet1.deploy();
        
        // Refuel the fleet once.
        fleet1.reFuel();
        
        // Print summary.
        fleet1.printSummary();
    }
}
