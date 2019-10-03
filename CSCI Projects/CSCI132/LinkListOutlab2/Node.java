
/**
 * Joshua Harthan
 * Node class for the linked list outlab.
 * 2/21/17
 */
public class Node {

    //instance variables to to create the nodes
    private int numMembers;
    private Node next;
    private Node previous;

    //constructor that takes in an int for a parameter, sets the initial value for the variables
    public Node(int inMember) {
        numMembers = inMember;
        next = null;
        previous = null;
    }

    //constructor that takes in an int, node, and node for a parameter, sets the initial value for the variables
    public Node(int inMembers, Node clockWise, Node counterClockwise) {
        numMembers = inMembers;
        next = clockWise;
        previous = counterClockwise;
    }

    //setNext method that takes a Node and sets it equal to a node input
    public void setNext(Node i) {
        next = i;
    }

    //setPrev method that takes a Node and sets it equal to a node input
    public void setPrev(Node i) {
        previous = i;
    }
    
    //returns the value of the node next
    public Node getNext() {
        return next;
    }

    //returns the value of the node previous
    public Node getPrev() {
        return previous;
    }

    //setMember method that takes in an int and sets numMembers equal to it
    public void setMember(int i) {
        numMembers = i;
    }
    
    //getMember method that returns the value of the number of members
    public int getMember() {
        return numMembers;
    }
}
