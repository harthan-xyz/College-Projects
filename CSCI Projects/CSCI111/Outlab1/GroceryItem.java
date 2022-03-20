
/**
 * This is a class to hold information items in a store.
 * 
 * @author Joshua Harthan 
 * @version 12Sept16
 */
public class GroceryItem
{
    private String name; 
    private double cost; 
    private int aisleNum; 
//constructor
public GroceryItem (String itemName, double itemCost, int itemAisle)
{
    name = itemName;
    cost = itemCost;
    aisleNum = itemAisle;
}

//methods
public String getName () 
{
    return name;
}

public double getCost ()
{
    return cost;
}    

public int getAisle ()
{
    return aisleNum;
}

public void changeCost (double newCost)
{
    cost = newCost;
}

}