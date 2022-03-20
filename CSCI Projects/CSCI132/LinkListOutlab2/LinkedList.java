
/**
 * Joshua Harthan
 * LinkedList class for the linked list outlab.
 * 2/21/17
 */
public class LinkedList {

    //instance variables to create the linked list
    private Node first;
    private Node last;
    public int size;

    //empty constructor that sets the initial values of the variables
    public LinkedList() {
        first = null;
        last = null;
        size = 0;
    }

    //makeEmpty() method to make the linked list have no values
    public void makeEmpty() {
        first = null;
    }

    //addCandidate method to add values to the linked list
    public void addCandidate(int val) {
        Node nptr = new Node(val, null, null);
        if (first == null) {
            nptr.setNext(nptr);
            nptr.setPrev(nptr);
            first = nptr;
            last = first;
        } else {
            nptr.setPrev(last);
            last.setNext(nptr);
            first.setPrev(nptr);
            nptr.setNext(first);
            first = nptr;
        }
        size++;
    }

    //pointer method to get the value of the pointerM at a certain point
    public Node getPointerM(int userInput) {
        Node nptr = new Node(userInput, null, null);
        nptr.setPrev(last);
        last.setNext(nptr);
        first.setPrev(nptr);
        nptr.setNext(first);
        first = nptr;
        System.out.println(nptr.getMember());
        return first;
    }

    //pointer method to get the value of the pointerK at a certain point
    public Node getPointerK(int userInput) {
        Node nptr = new Node(userInput, null, null);
        nptr.setPrev(last);
        last.setNext(nptr);
        first.setPrev(nptr);
        nptr.setNext(first);
        last = nptr;
        System.out.print(nptr.getMember() + " \n");
        return last;
    }

    //delete method to delete the value at a given point
    public void deleteAtPointer(int position) {
        if (position == 1) {
            if (size == 1) {
                first = null;
                last = null;
                size = 0;
                return;
            }
            first = first.getNext();
            first.setPrev(last);
            last.setNext(first);
            size--;
            return;
        }
        if (position == size) {
            last = last.getPrev();
            last.setNext(first);
            first.setPrev(last);
            size--;
        }
        Node ptr = first.getNext();
        for (int i = 2; i <= size; i++) {
            if (i == position) {
                Node p = ptr.getPrev();
                Node n = ptr.getNext();
                p.setNext(n);
                n.setPrev(p);
                size--;
                return;
            }
            ptr = ptr.getNext();
        }
    }

    //displayCandidates method to display the linked list and the values within it
    public String displayCandidates() {
        Node ptr = first;
        System.out.println("The candidates are:");
        if (size == 0) {
            System.out.println("The list of candidates seems to be empty.");
            return ("Empty");
        }
        if (first.getNext() == first) {
            System.out.print(first.getMember() + " <-> " + ptr.getMember() + "\n");
            return (first.getMember() + " <-> " + ptr.getMember() + "\n");
        }
        System.out.print(first.getMember() + " <-> ");
        ptr = first.getNext();
        while (ptr.getNext() != first) {
            System.out.print(ptr.getMember() + " <-> ");
            ptr = ptr.getNext();
        }
        System.out.print(ptr.getMember() + " <-> ");
        ptr = ptr.getNext();
        return (ptr.getMember() + " <-> ");
    }
}
