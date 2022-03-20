
/**
 * Driver for Inlab 8
 * 
 * @author yaw 
 * @version 26 Oct 2016
 */
public class Driver
{
    public static void main(String[] args)
    {
        //create a new array with 5 slots
        Array a = new Array(5);
        
        //fill the array with random values
        a.fill();
        
        //print the array
        System.out.println("Original:");
        a.print();
        
        //sort the array
        a.sort();
        System.out.println("Sorted:");
        a.print();
        
        //print out the frequency of each potential value
        //System.out.println("Frequencies:");
        //a.printFrequency();
        
        System.out.println();
        
        //create second array with 10 slots
        Array b = new Array(10);
        b.fill();
        System.out.println("Original:");
        b.print();
        System.out.println("Sorted:");
        b.sort();
        b.print();
        //System.out.println("Frequencies:");
        //b.printFrequency();
    }
}