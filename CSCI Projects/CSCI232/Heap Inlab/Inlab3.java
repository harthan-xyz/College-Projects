package inlab3;

/**
 *
 * @author Joshua Harthan
 * Driver class to add, remove, and print the values in the heap
 */
public class InLab3 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Heap heap = new Heap();
        heap.add(12);
        heap.add(45);
        heap.add(21);
        heap.add(5);
        heap.add(21);
        heap.add(10);
        heap.add(3);
        heap.add(55);
        heap.add(15);
        heap.print();
        heap.remove();
        heap.remove();
        heap.print();
        heap.add(36);
        heap.add(6);
        heap.print();
        heap.remove();
        heap.remove();
        heap.remove();
        heap.print();
    }
    
}
