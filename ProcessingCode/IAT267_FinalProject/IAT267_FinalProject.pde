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
Button btnInfo;
PImage dashLogo;
PImage heartLogo;
PImage chartLogo;
PImage spectrum;
PImage radial;

// ARDUINO RELATED //
byte[] inBuffer = new byte[255]; //size of the serial buffer to allow for end of data characters and all chars 
int valP_oxygen; // Data received from the serial port - variable to store the oxygen sensor reading
int valP_heartRate; // Data received from the serial port - variable to store the heart rate sensor reading
int valP_temp; // Data received from the serial port - variable to store the temperature sensor reading

// STRINGS //
String heartRateTitle = "HEART RATE";
String heartRateUnits = "bpm";


String bodyTempTitle = "BODY TEMPERATURE";
String bodyTempUnits = "°C";

String oxygenTitle = "SpO2 LEVELS";
String oxygenUnits = "%";




// SETUP METHOD // 
void setup() {
  // Initializations // 
  constant = new Constants();
  gui = new ControlP5(this);
  //port = new Serial(this, "COM11", 9600); // TODO: uncomment this to link Serial port to Processing
  dashLogo = loadImage("dashboardSidebar.jpg");
  heartLogo = loadImage("heartLogo.png");
  chartLogo = loadImage("logoChart.png");
  spectrum = loadImage("spectrum.jpg");
  radial = loadImage("radial.jpg");
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
  background(255);
  //surface.setTitle("X: " + mouseX + "  Y: " + mouseY); // TODO: uncomment to view mouse location real-time

  // sensorInformation() // TODO: uncomment this code to view sensor information in window

  // ONLY TEMPORARY! FOR SEEING HOW IT WILL LOOK //
  valP_oxygen = 96;
  valP_heartRate = 85;
  valP_temp = 37;
  dashboardLayout();
}

void dashboardLayout() {
  // SIDE DASHBOARD LOGO //
  image(dashLogo, 0, 0);







  // RECTANGLES // 
  pushStyle();
  pushMatrix(); 
  noStroke();
  fill(constant.heartRateCol); 
  translate(259, 101);
  rect(0, 0, 807, 293);
  translate(0, 293);
  fill(constant.bodyTempCol);
  rect(0, 0, 405, 410);
  translate(405, 0);
  fill(constant.oxygenCol);
  rect(0, 0, 405, 410);
  popMatrix();
  popStyle();

  // HEART RATE CONTENT //

  pushMatrix();
  pushStyle();
  fill(255);
  textSize(36);
  translate(630, 290);
  text(heartRateUnits, 0, 0);
  translate(-70, 80);
  text(heartRateTitle, 0, 0);
  translate(-252, -223);
  image(chartLogo, 166, 48);
  image(heartLogo, 0, 0);

  pushStyle();
  translate(294, 83);
  textFont(constant.numFont);
  textSize(120);
  text(valP_heartRate, 0, 0);
  popStyle();

  popStyle();
  popMatrix();

  // BODY TEMP CONTENT // 
  pushStyle();
  pushMatrix();
  translate(310, 468);
  textSize(30);
  fill(255);
  text(bodyTempTitle, 0, 0);
  translate(0, 209);
  image(spectrum, 0, 0);
  translate(237, -68);
  textSize(25);
  text(bodyTempUnits, 0, 0);

  pushStyle();
  translate(-148, 7);
  textFont(constant.numFont);
  textSize(120);
  text(valP_temp, 0, 0);
  popStyle();

  popMatrix();
  popStyle();

  // SPO2 CONTENT //
  pushStyle();
  pushMatrix();
  translate(771, 468);
  textSize(30);
  fill(255);
  text(oxygenTitle, 21, 0);
  translate(-103, 209);
  image(radial, 0, 0);
  translate(315, -68);
  textSize(25);
  text(oxygenUnits, -16, 0);

  pushStyle();
  translate(-177, 0);
  textFont(constant.numFont);
  textSize(120);
  text(valP_oxygen, 0, 0);
  popStyle();

  popMatrix();
  popStyle();
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