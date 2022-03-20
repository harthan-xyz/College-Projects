/**
 *
 * @author Joshua Harthan
 * Node class to iterate throughout the tree
 */

public class Node<E>
{
    //instance variables to represent the root, and it's left and right children
    private E data;
    private Node<E> left;
    private Node<E> right;
    
    //node constructor to set that values of the root and it's children
    public Node (E data)
    {
        this.data = data;
        this.right = null;
        this.left = null;
    }
    
    //setLeft method to set the value of the left child
    public Node setLeft(Node<E> whatever)
    {
        this.left = whatever;
        return whatever;
    }
    
    //setRight method to set the value of the right child
    public Node setRight(Node<E> whatever)
    {
        this.right = whatever;
        return whatever;
    }
    
    //getData method to get the value of the root
    public E getData()
    {
        return data;
    }
    
    //getRight method to get the value of the right child
    public Node<E> getRight()
    {
        return right;
    }
    
    //getLeft method to get the value of the left child
    public Node<E> getLeft()
    {
        return left;
    }
    
  

}
