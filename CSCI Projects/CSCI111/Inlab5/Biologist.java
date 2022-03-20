
/**
 * This class represents the biologist class.
 * 
 * @author Joshua Harthan
 * @version Oct 4 2016
 */
public class Biologist
{
    //identify animal method, determines what animal is being described
    public static void identifyAnimal(Animal a)
    {
        switch (a.getNumLegs())
        {
            case 0:     //animal has 0 legs
                System.out.println("No legs");
                switch (a.getEnvironment()) //look at the environment
                {
                    case "land":    //if land, then snake
                    System.out.println("Lives on land");
                    System.out.println("---> Sounds like a snake.");
                    break;
                    
                    case "air":     //if air, doesn't exist
                    System.out.println("Lives in the air");
                    System.out.println("---> I don't know, sounds fake.");
                    break;
                    
                    case "water":   //if water, then fish
                    System.out.println("Lives in the water");
                    System.out.println("---> It's probably a fish.");
                    break;
                }
                break;
                
            case 2:     //animal with two legs
                System.out.println("Two legs"); 
                switch (a.getEnvironment()) //look at the enivronment
                {
                    case "air":     //if air then bird
                    System.out.println("Lives in the air");
                    System.out.println("---> Easy one: Bird.");
                    break;
                    
                    case "land":    //if land look for nice or not
                    System.out.println("Lives on land");
                        if (a.getSeemsNice() == true)   //if nice then classmate
                        {
                            System.out.println("Seems nice");
                            System.out.println("---> Bro, that's your classmate.");
                        }
                        else if (a.getSeemsNice() == false) //if not nice then bigfoot
                        {
                            System.out.println("Doesn't seem nice");
                            System.out.println("---> Bigfoot. Take a picture.");
                        }
                        
                }
                break;
             
            case 4:     //animal with four legs
                System.out.println("Four legs");
                if (a.getSeemsNice() == true)   //if nice then dog
                {
                    System.out.println("Seems nice");
                    System.out.println("---> Probably a dog.");
                }    
                
                else if (a.getSeemsNice() == false) //if not nice then skunk
                {
                    System.out.println("Doesn't seem nice");
                    System.out.println("---> Skunk. Watch out!");
                }
                break;
                
            default:    //animal with legs that aren't 0, 2, or 4
                System.out.println("That's an odd number of legs. It's probably hurt or crawly.");
                break;    
        }
    }
    
    //determine whether the animal should be pet or not
    public static void petOrNot (Animal a)
    {
      if (a.getSeemsNice() == true && a.getNumLegs() == 4) //if the animal seems nice and has four legs
      {
          System.out.println("Sure, pet it");
          System.out.println();
      }
      
      else if (a.getSeemsNice() == false || a.getNumLegs() == 0) //if the animal doesnt seem nice or has 0 legs
      {
          System.out.println("Don't pet it");
          System.out.println();
      }
      
      else  //default pet method
      {
          System.out.println("Pet at your own risk");
          System.out.println();
      }   
    }
}
      
      
    

