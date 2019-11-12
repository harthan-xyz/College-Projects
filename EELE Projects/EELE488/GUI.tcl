#include the Tk package to setup the GUI
package require Tk
#define the top level window
toplevel .test
#name the window
wm title .test "TCL GUI"
#count variable that increments based off number of buttons and frames in the window
set count 0
#set the master, open JTAG connection
set m [lindex [ get_service_paths master] 0]
open_service master $m
#varible to read from specified register locations
set A [master_read_32 $m 0x0 0x5]

#add frame process that creates a frame 
proc add_frame title {
global frame count
set frame .test.frame$count
frame $frame -border 2 -relief groove
label $frame.label -text $title
pack $frame -side left -padx 2 -pady 2 -anchor n -fill both
pack $frame.label -side top -padx 2 -pady 2
incr count
}

#add button button that creates a button 
proc add_button {title command} {
global frame count
button $frame.$count -text $title -command $command
pack $frame.$count -side top -pady 1 -padx 1 -fill x
incr count
}

#add frame and buttons to write address, syntax is : process "Name" {action}
add_frame "Write Address"
add_button "Write FF" {master_write_32 $m 0x0 0x0 0x1 0xFF}
add_button "Write EE" {master_write_32 $m 0x0 0x1 0x1 0xEE}
add_button "Write DD" {master_write_32 $m 0x0 0x2 0x1 0xDD}
add_button "Write CC" {master_write_32 $m 0x0 0x3 0x1 0xCC}
add_button "Write BB" {master_write_32 $m 0x0 0x4 0x1 0xBB}
add_button "Write AA" {master_write_32 $m 0x0 0x5 0x1 0xAA}
add_button "Write 99" {master_write_32 $m 0x0 0x6 0x1 0x99}
add_button "Write 88" {master_write_32 $m 0x0 0x7 0x1 0x88}
add_button "Write 77" {master_write_32 $m 0x0 0x8 0x1 0x77}
add_button "Write 66" {master_write_32 $m 0x0 0x9 0x1 0x66}
add_button "Write 55" {master_write_32 $m 0x0 0xA 0x1 0x55}
add_button "Write 44" {master_write_32 $m 0x0 0xB 0x1 0x44}
add_button "Write 33" {master_write_32 $m 0x0 0xC 0x1 0x33}
add_button "Write 22" {master_write_32 $m 0x0 0xD 0x1 0x22}
add_button "Write 11" {master_write_32 $m 0x0 0xE 0x1 0x11}
add_button "Write 00" {master_write_32 $m 0x0 0xF 0x1 0x00}

#add frame and button to read addresses 0x0 to 0x5
add_frame "Read Address"
add_button "Read" { puts \ ; puts $A}
