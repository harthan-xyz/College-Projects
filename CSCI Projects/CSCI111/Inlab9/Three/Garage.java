public class Garage
{
    private Car vehicle;

    public Garage(Car t)
    {
        vehicle = t;	
    }

    public Car getCar()
    {
        return vehicle;
    }

    public String getMake()
    {
        return vehicle.getMake();    
    }

    public void setCar(Car x)
    {   
        vehicle = x; 
    }

    public void changeMake(String x)
    { 
        vehicle.changeMake(x); 
    }
}