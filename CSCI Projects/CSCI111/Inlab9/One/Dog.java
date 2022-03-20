
public class Dog
{
    public static int num = 0;
    private String breed;

    public Dog()
    {
        breed = "Mutt";
        num+=2;
    }

    public Dog(String inBreed)
    {
        breed = inBreed;    
        num = 3;
    }

    public Dog(String inBreed, int a)
    {
        breed = inBreed;    
        num = num + a;
    }

    public String getBreed()
    {
        return breed;
    }

    public void setBreed(String input)
    {
        breed = input;
    }

    public Dog methodB(Dog a, Dog b, Dog c)
    {
        a.setBreed("Corgi");
        b.setBreed(c.getBreed());
        c = this;
        System.out.println(a.getBreed());  	
        System.out.println(b.getBreed()); 	
        System.out.println(c.getBreed()); 
        return b;
    }
}
