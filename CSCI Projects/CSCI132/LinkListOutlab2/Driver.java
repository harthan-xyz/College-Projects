
/**
 * Joshua Harthan
 * Driver class for the linked list outlab.
 * 2/21/17
 */
import java.util.Scanner;
import java.util.*;
import java.io.*;

public class Driver {

    public static void main(String[] args) throws FileNotFoundException {

        //create a new instance of the the linked list class
        LinkedList list = new LinkedList();
        //create a new scanner to take in user input
        Scanner input = new Scanner(System.in);

        //prompt the user to input a .txt file
        System.out.println("Please input your .txt file:");

        //make an instance of a scanner that reads in a .txt file and set appropriate values equal to what is being read in
        Scanner inFile = new Scanner(new FileReader(input.nextLine()));
        int numCandidates = inFile.nextInt();
        int pointerK = inFile.nextInt();
        int pointerM = inFile.nextInt();

        //if statement to run the program while the correct parameters are present 0 < N < 100, k,m < 0
        if ((numCandidates > 0) && (numCandidates < 100) || (pointerK > 0) || (pointerM > 0)) {
            //while the numbers in the file do not equal 000
            while ((((numCandidates != 0) && (pointerK != 0) && (pointerM != 0)))) {
                try {//try catch to write output into a .txt document
                    //setup the things needed for file output
                    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
                    PrintStream out = new PrintStream(new FileOutputStream("LinkedListProgram.txt"));
                    System.setOut(out);
                    //the results to be printed out
                    out.println();
                    out.println("Program Start");
                    out.println("-------------");
                    out.println("N = " + numCandidates + ", k = " + pointerK + ", m = " + pointerM);
                    out.println();
                    //add candidates for the amount input
                    for (int index = 1; index <= numCandidates; index++) {
                        list.addCandidate(index);
                    }
                    out.print(list.displayCandidates());
                    out.println();
                    out.println("Output");
                    out.println("-------------");
                    //if the pointers are in different locations, print out the values and run the delete method at these points
                    if (list.getPointerK(pointerK) != list.getPointerM(pointerM)) {
                        out.println("The candidates who have been eliminated:");
                        list.getPointerK(pointerK);
                        list.getPointerM(pointerM);
                        list.deleteAtPointer(pointerK);
                        list.deleteAtPointer(pointerM);
                    } //else if the pointers are in the same place, print out the values
                    else if (list.getPointerK(pointerK) == list.getPointerM(pointerM)) {
                        out.println("The candidates who have been chosen:");
                        list.getPointerK(pointerK);
                        list.deleteAtPointer(pointerK);
                        out.println();
                        out.println("End of Program");
                        out.println();
                    }
                    out.close();
                    numCandidates = inFile.nextInt();
                    pointerK = inFile.nextInt();
                    pointerM = inFile.nextInt();
                    list.makeEmpty();

                } catch (IOException e) {
                    System.out.println("An error occured."); //if the file could not be written to, display this error message
                }
            }
        } else { //if the program does not abide by the parameters set, print out this message
            System.out.println("One of the parameters is incorrect, and a candidate cannot be determined.");
        }
    }
}
