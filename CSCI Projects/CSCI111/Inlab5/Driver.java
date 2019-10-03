/**
 * Driver for the Biologist app.
 * 
 * @author yaw 
 * @version 30 Sep 2016
 */
public class Driver
{
    public static void main(String[] args)
    {
        //snake
        Animal a1 = new Animal(0, "land", true);
        Biologist.identifyAnimal(a1);
        Biologist.petOrNot(a1);
        
        //fake
        Animal a2 = new Animal(0, "air", true);
        Biologist.identifyAnimal(a2);
        Biologist.petOrNot(a2);
        
        //fish
        Animal a3 = new Animal(0, "water", true);
        Biologist.identifyAnimal(a3);
        Biologist.petOrNot(a3);
        
        //bird
        Animal a4 = new Animal(2, "air", true);
        Biologist.identifyAnimal(a4);
        Biologist.petOrNot(a4);
        
        //classmate
        Animal a5 = new Animal(2, "land", true);
        Biologist.identifyAnimal(a5);
        Biologist.petOrNot(a5);
        
        //bigfoot
        Animal a6 = new Animal(2, "land", false);
        Biologist.identifyAnimal(a6);
        Biologist.petOrNot(a6);
        
        //dog
        Animal a7 = new Animal(4, "land", true);
        Biologist.identifyAnimal(a7);
        Biologist.petOrNot(a7);
        
        //skunk
        Animal a8 = new Animal(4, "land", false);
        Biologist.identifyAnimal(a8);
        Biologist.petOrNot(a8);
        
        //other animal
        Animal a9 = new Animal(100, "land", true);
        Biologist.identifyAnimal (a9);
        Biologist.petOrNot(a9);
    }
}
