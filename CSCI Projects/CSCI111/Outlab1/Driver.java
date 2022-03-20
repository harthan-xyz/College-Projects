
/**
 * This is the Driver for Outlab 1.  Do not modify this file or else you will lose points.
 * 
 * @author yaw 
 * @version 28 Aug 2014
 */
public class Driver
{
    public static void main(String[] args)
    {
        GroceryItem item1 = new GroceryItem("Milk", 2.99, 4);
        GroceryItem item2 = new GroceryItem("Cookies", 4.85, 2);
        GroceryItem item3 = new GroceryItem("Pasta", 1.50, 1);
        
        System.out.println(item1.getName() + " costs $" + item1.getCost() + " and can be found in aisle " + item1.getAisle());
        System.out.println(item2.getName() + " costs $" + item2.getCost() + " and can be found in aisle " + item2.getAisle());
        System.out.println(item3.getName() + " costs $" + item3.getCost() + " and can be found in aisle " + item3.getAisle());
   
        System.out.println("\nChanging Costs... \n");
        item1.changeCost(3.25);
        item2.changeCost(4.25);
        item3.changeCost(1.75);
        
        System.out.println(item1.getName() + " now costs $" + item1.getCost());
        System.out.println(item2.getName() + " now costs $" + item2.getCost());
        System.out.println(item3.getName() + " now costs $" + item3.getCost());
    }
}
