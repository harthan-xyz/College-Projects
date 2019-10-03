
/**
 * This a class to represent a team
 * 
 * @author Joshua Harthan 
 * @version 27 Sept 2016
 */
public class Team
{
    //instance variables
    private String name;            //variable to represent team name
    private int teamAtBats;         //variable to represent team at bats
    private int teamHits;           //variable to represent team hits
    private double teamBattingAvg;  //variable to represent team batting average
    private Player p1;              //variable to represent player1
    private Player p2;              //variable to represent player2
    private Player p3;              //variable to represent player3
    
    //constructors
    public Team (String inName, Player inP2, Player inP1, Player inP3)
    {
        name = inName;
        p2 = inP2;
        p1 = inP1;
        p3 = inP3;
    }
    
    //methods
    public int getTeamAtBats()         //get team at bat method
    {
        teamAtBats = p1.getAtBats() + p2.getAtBats() + p3.getAtBats();
        return teamAtBats;
    }
    
    public int getTeamHits()           //get team hits method
    {
        teamHits = p1.getHits() + p2.getHits() + p3.getHits();
        return teamHits;
    }
    
    public double getTeamAvg()          //get team batting averagae method
    {
        teamBattingAvg = ((double)getTeamHits() / getTeamAtBats());
        return teamBattingAvg;
    }
    
    //print method to print out the team's stats
    public void printStats()
    {
        System.out.println(name + ":");
        System.out.println("  At Bats: " + getTeamAtBats());
        System.out.println("  Hits: " + getTeamHits());
        System.out.println("  Batting Avg: " + getTeamAvg());
        System.out.println("  Players:");
        System.out.println("    " + p2.getName() + "--->" + " At Bats: " + p2.getAtBats() + ", " + " Hits: " + p2.getHits() + ", " + "Batting Avg: " + p2.addBattingAvg());
        System.out.println("    " + p1.getName() + "--->" + " At Bats: " + p1.getAtBats() + ", " + " Hits: " + p1.getHits() + ", " + "Batting Avg: " + p1.addBattingAvg());
        System.out.println("    " + p3.getName() + "--->" + " At Bats: " + p3.getAtBats() + ", " + " Hits: " + p3.getHits() + ", " + "Batting Avg: " + p3.addBattingAvg());
    }
}
