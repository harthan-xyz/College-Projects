
/**
 * This is the ArrayLab class to create an array that holds a certain amount of numbers.
 * 
 * @author Joshua Harthan 
 * @version 25Oct2016
 */
public class ArrayLab
{
    private int[] array;    //create the array
    public ArrayLab(int numArray)//constructor of the array, set the index number
    {
        array = new int[numArray];//state that there will be a certain amount of numbers in array
    }
    
    public void initialize ()   //initialize method to set random numbers in the array
    {
        for (int i = 0; i < array.length; i++)
        {
            array[i] = (int) (Math.random() * 11);  //numbers between 0 and 10
        }
    }
    
    public void print() //print method to print out the value of the numbers in the array
    {
        for (int i = 0; i < array.length; i++)
        {
            System.out.print(array[i] + ",");   //print out the values in the array
        }
        System.out.println("\n");
    }

    public void printStats() //printstats method to set and print out the average, min, and max values of the array
    {
        double avgValue = 0.0; //set the initial value of the average value
        int maxValue = 0;   //set the initial value of the max value
        int minValue = 10;  //set the initial value of the min value
        for (int i = 0; i < array.length; i++)
        {    
            avgValue += (double)array[i] / array.length;  //calculate the avg value of the array
            if (maxValue < array[i])    //if the value is greater than the number in the array
            {
                maxValue = array[i];    //set the value to that number
            }
            else if (minValue > array[i])//if the value is less than the number in the array
            {
                minValue = array[i];    //set the value to that number
            }
        }
        System.out.println("Average Value: " + avgValue);   //print out the avg value
        System.out.println("Maximum Value: " + maxValue);   //print out the max value
        System.out.println("Minimum Value: " + minValue);   //print out the min value
    }

    public void search(int t) //search method that looks in the array for specific values
    {
        for (int i = 0; i < array.length; i++)
        {
            if (array[i] == t) //if array value equals the specific value
            {
                System.out.println(t + " was found.");
                break;
            }
            else if (array[i] != t && i == array.length -1)   //if the array does not equal the specific value
            {
                System.out.println(t + " was not found.");
            }
        }
    }
}
