public class Driver
{
    public static void main(String [] args)
    {
        Dog watson = new Dog("Basset Hound", 6);
        Dog frieda = new Dog("Dachshund");
        Dog humperdink = watson;

        watson = watson.methodB(humperdink, frieda, new Dog("Lab", 2));

        System.out.println(watson.getBreed()); 		
        System.out.println(frieda.getBreed()); 	
        System.out.println(humperdink.getBreed()); 		
        System.out.println(humperdink.num); 			
    }
}
