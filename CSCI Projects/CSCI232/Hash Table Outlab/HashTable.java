/**
 * Joshua Harthan
 * Hashtable class for the outlab.
 * 10/8/18
 */

public class HashTable{
    
    //linked list class to implement linked list
    private class LinkedList
    {
        int key; //key variable to hold value of key
        String value; //value variable to hold value 
        LinkedList next; //next to act as a pointer to the next value of the linked list    
    }
    
    private LinkedList[] hashTable; //the linkedlist array to represent the hashtable 
    private int filled; //size variable to reperesent the size of the hashtable
    
    //constructor to initialize the values of the hashtable
    public HashTable()
    {
        hashTable = new LinkedList[5];//initial size of hashtable is length of 5
        filled = 0; //initial size is five
    }
    
    //compute index method to calculate the value of the hashtable
    public int computeIndex(int key)
    {
        return (key % hashTable.length); //mod the key entered with the length of the hashtable
    }
    
    //add function to add key and value to hashtable 
    public void add(int addKey, String addValue)
    {
        int index = computeIndex(addKey); //calculate the index
        LinkedList list = hashTable[index]; //create a linkedlist that has the value of the hashtable at given index
       
        //while loop to keep adding while the value is not null
        while (list != null)
        {
            if(list.equals(addKey))
            {
                //if the value is equivalent to a value already input dont add
                break;
            }
            //set the pointer of the list to the next value
            list = list.next;
        }
        //if the the list isn't null, add the value to the hashtable
        if (list != null)
        {
            list.value = addValue;
        }  
        //check to see if hashtable is 80% full, if so double it 
        else if (filled >= .8*hashTable.length)
        {   
            System.out.println("Doubling the size of the hash table.");
            doubleSize();
            System.out.println();
        }
        //set the new link list values to the table
        LinkedList temp = new LinkedList();
        temp.key = addKey;
        temp.value = addValue;
        temp.next = hashTable[index];
        filled++; //increment the amount filled by one
    }
    
    //delete method to delete certain key, value combinations 
    public void delete(int deleteKey, String deleteValue)
    {
        int index = computeIndex(deleteKey); //compute the index value
        
        //if the hashtable is empty, do nothing
        if(hashTable[index] == null)
        {
            return;
        }
        //if the wanted to be deleteted equals the value in the hashtable, delete
        else if (hashTable.equals(deleteKey))
        {
            hashTable[index] = hashTable[index].next;
            filled--; //subtract one from filled
            return;
        }
        //set the pointers of next and previous to keep track of values within the table
        LinkedList previous = hashTable[index];
        LinkedList pointer = previous.next;
        //if the current pointer isn't null and doesn't equal the key wanted to be deleted, keep searching
        while(pointer != null && !pointer.equals(deleteKey))
        {
            pointer = pointer.next;
            previous = pointer;
        }
        //if the pointer isn't null, delete the value at the pointer and subtract one from total
        if(pointer != null)
        {
            previous.next = pointer.next;
            filled--;
        }
        
    }
    
    //double size methiod to double the size of the hashtable if greater than 80%
    public void doubleSize()
    {
        //create a temporary linked list to later be equal to the actual hashtable
        LinkedList[] temp = new LinkedList[hashTable.length * 2];
        for (int i = 0; i < hashTable.length; i++)
        {
            LinkedList list = hashTable[i]; //set the value of the linked list to the value iterated through hash table
           
            while (list != null)
            {
                //set the value of the temp linked list to the value of the next pointer
                LinkedList next = list.next;
                //calculated the new index as the length of the hash table is now doubled
                int index = list.key % temp.length;
                //set the values of the hashtable to the ones that were of the linked list
                list.next = temp[index];
                temp[index] = list;
                list = next;
            }
        }
        hashTable = temp;//set the hashtable to the one calculated
    }   
    
    //find value to find a value of the hashtable given a key
    public void findValue(int key)
    {   
        //for loop to iterate through the hashtable to find if value is within
        for(int i = key % hashTable.length; i < hashTable.length; i++){
            if (hashTable[i] == null)
            {
                System.out.println("This key is not in the hashtable. Enter another key to be searched. >");
            }
            else if(hashTable[i].equals(key))
            {
                System.out.println("The associated value of the table with the key given is: " + hashTable[i] + ".");
            }
            else
            {
                findValue(i);    
            }
                
        }
    }
    
    //print table method to display the hashtable at a given time
    public void printTable()
    {
        System.out.println("The current table looks like: ");
        //for loop to iterate through the values of the hash table
        for (int i = 0; i < hashTable.length; i++)
        {
            System.out.println(i + " ");
            LinkedList list = hashTable[i]; 
            //while the list has values, print out said values
            while (list != null)
            {
                System.out.println(" " + list.key + " " + list.value);
                list = list.next; //set the next pointer to the next hash in the array
            }
        }
    }
    
    
    
}
