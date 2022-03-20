
import java.io.PrintWriter;
import java.util.Scanner;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Owner
 */
public class WeightMatrix {
    private int children;
    private int weights;
    private int[] weight = new int[children];
    
    public WeightMatrix(int numChildren, int maxWeight)
    {
        weights = maxWeight;
        children = numChildren;
        weight[numChildren] = maxWeight;
    }
    
    public void readWeights(Scanner in)
    {
    
    }
    
    public int solve(int children, int index)
    {
       int[][] table = new int[children][index];
       index = 0;
       if (children > weight[index])
       {
           if(table[children][index + 1] == 0)
           {
               table[children][index + 1] = solve(children, index + 1);
           }
           return table[children][index + 1];
       }
        else{
               if(table[children][index + 1] == 0)
               {
                   table[children][index + 1] = solve(children, index + 1);
               }
               if(table[children - weight[index]][index + 1] == 0)
               {
                   table[children - weight[index]][index + 1] = solve(children, index + 1);
               }
            return Math.max(table[children][index + 1], weight[index] + table[children - weight[index]][index + 1]);
           }
    }
    

    public void printSolution(PrintWriter out)
    {
        for(int i = 0; i < children; i++)
        {
        System.out.print("Team 1: " + weight[i]);
        System.out.println();
        }
        
        for(int i = 0; i < children; i++){
        System.out.print("Team 2: " + weight[i]);
        System.out.println();
        }

        
        System.out.println("The weight difference is " + );
        System.out.println();
    }
}
