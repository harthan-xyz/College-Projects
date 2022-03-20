/**
 *
 * @author Joshua Harthan
 * TreeManager class to traverse and add/delete data of the tree.
 */
public class TreeManager <E extends Comparable>{
   
    //instance variable to create the root of the tree
    private Node<E> root;
    
    //treeManager constructor to set the data input as a dummy variable and it's children to null
    TreeManager(E data)
    {
        Node<E> dummy = new Node<E>(data);
        dummy.setLeft(null);
        dummy.setRight(null);
        root = dummy;
    }
    
    //add method to values into the tree
    public void add (Node<E> data)
    {
        //local variables to represent the parent and children of the tree
        Node<E> parent = root;
        Node<E> rightchild = root.getRight();
        Node<E> leftchild = root.getLeft();
        
        //if the parent is not null
        if (parent == null)
        {
            //set the data input as a root, and make it a parent
            root = data;
            parent = root;
        }
        //else if the data is less than that being compared to 
        else if(data.getData().compareTo(parent) == -1)
        {
            //add that value to the left and set as left child
            add(data.setLeft(leftchild));
        }
        //else if the data is greater than that being compared to
        else if(data.getData().compareTo(parent) == 1)
        {
            //add that value to the right and set as right child
            add(data.setRight(rightchild));
        }
        //else if the data is the same as that being compared to
        else if (data.getData().compareTo(parent) == 0)
        {
            //do nothing, dont add to tree
            return;
        }
        //do nothing if somehow none of these conditions are met
        else
        {
            return;
        }
    }
    
    
    //traverse tree left, visit root node, travaerse tree right
    public void inOrder (Node<E> data)
    {
        //local variables to represent parent and children
        Node<E> parent = root;
        Node<E> left = root.getLeft();
        Node<E> right = root.getRight();
        
        //if the tree returns a null value for the children
        if (data == null)
        {
            //break the loop
            return;
        }
        //recrusively call the method in order to find the conditions needed to be met
        else
        {
            inOrder(data.setLeft(left));
            System.out.println(data.getData() + " ");
            inOrder(data.setRight(right));
        }
        
    }
    
    //visit root node, traverse tree left, traverse tree right
    public void preOrder (Node<E> data)
    {
        
        Node<E> left = root.getLeft();
        Node<E> right = root.getRight();
        //if the tree returns a null value for the children
        if (data == null)
        {
            return; //break the loop
        }
        //recrusively call the method in order to find the conditions needed to be met
        else
        {
          System.out.println(data.getData() + " ");
          preOrder(data.setLeft(left));
          preOrder(data.setRight(right));
        }
        
    }
    
    //traverse tree left, traverse tree right, visit root node 
    public void postOrder (Node<E> data)
    {
        Node<E> parent = root;
        Node<E> left = root.getLeft();
        Node<E> right = root.getRight();
        //if the tree returns a null value for the children
        if (data == null)
        {
            return; //break the loop
        }
        //recrusively call the method in order to find the conditions needed to be met
        else
        {
            postOrder(root.setLeft(left));
            postOrder(root.setRight(right));
            System.out.println(data.getData() + " ");
        }
    }
    
    //delete method to delete certain value within the tree
    public Node delete (Node<E> data)
    {
        //local variables to represent the parent and it's children
        Node<E> parent = root;
        Node<E> left = root.getLeft();
        Node<E> right = root.getRight();
        
        //if the tree returns a null value for the children
        if(data == null)
        {
            return null; //return a value of null
        }
        //else if the data is less than that of it's parent
        else if(data.getData().compareTo(parent) == -1)
        {
            delete(data.setLeft(left)); //delete the data at that point
        }
        //else if the data is greater than that of it's parent
        else if(data.getData().compareTo(parent) == 1)
        {
            delete(data.setRight(right)); //delete the data at that point
        }
        else
        {
            return null;
        }
     return null;
    }
    
}
