#include <stdio.h>
#include <unistd.h>

int main() {
  while(1==1){
    //Runs Python Script (SerialToText.py) to read data from arduino
    system("cd / && cd /home/pi/Desktop && python SerialToText.py");

    //Stores the value of the RFID output text file
    const char *pathName = "output.txt";
    //Runs while RFID output text file exists
    while(access( pathName, F_OK ) != -1){
        // Triggers the NFC to encode the data which the RFID reader has scanned
      system("cd / && cd /home/pi/libnfc/libnfc-1.7.0/examples && sudo ./nfc-emulate-forum-tag2");

      //Deletes the text file
      if (remove("output.txt") == 0)
      printf("Deleted successfully");
      else
      printf("Unable to delete the file");
      }
  }
    return 0;
}
