public class Driver
{
    public static void main(String [] args)
    {
        Band frampton = new Band("Alive", 6000);
        RecordCompany warner = new RecordCompany(new Band("Devo", 1000));
        Band startUp = new Band(30);
        RecordCompany rca = new RecordCompany(warner.getBand());

        System.out.println(frampton.getAlbum());       	
        System.out.println(warner.getAlbum());      	
        System.out.println(startUp.getAlbum());	            
        
        rca = frampton.testQuestion(warner, new RecordCompany(new Band(9)), rca.getBand());

        System.out.println(frampton.getAlbum());		    
        System.out.println(warner.getAlbum());	 
        System.out.println(startUp.getAlbum());	   
        System.out.println(warner.getBand().count);   
    }
}