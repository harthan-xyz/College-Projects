/**
 * Joshua Harthan
 * 10/22/18
 * Graph class to search through graphs with different algorithms.
 */

import java.io.*;
import java.util.*;

public class Graph {
   
    private LinkedList<Integer> adjacent[]; //initialize the queue to hold the values of the graph to be visited
    private int vertices; //make an int to describe the number of vertices within the graph
    
    //constructor to initialize the graph for a specified size
    public Graph(int v)
    {
        vertices = v;
        adjacent = new LinkedList[v];
        for(int i = 0 ; i < v; ++i)
        {
            adjacent[i] = new LinkedList();
        }
        
    }
    
    //function to add edges in the directional graphs for breadth and depth searches
    public void addEdge(int i, int j)
    {
        adjacent[i].add(j);
    }
    
    public void breadthSearch(int num)
    {
        boolean marked[] = new boolean[vertices]; //initialize a boolean array to keep track if the element has been visited or not
        LinkedList<Integer> queue = new LinkedList<Integer>(); //initialize the queue to be used in breadth search
        //initialize the values for the boolean and add the number to the queue
        marked[num] = true;
        queue.add(num);
        
        //while the queue isn't empty
        while(queue.size() != 0)
        {
            //add the number to the queue, and print out the number when popped off the queue
            num = queue.poll();
            System.out.print(num + " ");
            //
            Iterator<Integer> i = adjacent[num].listIterator();
            //while there is a next element in the queue
            while (i.hasNext())
            {
                //set a pointer to the next element
                int a = i.next();
                //set the element in the marked array to true to indicate that it has been visited and add it to the queue
                if(!marked[a])
                {
                    marked[a] = true;
                    queue.add(a);
                }
            }   
        }
    }
    
    public void depth(int num, boolean marked[])
    {
       //initialize the value of the marked array, to tell if the element has been previously visited
       marked[num - 1] = true;
       //print out the number in the queue everytime the method is recursively called
       System.out.println(num + " ");
       
       //initialize an iterator to iterate through the array
       Iterator<Integer> i = adjacent[num].listIterator();
       
       //while there is and element next in the queue
       while(i.hasNext())
       {
           //set a pointer to the next
           int a = i.next();
           if (!marked[a])
           {
               depth(a, marked); //recursively call the method
           }
       }
    }
    
    //depthsearch method that takes in a integer to create an array of specified size
    public void depthSearch(int num)
    {
        boolean marked[] = new boolean[num]; //create a marked array to see if the element was already visted
        //for loop to go through the array and set values within the array
        for(int i = 0; i < num; ++i)
        {
            depth(num, marked);
        }
    }
    
    public void dijkstras(int graph[][], int num)
    {
        //create a integer array of a specified size
       int distance[] = new int[vertices];
       Boolean pathSet[] = new Boolean[vertices]; //pathset array to see if the path is available from a certain element in the graph to another (i.e. if they share an edge)
       int inf = -99; //set the value of infinitiy to see which elements of the graphs are connected
       
       //initialize both of the arrays to their respective, initial values
       for(int i = 0; i < vertices; i++)
       {
           distance[i] = inf;
           pathSet[i] = false;
       }
       
       distance[num] = 0; //set the initial vertex specified to 0
       
       //for loop to set the values within the distance array 
       for(int i = 0; i < vertices - 1; i++)
       {
           int max = inf; //set a maximum value to infinity
           int index = -1; //index value to point to the value in the distance array
           for(int j = 0; j < vertices; j++)
           {
               //if there is not yet a pathset that is less than one already set
               if(pathSet[j] == false && distance[j] <= max)
               {
                   max = distance[j]; //set the initial path to infinity
                   index = j; //set the index to the pointer
                   pathSet[index] = true; //mark this path as set
               }
               for(int a = 0; a < vertices - 1; a++)
               {
                   //if loop that compares the values of each path in the graph, and sets the distance array to the smallest path from current vertex
                   if(!pathSet[a] && graph[index][a]!= 0 && distance[index] != inf && distance[index] + graph[index][a] < distance[a])
                   {
                       distance[a] = distance[index] + graph[index][a];
                   }
               }
           }
        System.out.println(" " + i + "  -> " + distance[i]); //print out the graph
        }
       
    }
    
    public void prims(int graph[][], int num)
    {
        int parent[] = new int[vertices]; //parent array to hold the values of the parent in a tree
        int weight[] = new int[vertices]; //array that holds the weight of the paths
        Boolean pathSet[] = new Boolean[vertices]; //boolean array that keeps track of the paths available
        int inf = -99; //set the value for infinity
        
        //initialze the values of the arrays
        for(int i = 0; i < vertices; i++)
        {
            weight[i] = inf;
            pathSet[i] = false;
        }
        
        //initialize the values of the first values of the array 
        weight[0] = 0;
        parent[0] = -1;
        
        //nested for loops to compare values with the arrays, and swithch values when needed
        for(int i = 0; i < vertices - 1; i++)
        {
            //iniitialize variables to be used in the loops
            int min = inf;
            int index = -1;
            
            for(int j = 0; j < vertices; j++)
            {
                weight[j] = min; //set the value of the weight to be infinity
                index = j; //set the index to the next pointer
            }
            
            //set the boolean array to be marked true for a path present
            pathSet[i] = true;
            
            for (int k = 0; k < vertices; k++)
            {
                //if the weight at a given vertex is less than that already in place, replace the path with smaller weight
                if(graph[index][k] !=0 && pathSet[k] == false && graph[index][k] < weight[k])
                {
                    parent[k] = index;
                    weight[k] = graph[index][k];
                }
            }
        System.out.println(" " + parent[vertices - 1] + "  -> "  + graph[vertices - 1][parent[vertices - 1]]); //print out the graph
        }
    }
        
    public void floydwarshall(int graph[][])
    {
        int distance[][] = new int[vertices][vertices]; //create  a 2d array to create a matrix
        int inf = -99; //initialize the value of infinity
        
        //nested for loops to set the values of the matrix
        for(int i = 0; i < vertices; i++)
        {
            for(int j = 0; j < vertices; j++)
            {
                distance[i][j] = graph[i][j];
            }
        }
        
        //nested for loops to compare the values within the array, and switch arrays when needed
        for(int i = 0; i < vertices; i++)
        {
            for(int j = 0; j < vertices; j++)
            {
                for (int k = 0; k < vertices; k++)
                {
                    if(distance[j][i] + distance[i][k] < distance[j][k])
                    {
                        distance[j][k] = distance[j][i] + distance[i][k];
                    }
                }
            }
        }
        
        //print out the matrix to display the graph input
        for(int i = 0; i < vertices; ++i)
        {
            for(int j = 0; j < vertices; ++j)
            {
                if(distance[i][j] == inf)
                {
                    System.out.print("0 ");
                }
                else
                {
                    System.out.print(distance[i][j] + "  ");
                }
            }
            System.out.println();
        }
    }
    
    //load weighted method that looks for a text file called "weigthed.txt", and loads up the value within the file
    public void loadWeighted() throws FileNotFoundException
    {
        Scanner input = new Scanner(new File ("weighted.txt"));
        if(!input.hasNext())
        {
            int current = 0;
            while(input.hasNext())
            {
                String line = input.nextLine();
                String[] temp = line.split("\\s+");
                for(int i = 0; i < temp.length; i++)
                {
                    if(Integer.parseInt(temp[i]) != 0)
                    {
                        System.out.println(current + " " + i);
                        addEdge(current, i);
                    }
                }
                current++;
            }
        }
    }
    
    //load directional method that looks for a text file called "directional.txt", and loads up the value within the file
    public void loadDirectional() throws FileNotFoundException
    {
        Scanner input = new Scanner(new File ("directional.txt"));
        if(!input.hasNext())
        {
            int current = 0;
            while(input.hasNext())
            {
                String line = input.nextLine();
                String[] temp = line.split("\\s+");
                for(int i = 0; i < temp.length; i++)
                {
                    if(Integer.parseInt(temp[i]) != 0)
                    {
                        System.out.println(current + " " + i);
                        addEdge(current, i);
                    }
                }
                current++;
            }
        }
    }
}
