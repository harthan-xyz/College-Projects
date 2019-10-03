public class Band
{
    private int albumSales;
    private String album;
    public static int count = 0;

    public Band(String nm, int a)
    {
        albumSales = a;
        album = nm;
    }

    public Band(int n)
    {
        albumSales = n;
        album = "Brainstorming";
        count++;
    }

    public String getAlbum()
    { 
        return album; 
    }

    public void changeAlbum(String x)
    {   
        album = x; 
    }

    public RecordCompany testQuestion(RecordCompany one, RecordCompany two, Band three)
    {
        Band four = one.getBand();
        four.changeAlbum("Motel");
        three = two.getBand();
        System.out.println(one.getAlbum());  	
        System.out.println(two.getAlbum());	
        System.out.println(three.getAlbum());         
        System.out.println(four.getAlbum());	
        two = one;
        four = this;
        System.out.println(one.getAlbum());	
        System.out.println(two.getAlbum());	
        System.out.println(three.getAlbum());      
        System.out.println(four.getAlbum());	
        four.changeAlbum("Devo");
        return two;
    }
}
