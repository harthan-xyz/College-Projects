/**
 * GroceryItem Inlab.
 * 
 * @author yaw 
 * @version 16 Sep 2016
 */
public class GroceryItem
{
    private String name;        //item name
    private double cost;        //cost of 1 unit of item
    private int itemStock;      //used to measure items in stock
   
    // constructor for GroceryItems
    public GroceryItem(String inName, double inCost, int inStock)
    {
        name = inName;
        cost = inCost;
        itemStock = inStock;
    }
    
    // returns the item's name
    public String getName()
    {
        return name;
    }
    
    // returns the cost of 1 item
    public double getCost()
    {
        return cost;
    }
    
    // returns the amount of items in stock
    public int getStock()
    {
        return itemStock;
    }
    
    //method to find updated stock
 
   
    //calculates the updated stock
    public int updatedStock(int c)
    {
        return getStock() - c;
    }
    
    
    public void printStock()
    {   
        System.out.println("There are " + updatedStock(0) + " units of " + getName() + " in stock");
    }
}
