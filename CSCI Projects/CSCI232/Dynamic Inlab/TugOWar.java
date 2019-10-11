import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;

public class TugOWar {

    public static void main(String[] args) throws FileNotFoundException {
        int numberChildren;
        int weightMax;
        ComputeTeams ct;
        Scanner in = new Scanner (new File ("fin.txt"));
        numberChildren = in.nextInt();
        weightMax = in.nextInt();
        ct = new ComputeTeams(numberChildren, weightMax);
        int w[] = ct.readWeights(in); 
        int num = ct.findMin(w, numberChildren);
        System.out.println(num);  
    }
    
}
