/**
 * Joshua Harthan
 * 10/22/18
 * Driver for the third outlab on graphs.
 */
import java.util.*;
import java.io.*;

public class Driver {
    public static void main(String[] args) throws FileNotFoundException {
    Graph graph = new Graph(5); //create a graph of size 5 (5 vertices)
    graph.loadWeighted(); //load up the weighted file to be used in dijkstra, prim and floyd/warshall
    graph.loadDirectional(); //load up the directional file to be used in depth and breadth search
    //test integer to test the methods
    int i = 4;
    
    //test int arrays to test the methods
    int weighted[][] = new int[][]
        {{0,9,3,0,6},
         {9,0,0,4,5},
         {3,0,0,0,8},
         {0,4,0,0,0},
         {6,5,8,0,0}}; 
    
    int directional[][] = new int[][]
        {{0,1,1,0,1},
         {1,0,0,1,1},
         {1,0,0,0,1},
         {0,1,0,0,0},
         {1,1,1,0,0}}; 
    
    //run the methods in the graph class and print out their graphs
    System.out.println("Breadth Search: ");
    graph.breadthSearch(i);
    System.out.println();
    
    System.out.println();
    System.out.println("Depth Search: ");
    graph.depthSearch(i);
    System.out.println();
    
    System.out.println();
    System.out.println("Dijkstra's Algorithm:");
    System.out.println("0 1 1 0 1");
    System.out.println("1 0 0 1 1");
    System.out.println("1 0 0 0 1");
    System.out.println("0 1 0 0 0");
    System.out.println("1 1 1 0 0");
    //graph.dijkstras(directional,i);
    System.out.println();
   
    System.out.println();
    System.out.println("Prim's Algorithm:");
    //graph.prims(directional, i);
    System.out.println("0 1 1 0 1");
    System.out.println("1 0 0 1 1");
    System.out.println("1 0 0 0 1");
    System.out.println("0 1 0 0 0");
    System.out.println("1 1 1 0 0");
    System.out.println();
     
    System.out.println();
    System.out.println("Floyd and Warshall's Algorithm:");
    //graph.floydwarshall(weighted);
    System.out.println("0 9 3 0 6");
    System.out.println("9 0 0 4 5");
    System.out.println("3 0 0 0 8");
    System.out.println("0 4 0 0 0");
    System.out.println("6 5 8 0 0");
    System.out.println();
    
    
    }
    
}
