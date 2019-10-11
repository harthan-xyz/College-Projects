/**
 *
 * Joshua Harthan
 */

import java.io.*; 

public class Driver {

    
    
    // Function to generate odd sized magic squares 
    static void generateSquare(int n) 
    { 
        int[][] magicSquare = new int[n][n]; //create magic square of 
          
        // Initialize position for 1 
        int row = n/2; 
        int col = n-1; 
   
        // One by one put all values in magic square 
        for (int i = 1; i <= n * n;) 
        { 
            if (row == -1 && col == n) //3rd condition 
            { 
                col = n-2; 
                row = 0; 
            } 
            else
            { 
                //1st condition helper if next number  
                // goes to out of square's right side 
                if (col == n) 
                    col = 0; 
                      
                //1st condition helper if next number is  
                // goes to out of square's upper side 
                if (row < 0) 
                    row = n - 1; 
            } 
              
            //2nd condition 
            if (magicSquare[row][col] != 0)  
            { 
                col -= 2; 
                row++; 
                continue; 
            } 
            else
                //set number 
                magicSquare[row][col] = i++;  
                  
            //1st condition 
            col++;  
            row--;  
        } 
   
        // print the square square 
        System.out.println("The Magic Square for "+ n +":"); 
        System.out.println("Sum of each row or column "+ n *(n *n + 1)/ 2 + ":"); 
        for(row = 0; row < n; row++) 
        { 
            for(col=0; col < n; col++) 
                System.out.print(magicSquare[row][col]+" "); 
            System.out.println(); 
        } 
    }   
        
    public static void main (String[] args)  
    { 
        generateSquare(3); //generate square of size 3
    } 
    
}
