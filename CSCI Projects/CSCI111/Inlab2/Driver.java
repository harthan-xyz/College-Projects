
/**
 * This is the driver class
 * 
 * @Joshua Harthan 
 * @13 Sep 2016
 */
public class Driver
{
    public static void main(String[] args)
    {
        Book book1 = new Book("Dracula", 22, 7.55);
        Book book2 = new Book("Frankenstein", 30, 5.99);
        
        System.out.println(book1.getName() + " costs $" + book1.getCost() + " and the number of books in stock is " + book1.getStock() + "; the total value of books is $" + book1.totalValue());
        System.out.println(book2.getName() + " costs $" + book2.getCost() + " and the number of books in stock is " + book2.getStock() + "; the total value of books is $" + book2.totalValue());
    }


}