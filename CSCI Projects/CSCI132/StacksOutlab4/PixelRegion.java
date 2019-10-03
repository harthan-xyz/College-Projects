/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Owner
 */
public class PixelRegion {
    //instance variables to represent height and width, and count to represent pixels checked
    public int height; //y coodinate
    public int width; //x coordinate
    public int count = 0; //pixels checked
    
    public PixelRegion(int h, int w){
        //set values for height, width and start count at 0
        this.height = h;
        this.width = w;
        count = 0;
    }
    
    //update count method to increment count by one
    public void updateCount(){
        count++;
    }
    
    //get count method to return the value of count
    public int getCount(){
        return count;
    }
    
    //get height method to return the value of height
    public int getHeight(){
        return height;
    }
    
    //get width method to return the value of width
    public int getWidth(){
        return width;
    }
}
