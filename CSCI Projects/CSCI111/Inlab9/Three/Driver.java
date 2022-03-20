public class Driver
{
    public static void main(String [] args)
    {
        Car c1 = new Car("KIA");
        Garage g1 = new Garage(new Car("Chevy"));
        Car explorer = new Car();

        System.out.println(c1.getMake());       	
        System.out.println(g1.getMake());      
        System.out.println(explorer.getMake());	

        g1.setCar(c1.testMethod(g1, new Garage(new Car("Subaru")), explorer));

        System.out.println(c1.getMake());	
        System.out.println(g1.getMake());	
        System.out.println(explorer.getMake());	

    }
}
