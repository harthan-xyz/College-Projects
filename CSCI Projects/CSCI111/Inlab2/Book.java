
/**
 * This is a class to represent the book.
 * 
 * @Joshua Harthan 
 * @13 Sep 2016
 */
public class Book
{
    //instance variables
    private String bookName;
    private int bookStock;
    private double bookCost;  
    //constructor
    public Book (String inName, int inStock, double inCost)
    {
        bookName = inName;
        bookStock = inStock;
        bookCost = inCost;
    }
    //methods
    public String getName()
    {
        return bookName;
    }
    public int getStock ()
    {
        return bookStock;
    }    
    public double getCost ()
    {
        return bookCost;
    }  
    public double totalValue ()
    {
        return bookCost * bookStock;
    }
}   
    