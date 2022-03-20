
/**
 * Write a description of class Driver here.
 * 
 * @author yaw
 * @version 23 Sep 2016
 */
public class Driver
{
    public static void main(String[] args)
    {        
        //create instance of Player class and set the number of at bats and hits
        Player p1 = new Player("Joe");
        p1.addAtBats(243);
        p1.addHits(72);
        
        //create instance of Player class and set the number of at bats and hits
        Player p2 = new Player("Sally");
        p2.addAtBats(112);
        p2.addHits(23);
        
        //create instance of Player class and set the number of at bats and hits
        Player p3 = new Player("Frank");
        p3.addAtBats(204);
        p3.addHits(65);
        
        //create instance of Team class and assign Players
        Team t1 = new Team("Pirates", p2, p1, p3);

        //print out statistics for the team
        t1.printStats();
    }
}
