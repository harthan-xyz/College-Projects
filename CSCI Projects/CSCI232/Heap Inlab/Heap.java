package inlab3;

/**
 *
 * @author Joshua Harthan
 * Heap class to add integers into a heap, with minimum numbers having highest priority.
 */
public class Heap {
    //create an integer array to hold the values to be stored in the heap
    private int[] heap;
    
    //initialize the heap to be of length 25 in the constructor
    public Heap()
    {
        heap = new int[25];
    }
    
    //add method to add the integers to the tree in the appropriate spot of the heap, and rotating when appropriate
    public void add(int data) {
        //iterate through the array, adding in the data input into the an open spot
        for(int i = 1; i < heap.length; i++){    
            if(heap[i] == 0){
                heap[i] = data;
                //if the data at half the array is greater than that at the iterator of the array
                if(heap[i/2] > heap[i]){
                    //create a temporary variable to allow for rotation, in which it temporarily stores a variable, and swaps the value
                    int temp = heap[i];
                    heap[i] = heap[i/2];
                    heap[i/2] = temp;
                    //repeat this process twice, to check each branch
                    if(heap[i/4] > heap[i/2]){
                        temp = heap[i/2];
                        heap[i/2] = heap[i/4];
                        heap[i/4] = temp;
                        if(heap[i/8] > heap[i/4]){
                            temp = heap[i/4];
                            heap[i/4] = heap[i/8];
                            heap[i/8] = temp;
                        }
                    }
                }
                return;
            }
        }
    }
    
    //remove mehtod to remove the root of the heap, and to rotate the minimum number to the root
    public void remove() {
        //local vairables to initialize the values within the heap 
        heap[1] = 0;
        int a = 0; //variable to store the value of the array that is being iterated through
        int b = 0; //variable to represent the pointer of the array
        
        //iterate through the array to set the varaibles a and b to check the heap 
        for(int i = 1;i < heap.length; i++){
            if(heap[i] != 0){
                a = heap[i];
                b = i;
            }
        }
        heap[1] = a; //set the value of the next branch to the value iterated to
        heap[b] = 0; //set the root to 0
        int index = 1; //set the parent index to 1
        //while loop to continue looping while the children are greater than the root
        while(heap[2 * index] < heap[index] || heap[2 * index + 1] < heap[index]){
            //if the right child is less than the left child
            if(heap[2 * index] < heap[2 * index + 1]){
                //create a temporary integer to store the value of the right child, and swap to the root
                int temp = heap[2*index];
                heap[2*index] = heap[index];
                heap[index] = temp;
                index = 2*index; //reset the index value
                //if the right child or left child have no values, break the loop 
                if(heap[2 * index] == 0 || heap[2 * index + 1] == 0)
                    return;
            }
            //if the right child is greater than the left child
            else if(heap[2 * index] > heap[2* index + 1]){
                 //create a temporary integer to store the value of the left child, and swap to the root
                int temp = heap[2*index + 1];
                heap[2*index + 1] = heap[index];
                heap[index] = temp;
                index = 2*index + 1; //reset the index value
                //if both the right child and left child have no values, break the loop
                if(heap[2 * index] == 0 || heap[2 * index + 1] == 0)
                    return;
            }
        }
    }
    
    //print method to print each level of the heap 
    public void print() {
        for(int i = 1; i < heap.length; i++)
        {
            //print each value while the value at the heap is nonzero
            if(heap[i] != 0)
            {
                System.out.print(heap[i] + " ");
            }
        }
        System.out.println(); //line break
    }
}
