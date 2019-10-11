
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;


/**
 * Joshua Harthan
 * InLab7 Driver
 * 
 */
public class Driver {

public static void main(String [] args) throws FileNotFoundException
{
int weightMax;
WeightMatrix weights;
 
Scanner in = new Scanner (new File ("balanced.in"));
PrintWriter out = new PrintWriter (new File ("balanced.out"));

while(in.hasNext())
{
    int numberChildren = in.nextInt();
    weightMax = in.nextInt();
    weights = new WeightMatrix(numberChildren, weightMax);
    weights.readWeights(in);
    weights.solve(numberChildren, numberChildren);
    weights.printSolution(out);

    if (in.hasNext())
    {
    out.println();
    }
}
    out.close();
}


    
}
