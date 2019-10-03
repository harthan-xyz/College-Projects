/**
 * Joshua Harthan
 * Driver class for the recursion outlab.
 * 3/7/17
 */
public class Driver {


    public static void main(String[] args) {
        //create a new instance of the maze class
        Maze maze = new Maze();
        
        //run the methods to create, print and run the maze program
        maze.createMaze();
        maze.printMaze();
        maze.runMaze(0,2,0,3);
    }
    
}
