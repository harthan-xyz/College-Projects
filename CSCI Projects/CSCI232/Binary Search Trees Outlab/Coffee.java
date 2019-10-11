/**
 *
 * @author Joshua Harthan
 * Coffee class that stores and sets the values for the price, company and color of the coffee.
 */
public class Coffee implements Comparable{
    
    //create variables to represent the price, company and color of the coffee, the variables that we are comparing
    private double price;
    private String company;
    private String color;
    
    //constructor that sets the values for each variable input when the class is called
    Coffee(String company, String color, double price)
    {
        this.company = company;
        this.color = color;
        this.price = price;
    }
    
    //compare to method that compares the price, company and color of the coffee to return an int for comparison and rearrangement
    public int compareTo(Object coffee)
    {
        //create an instance of coffee that compares the coffee that was input to the coffe prior
        Coffee otherCoffee = (Coffee) coffee;
        //print statements to debug whether the coffee is being compared correctly
        System.out.println("compare to being called " + price + " and " + otherCoffee.price);
        System.out.println("compare to being called " + company + " and " + otherCoffee.company);
        System.out.println("compare to being called " + color + " and " + otherCoffee.color);
        
        //if the price of the coffee is less than that it is being compared to
        if (price < otherCoffee.price)
        {
            return -1; //return a value of -1 to reperesent less than, and to put as a left child
        }
        //else if the price of the coffee is equivalent to that which it is being compared with, compare the company
        else if (price == otherCoffee.price)
        {
            //if the company being compared is different to that of the company that is input  
            if (company.compareTo(otherCoffee.company) < 0)
            {
                return -1; //return a value of -1 to reperesent less than, and to put as a left child
            }
            //else if the company is equivalent to that which it is being compared with, compare the color
            else if (company.compareTo(otherCoffee.company) == 0)
            {
                //if the color being compared is different to that of the coffee that is inupt
                if(color.compareTo(otherCoffee.color) < 0)
                {
                return -1; //return a value of -1 to reperesent less than, and to put as a left child
                }
                //else if the color of the company is equivalent to that being compared 
                else if (color.compareTo(otherCoffee.color) == 0)
                {
                    return 0; //return a value of 0 to represent t
                }
                else
                {
                    return 1; //return a value of 1 to reperesent greater than, and to put as a right child
                }
            }
            else
            {
                return 1;  //return a value of 1 to reperesent greater than, and to put as a right child
            }
        }
        else
        {
            return 1;  //return a value of 1 to reperesent greater than, and to put as a right child
        }
    }
    
    //toString method to print out the values stored in each variable
    public String toString()
    {
        return company + " sells the " + color  + " coffee for $" + price;
    }
        
}
