##############
## Script listens to the serial port which is connected to Arduino and
## writes the input into a text file named 'output.txt'. The text saved into the file are
## sku numbers which help identify which products the customer has in their cart.
##############
## requires pySerial to be installed
import serial

#Need to change serial_port according to how the board is set up in your computer
#check tool>>port in arduino ide
serial_port = 'COM4'
i=0
baud_rate = 115200
path = "output.txt" #output file name
ser = serial.Serial(serial_port, baud_rate)
with open(path, 'w+') as f:
    while (i<1):
        line = ser.readline()
        print(line)
        f.writelines(line)
        i =+ 1
