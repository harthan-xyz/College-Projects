
/**
 * This is the Array class to set random values in an array and sort them numerically.
 * 
 * @author Joshua Harthan
 * @version 1Nov2016
 */
public class Array
{
    private int[] array;        //int array instance variable

    public Array(int numSlots)  //create the array with the specified number of slots
    {
        array = new int[numSlots];
    }

    public void fill()  //fill method to fill the array with random numbers
    {
        for (int i = 0; i < array.length; i++)
        {
            array[i] = (int) (Math.random() * 10); //numbers between 0 and 9
        }
    }

    public void print() //print method to print out the values of the array and dashed lines
    {
        for (int i = 0; i < array.length; i++)
        {
            System.out.println("---------------------");
            for (i = 0; i < array.length; i++)
            {
                System.out.print("|" + array[i]);
            }
            System.out.print("|");
            System.out.println();
            System.out.println("---------------------");
        }
    }

    public void sort()  //sort method that sorts the array into numerical order
    {
        for (int i = 0; i < array.length; i++) 
        {
            for(int j = 0; j < array.length; j++)  
            {
                if(array[j] > array[i])     //if the value is less than the next value
                {
                    int value = array[j];   //create a local variable to store a value 
                    array[j] = array[i];    //set the 
                    array[i] = value;       //set the value read to the value in the array
                }
            }
        }
    }
}
