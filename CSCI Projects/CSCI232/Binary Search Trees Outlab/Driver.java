/**
 *
 * @author Joshua Harthan
 * Driver class to create new instances of coffee and run the methods to create a binary search tree
 */
public class Driver {

    public static void main(String[] args) {
        //create a new tree and replace the node with arbitrary values
        TreeManager<Coffee> tree = new TreeManager<Coffee>(new Coffee("???", "ZZZ", 0));
        Coffee coffee;
        Node<Coffee> node;
        
        //print the tree inOrder
        System.out.println("\nPrinting tree inorder:");
        
        //create new instances of coffee and put in the values into their correct positions for inOrder traversal
        coffee = new Coffee("Folgers", "Dark Roast", 2.50);
        //create a new instance of a node to be put into the binary search tree
        node = new Node<Coffee>(coffee);
        //run the inOrder method in the treeManager class, putting in the value for node into the correct postion
        tree.inOrder(node);
        
        coffee = new Coffee("Folgers", "Columbian", 3.00);
        node = new Node<Coffee>(coffee);
        tree.inOrder(node);
        
        coffee = new Coffee("Folgers", "Extra Dark", 3.00);
        node = new Node<Coffee>(coffee);
        tree.inOrder(node);
        
        coffee = new Coffee("Nestle", "Dark Roast", 3.00);
        node = new Node<Coffee>(coffee);
        tree.inOrder(node);
        
        coffee = new Coffee("Nestle", "Columbian", 3.00);
        node = new Node<Coffee>(coffee);
        tree.inOrder(node);
       
        //print the tree preOrder
        System.out.println("\nPrinting tree preorder:");
        
        //create new instances of coffee and put in the values into their correct positions for preOrder traversal
        coffee = new Coffee("Folgers", "Dark Roast", 2.50);
        //create a new instance of a node to be put into the binary search tree
        node = new Node<Coffee>(coffee);
        //run the preOrder method in the treeManager class, putting in the value for node into the correct postion
        tree.preOrder(node);
        
        coffee = new Coffee("Folgers", "Columbian", 3.00);
        node = new Node<Coffee>(coffee);
        tree.preOrder(node);
        
        coffee = new Coffee("Folgers", "Extra Dark", 3.00);
        node = new Node<Coffee>(coffee);
        tree.preOrder(node);
        
        coffee = new Coffee("Nestle", "Dark Roast", 3.00);
        node = new Node<Coffee>(coffee);
        tree.preOrder(node);
        
        coffee = new Coffee("Nestle", "Columbian", 3.00);
        node = new Node<Coffee>(coffee);
        tree.preOrder(node);
        
        //print the tree postOrder
        System.out.println("\nPrinting tree postorder:");
        
        //create new instances of coffee and put in the values into their correct positions for postOrder traversal
        coffee = new Coffee("Folgers", "Dark Roast", 2.50);
        //create a new instance of a node to be put into the binary search tree
        node = new Node<Coffee>(coffee);
        //run the postOrder method in the treeManager class, putting in the value for node into the correct postion
        tree.postOrder(node);
        
        coffee = new Coffee("Folgers", "Columbian", 3.00);
        node = new Node<Coffee>(coffee);
        tree.postOrder(node);
        
        coffee = new Coffee("Folgers", "Extra Dark", 3.00);
        node = new Node<Coffee>(coffee);
        tree.postOrder(node);
        
        coffee = new Coffee("Nestle", "Dark Roast", 3.00);
        node = new Node<Coffee>(coffee);
        tree.postOrder(node);
        
        coffee = new Coffee("Nestle", "Columbian", 3.00);
        node = new Node<Coffee>(coffee);
        tree.postOrder(node);
       
    }
    
}
