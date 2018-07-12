/**
 * "MONITOHR" HEALTH APPLICATION
 * @version 1.0
 */

// IMPORTS //
import controlP5.*;
import processing.serial.*;

// GLOBAL VARIABLES // 
Constants constant;
Serial port;

// GUI //
ControlP5 gui;
Button testBtn;

// ARDUINO RELATED //
byte[] inBuffer = new byte[255]; //size of the serial buffer to allow for end of data characters and all chars 
int valP_oxygen; // Data received from the serial port - variable to store the oxygen sensor reading
int valP_heartRate; // Data received from the serial port - variable to store the heart rate sensor reading
int valP_temp; // Data received from the serial port - variable to store the temperature sensor reading




// SETUP METHOD // 
void setup() {
  // Initializations // 
  constant = new Constants();
  gui = new ControlP5(this);
  //port = new Serial(this, "COM11", 9600); // TODO: uncomment this to link Serial port to Processing
  initUI();

  // Window Properties // 
  surface.setTitle("moniTOHR | Health Kit");
  surface.setIcon(constant.icon);
  smooth();
  size(1066, 800);
  frameRate(60); // encourages frame rate to be 60FPS
}


// DRAW METHOD // 
void draw() {
  background(constant.customWhite);
  // sensorInformation() // TODO: uncomment this code to view sensor information in window
}


void sensorInformation() {
    if (0 < port.available()) { // if data is available to read
    println(" ");
    port.readBytesUntil('&', inBuffer);

    if (inBuffer != null) {
      String myString = new String(inBuffer);
      // println(myString); // for testing

      // p is all sensor data (with a's and b's) ('&' is eliminated)

      String[] p = splitTokens(myString, "&");  
      //if (p.length < 2) return; // exit this function if packet is broken
      //println(p[0]);   //for testing only


      /////////////////// OXYGEN SENSOR READING /////////////////////////////
      String[] oxygen_sensor = splitTokens(p[0], "a");  //get light sensor reading 
      //if (oxygen_sensor.length != 3) return;  //exit this function if packet is broken
      //println(oxygen_sensor[1]);


      // valP_oxygen = (oxygen_sensor[1]);
      valP_oxygen = int(oxygen_sensor[1]);

      print("oxygen sensor:");
      print(valP_oxygen);
      println(" ");  




      /////////////////// HEART RATE SENSOR READING //////////////////////
      String[] heartRate_sensor = splitTokens(p[0], "b");  //get heart rate sensor reading 
      //if (heartRate_sensor.length != 3) return;  //exit this function if packet is broken
      //println(heartRate_sensor[1]);
      valP_heartRate = int(heartRate_sensor[1]);

      print("heart rate sensor:");
      print(valP_heartRate);
      println(" "); 





      /////////////////// TEMPERATURE SENSOR READING ////////////////////////////
      
      
      /*
      * Insert code for reading the temperature sensor here.
      *
      */
      
      
      
      
      // Old code for drawing sensor information based on arduino
      // TODO update to link code with proper designs
      background(245); // Clear background
      fill(0);
      stroke(0);

      textFont(constant.labelFont); 
      text("heart rate sensor::  ", 40, 40);
      text(valP_heartRate, 180, 40);

      textFont(constant.labelFont); 
      text("oxygen sensor: ", 210, 170);
      text(valP_oxygen, 340, 170);

      fill(valP_heartRate); // Set fill color with the value read


      fill(valP_oxygen);
      ellipse(290, 290, 200, 200);
      if (valP_heartRate == 1) {
        rect(35, 60, 150, 150); // Draw square
      }
    }
  }

  
  
  
}