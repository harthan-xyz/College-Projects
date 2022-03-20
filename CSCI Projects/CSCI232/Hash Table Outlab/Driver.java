/**
 * Joshua Harthan
 * Driver class for the hashtable outlab.
 * 10/8/18
 */

import java.util.Scanner;
import java.util.*;
import java.io.*;

public class Driver {
    public static void main(String[] args) throws FileNotFoundException {
        
    HashTable table = new HashTable();
    table.add(1234, "Hunter");
    table.add(456,  "Ramey");
    table.add(8943, "Laura");
    table.add(3546, "John");
    table.add(256,  "Adam");
    table.add(7543, "Aaron");
    table.add(9387854, "Kevin");
    table.add(3954, "Joshua");
    table.add(6439, "Dustin");
    table.add(32055, "Leo");
    table.add(3530, "Chris");
    table.add(539543, "Cory");
    table.add(5032, "Jeff");
    table.add(50334, "Jared");
    table.add(55943, "Will");
    table.add(53959, "David");
    table.add(35356, "Adam");
    table.add(35336, "Addiley");
    table.add(53536, "Homer");
    table.add(353945, "Bart");
    table.add(22011, "Marge");
    table.add(502385, "Lisa"); 
    table.add(36844, "Maggie");
    table.add(3958357, "Moe");
    table.add(22432, "Lenny");
    table.add(3053, "Officer Wiggum");
    table.add(1, "Lloyd");
    
    table.printTable();
    
    //scanner to read in user input
    Scanner input = new Scanner(System.in);
    Scanner inFile = new Scanner(new FileReader(input.nextLine()));
    System.out.println("Enter value to be searched in the hashtable >");    
    int keyEntered1 = inFile.nextInt();
    table.findValue(keyEntered1);
    
    System.out.println("Enter value to be added to the hashtable >");
    int keyEntered2 = inFile.nextInt();
    String valueEntered2 = inFile.next();
    table.add(keyEntered2, valueEntered2);
    
    System.out.println("Enter a value to be deleted in the hashtable >");
    int keyEntered3 = inFile.nextInt();
    String valueEntered3 = inFile.next();
    table.delete(keyEntered3, valueEntered3);

    table.printTable();
    }
    
}
