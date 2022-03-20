public class Car
{	
    private String make;

    public Car(String n)
    {
        make = n;
    }

    public Car()
    {
        make = "Ford";
    }

    public String getMake()
    { 
        return make; 
    }

    public void changeMake(String x)
    {   
        make = x; 
    }

    public Car testMethod(Garage one, Garage two, Car three)
    {
        Car four = two.getCar();
        four.changeMake("Toyota");
        one.setCar(four);
        System.out.println(one.getMake());  	
        System.out.println(two.getMake());	
        System.out.println(four.getMake());	
        three.changeMake("Honda");
        one.setCar(three);
        two = one;
        System.out.println(one.getMake());	
        System.out.println(two.getMake());	
        System.out.println(four.getMake());	

        return two.getCar();
    }
}