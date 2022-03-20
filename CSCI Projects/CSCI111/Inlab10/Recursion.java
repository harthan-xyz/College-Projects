/**
 * Recursion class to iterate through an array and find its minimum value and the index in which the minimum value is located.
 * 
 * @author Joshua Harthan 
 * @version 29 Nov 2016
 */
public class Recursion
{
    public static void print(int[] array)
    {
        for(int i = 0; i < array.length; i++)   //iterate through the array
        {
            System.out.print(array[i] + ",");   //print out the values of the numbers within the array
        }
        System.out.println();   //formatting
    }

    public static int smallest(int[] array)
    {
        return smallestFrom(array, 0);
    }

    private static int smallestFrom(int[] array, int start)
    {
        if (start == array.length - 1)  //if the start index equals the length of the array minus one
        {
            return array[start];    //return the value of the array at that point
        }
        int value = smallestFrom(array, start + 1);     //create a local integer that equals the method smallestFrom/recursion
        if (array[start] < value)   //if the array at a point is less than the value integer
        {
            return array[start];    //return the value of the array at that point
        }
        else
        {
            return value;   //else return the value integer
        }
    }

    public static int smallestIndex(int[] array)
    {
        return smallestIndexFrom(array, 0);
    }

    private static int smallestIndexFrom(int[] array, int start)
    {
        if (start == array.length - 1) //if the start index equals the lenght of the array minus one
        {
            return start;   //return the value of the index at that point
        }
        int indexValue = smallestIndexFrom(array, start + 1);   //create a local integer that equals the method smallestIndexFrom/recursion
        if (array[start] < array[indexValue])   //if the array at a point is less than the value of the array at indexValue
        {
            return start;   //return the value of the index at that point
        }
        else
        {
            return indexValue;  //else return the indexValue integer
        }
    }
}