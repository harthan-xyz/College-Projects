
/**
 * Joshua Harthan
 * Maze class for the recursion outlab.
 * 3/7/17
 */
public class Maze {

    //instance variable to define the maze array
    private char[][] maze;

    //empyt constructor
    public Maze() {

    }

    //fill the array with characters representing the maze
    public void createMaze() {
        //hardcode in the maze using strings
        String Line0 = "############";
        String Line1 = "#...#......#";
        String Line2 = "..#.#.####.#";
        String Line3 = "###.#....#.#";
        String Line4 = "#....###.#.#";
        String Line5 = "####.#F#.#.#";
        String Line6 = "#..#.#.#.#.#";
        String Line7 = "##.#.#.#.#.#";
        String Line8 = "#........#.#";
        String Line9 = "######.###.#";
        String Line10 = "#......#...#";
        //create the 12 x 12 array
        maze = new char[12][12];
        //use for loops to fill in the array row by row
        for (int i = 0; i <= 11; i++) {
            maze[0][i] = Line0.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[1][i] = Line1.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[2][i] = Line2.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[3][i] = Line3.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[4][i] = Line4.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[5][i] = Line5.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[6][i] = Line6.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[7][i] = Line7.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[8][i] = Line8.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[9][i] = Line9.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[10][i] = Line10.charAt(i);
        }
        for (int i = 0; i <= 11; i++) {
            maze[11][i] = Line0.charAt(i);
        }

    }

    //print array method
    public void printMaze() {
        for (int row = 0; row <= 11; row++) {
            for (int col = 0; col <= 11; col++) {
                System.out.print(maze[row][col] + " "); //print out the maze one time
            }
            System.out.println();
        }
        System.out.println(); //create a line after printing the maze
    }

    //run array method that will be run recursively
    public void runMaze(int xPos, int yPos, int inhandX, int inhandY) {
        //local variables to determine what direction the x is facing
        int directionFacing = 0;
        int north = 1;
        int east = 2;
        int south = 3;
        int west = 4;

        //local varables to set values in the parameter equal to values used in the method
        int xpos = xPos;
        int ypos = yPos;
        int handX = inhandX;
        int handY = inhandY;
        
        //while loop to continue until the finish is found
        while (maze[5][6] == 'F') {
            printMaze();//print the maze everytime the method is called

            //if else statements to determine what direction the character is facing
            if (handX > xpos && handY == ypos) {
                directionFacing = north;
            } else if (handX == xpos && handY > ypos) {
                directionFacing = east;
            } else if (handX < xpos && handY == ypos) {
                directionFacing = south;
            } else if (handX == xpos && handY < ypos) {
                directionFacing = west;
            }
            //First Case - if there is an . or x on the hand position, turn towards that direction and move forward
            if (maze[handY][handX] == '.' || maze[handY][handX] == 'x') {
                maze[handY][handX] = 'o'; //mark current position with an o
                maze[ypos][xpos] = 'x'; //mark previous location with x
                //move the x to where the hand was located
                xpos = handX;
                ypos = handY;
                //for different directions facing, move 90 degrees
                if (directionFacing == north) {
                    directionFacing = east;
                } else if (directionFacing == east) {
                    directionFacing = south;
                } else if (directionFacing == south) {
                    directionFacing = west;
                } else if (directionFacing == west) {
                    directionFacing = north;
                }

                //after moving 90 degrees, move the position of the hand
                if (directionFacing == north) {
                    handX = xpos + 1;
                    handY = ypos;
                } else if (directionFacing == east) {
                    handX = xpos;
                    handY = ypos + 1;
                } else if (directionFacing == south) {
                    handX = xpos - 1;
                    handY = ypos;
                } else if (directionFacing == west) {
                    handX = xpos;
                    handY = ypos - 1;
                }
                //recursively run the program
                runMaze(xpos, ypos, handX, handY);
            } //Second Case - if there is . or x in front, move forward
            if (directionFacing == north) {
                if (maze[ypos - 1][xpos] == '.' || maze[ypos - 1][xpos] == 'x') {
                    maze[ypos - 1][xpos] = 'o'; //mark current position with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    //change the position of the o and the hand
                    xpos = xpos;
                    ypos = ypos - 1;
                    handX = xpos + 1;
                    handY = ypos;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                }
            } else if (directionFacing == east) {
                if (maze[ypos][xpos + 1] == '.' || maze[ypos][xpos + 1] == 'x') {
                    maze[ypos][xpos + 1] = 'o'; //mark current position with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    //change the position of the o and the hand
                    xpos = xpos + 1;
                    ypos = ypos;
                    handX = xpos;
                    handY = ypos + 1;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                }
            } else if (directionFacing == south) {
                if (maze[ypos + 1][xpos] == '.' || maze[ypos + 1][xpos] == 'x') {
                    maze[ypos + 1][xpos] = 'o'; //mark current position with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    //change the position of the o and the hand
                    xpos = xpos;
                    ypos = ypos + 1;
                    handX = xpos - 1;
                    handY = ypos;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                }
            } else if (directionFacing == west) {
                if (maze[ypos][xpos - 1] == '.' || maze[ypos][xpos - 1] == 'x') {
                    maze[ypos][xpos - 1] = 'o'; //mark current position with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    //change the position of the o and the hand
                    xpos = xpos - 1;
                    ypos = ypos;
                    handX = xpos;
                    handY = ypos - 1;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                }
            } //Third Case - if there is # in front and on hand
            if (maze[handY][handX] == '#') {
                if (directionFacing == north && maze[ypos - 1][xpos] == '#') {
                    //hand position west
                    handX = xpos - 1;
                    handY = ypos;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                } else if (directionFacing == east && maze[ypos][xpos + 1] == '#') {
                    //hand position north
                    handX = xpos;
                    handY = ypos - 1;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                } else if (directionFacing == south && maze[ypos + 1][xpos] == '#') {
                    //hand position east
                    handX = xpos + 1;
                    handY = ypos;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                } else if (directionFacing == west && maze[ypos][xpos - 1] == '#') {
                    //hand position south
                    handX = xpos;
                    handY = ypos + 1;
                    //recursively run the program
                    runMaze(xpos, ypos, handX, handY);
                }
            } //Fourth Case - If the finish is in front of the o for facing different directions 
            if (directionFacing == north) {
                if (maze[yPos - 1][xPos] == 'F') {
                    maze[yPos - 1][xPos] = 'o'; // marks with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    printMaze(); //print the current maze
                    System.out.println("You have completed the maze! \n");
                }

            } else if (directionFacing == east) {
                if (maze[yPos][xPos + 1] == 'F') {
                    maze[yPos][xPos + 1] = 'o'; // marks with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    printMaze(); //print the current maze
                    System.out.println("You have completed the maze! \n");
                }

            } else if (directionFacing == south) {
                if (maze[yPos + 1][xPos] == 'F') {
                    maze[yPos + 1][xPos] = 'o'; // marks with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    printMaze(); //print the current maze
                    System.out.println("You have completed the maze! \n");
                }

            } else if (directionFacing == west) {
                if (maze[yPos][xPos - 1] == 'F') {
                    maze[yPos][xPos - 1] = 'o'; // marks with an o
                    maze[ypos][xpos] = 'x'; //mark previous location with x
                    printMaze(); //print the current maze
                    System.out.println("You have completed the maze! \n");
                }
            }
        }
    }
}
