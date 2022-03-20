
/**
 * Write a description of class Driver here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Driver
{
    public static void main (String[] args)
    {
        Loop loop = new Loop();
        
        loop.loop1(1,10,1);
        loop.loop2(1,10,1);
        loop.loop1(2,9,3);
        loop.loop2(2,9,3);
        loop.loop3();
        loop.loop4(4);
        loop.loop5(4);
    }
}
