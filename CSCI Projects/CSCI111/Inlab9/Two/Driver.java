public class Driver
{
    public static void main(String[] args)
    {
        Restaurant r1 = new Restaurant("r1", 4);
        Restaurant veracruz = new Restaurant("Veracruz");
        
        r1 = veracruz.method(r1, veracruz);
        
        System.out.println(r1.getName());
        System.out.println(veracruz.getName());
        System.out.println(r1.count);
        System.out.println(Restaurant.count);
    }
}
