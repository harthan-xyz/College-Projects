public class Restaurant
{
    private String name;
    private int employees;
    public static int count = 0;

    public Restaurant()
    {
        name = "Rosa's";
        employees = 15;
        count++;
    }
    
    public Restaurant(String name)
    {
        this.name = name;
        employees = 1;
        count++;
    }
    
    public Restaurant(String name, int num)
    {
        this.name = name;
        employees = num;
    }
    
    public String getName()
    {
        return name;
    }
    
    public int getEmployees()
    {
        return employees;
    }
    
    public void setName(String inName)
    {
        name = inName;
    }
    
    public Restaurant method(Restaurant first, Restaurant second)
    {
        Restaurant third = new Restaurant(first.getName());
        Restaurant fourth = second;
        
        System.out.println(first.getName());
        System.out.println(second.getName());
        System.out.println(third.getName());
        System.out.println(fourth.getName());
        
        second.setName("La Parrilla");
        fourth = first;
        third = this;
        this.setName(second.getName());
        
        System.out.println(first.getName());
        System.out.println(second.getName());
        System.out.println(third.getName());
        System.out.println(fourth.getName());
        
        return second;
    }
}
