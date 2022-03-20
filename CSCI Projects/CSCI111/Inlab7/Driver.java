
/**
 * Write a description of class Driver here.
 * 
 * @author yaw
 * @version 21 Oct 16
 */
public class Driver
{
    public static void main(String[] args)
    {
        //create new instance of the ArrayLab class with parameter of 10
        ArrayLab array = new ArrayLab(10);
        
        //print out the array created by ArrayLab constructor
        array.print();
        
        //initialize the array with random values
        array.initialize();
        
        //print the randomized array
        array.print();
        
        //print stats for the array
        array.printStats();
        
        //search for 3
        array.search(3);
        
        //search for 2
        array.search(2);
    }
}