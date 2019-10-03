#Joshua Harthan
#CSCI 132, Outlab 5
#4/18/17

from tkinter import *

#set the dimensions of the window
canvas_width = 400
canvas_height = 400

#create an instance of tkinter, set root variable equal to it
root = Tk()
root.title("Dice Roller")#name the program 'dice roller'

#create an instance of a canvas, set w variable equal to it
w = Canvas(root, width=canvas_width, height=canvas_height, bg ="#00ff00")
w.pack()

#create the head of the face
w.create_oval(100,100,300,300, fill ="#00ff00")
#create the eyes of the face 
w.create_oval(140,140,180,180,fill ="#00ff00")
w.create_oval(220,140,260,180,fill ="#00ff00")
#create the mouth of the face
w.create_line(260,240,140,240, fill='black', width=1)

#quit button that exits the program when pressed
quitbutton = Button(root, text='Quit', command=quit)
quitbutton_window = w.create_window(200, 50, anchor=N, window=quitbutton)
        
#eyes button that moves the eyes of the face
def move_eyes():
    #create new circles to simulate the movement of the eyes
    w.create_oval(140,140,180,180,fill ="#00ff00",outline="#00ff00")
    w.create_oval(220,140,260,180,fill ="#00ff00",outline="#00ff00")
    w.create_oval(140,190,180,230,fill ="#00ff00")
    w.create_oval(220,190,260,230,fill ="#00ff00")
    #configure button press to move_eyes_back after subsequent press
    eyesbutton.configure(command=move_eyes_back)
def move_eyes_back():
    #create new circles to move eyes back to original position
    w.create_oval(140,140,180,180,fill ="#00ff00")
    w.create_oval(220,140,260,180,fill ="#00ff00")
    w.create_oval(140,190,180,230,fill ="#00ff00",outline="#00ff00")
    w.create_oval(220,190,260,230,fill ="#00ff00",outline="#00ff00")
    #configure button press to move_eyes after subsequent press
    eyesbutton.configure(command=move_eyes)
eyesbutton = Button(root, text='Eyes', command=move_eyes)
eyesbutton_window = w.create_window(120, 350, anchor=SW, window=eyesbutton)

            
#talk button that moves the mouth of the face
def talk():
    #create a polygon to simulate an open mouth
    points = [260,240,140,240,180,260,220,260]
    w.create_polygon(points,fill="#00ff00",outline='black',width=1)
    #configure button press to close_mouth after subsequent press
    talkbutton.configure(command=close_mouth)
def close_mouth():
    #fill the polygon with green(delete the polygon) and draw straight line
    points = [260,240,140,240,180,260,220,260]
    w.create_polygon(points,fill="#00ff00",outline="#00ff00",width=1)
    w.create_line(260,240,140,240, fill='black', width=1)
    #configure button press to talk after subsequent press
    talkbutton.configure(command=talk)
talkbutton = Button(root, text='Talk', command=talk)
talkbutton_window = w.create_window(280, 350, anchor=SE, window=talkbutton)

root.mainloop() #keep the program running until the GUI is closed
