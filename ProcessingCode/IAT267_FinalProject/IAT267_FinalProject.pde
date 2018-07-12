/**
 * @version 1.0
 */

// IMPORTS //
import controlP5.*;

// GLOBAL VARIABLES // 
Constants constant;

// GUI //
ControlP5 gui;
Button testBtn;

// SETUP METHOD // 
void setup() {
  constant = new Constants();
  gui = new ControlP5(this);

  smooth();
  size(720, 1280);
  frameRate(60); // encourages frame rate to be 60FPS
  initUI();
}


// DRAW METHOD // 
void draw() {
  background(constant.customWhite);
}