
/**
 * This is the Cart class to represent a shopping cart.
 * 
 * @author Joshua Harthan    
 * @version 20 Sept 2016 
 */
public class Cart
{
    //instance variables
    private String name;          //shopper name
    private int item1Bought;      //amount bought item 1
    private int item2Bought;      //amount bought item 2
      
    private GroceryItem item1;    //grocery item 1
    private GroceryItem item2;    //grocery item 2 
    
    private int item1Stock;       //measures the amount of items in stock item1
    private int item2Stock;       //measures the amount of items in stock item2
    private int item3Stock;       //measures the amount of items in stock item3
    
    //constructor(s)
    public Cart (String inName)
    {
        name = inName;
    }
    
    //methods
    public String getName() //get name method, return shopper name
    {
        return name;
    }
    public int getBought1() //get bought method, return amount of item1 purchased
    {
        return item1Bought;
    }
    public int getBought2()//get bought method, return amount of item2 purchased
    {
        return item2Bought;
    }
    
    //methods to create the total of one item purchased
    public double getTotal1() 
    {
        return item1.getCost() * item1Bought;
    }
    public double getTotal2()
    {
        return item2.getCost() * item2Bought;
    }
    
    //method to calculate overall total for one item
    public double getOverallTotal()
    {
        return getTotal1() + getTotal2();
    }
    
    //method to calculate tax
    public double getTaxTotal()
    {
        return getOverallTotal() * .07;
    }
    
    //method to calculate final total
    public double getFinalTotal()
    {
        return getOverallTotal() + getTaxTotal();
    }
    
    //parameters to add items to cart
    public void addItem1 (GroceryItem i, int amount1Bought)
    {
        item1 = i;
        item1Bought = amount1Bought;
    }
    public void addItem2 (GroceryItem i, int amount2Bought)
    {
        item2 = i;
        item2Bought = amount2Bought;
    }
    
  
    //update stock
    public int getUpdate1()
    {
        return item1Stock - item1Bought;
    }
    public int getUpdate2()
    {
        return item2Stock - item2Bought;
    }
    
    //print the receipt of the purchase
    public void printReceipt()
    {
        System.out.println("Shopper name: " + name);
        System.out.println("-------------------------");
        System.out.println(item1.getName() + ": " + getBought1() + " unit(s) at $" + item1.getCost() + " per unit = $" + getTotal1());
        System.out.println(item2.getName() + ": " + getBought2() + " unit(s) at $" + item2.getCost() + " per unit = $" + getTotal2());
        System.out.println("  ----> Subtotal = $" + getOverallTotal());
        System.out.println("  ----> 7% tax = $" + getTaxTotal());
        System.out.println("  ----> Total = $" + getFinalTotal());
        System.out.println();
     }

}

