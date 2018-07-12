/**
* Collection of methods to control the GUI
*/

/**
* Controls the initial creation of a button
* @param key        reference key string for button
* @param label      label that appears on button
* @param x          x-coordinate of button
* @param y          y-coordinate of button
* @param bg         background color of button
* @param act        active color of button (while mouse-over)
* @param fg         foreground color of button
* @return           returns the styled button
*/
Button createButton(String key, String label, float x, float y, color bg, color act, color fg) {
  Button b = gui.addButton(key)
    .setLabel(label)
    .setSize(250, 100)
    .setPosition(x, y)
    .setColorBackground(bg)
    .setColorActive(act)
    .setColorForeground(fg)
    .setFont(constant.labelFont);
    styleButton(b);
    return b;
}

void styleButton(Button b) {
  System.out.println(b); 
}

/**
* Controls the initial creation of a button
* @param key        reference key string for slider
* @param label      label that appears on slider
* @param x          x-coordinate of slider
* @param y          y-coordinate of slider
* @param min        minimum range of the slider
* @param max        maximum range of the slider
* @param bg         background color of slider
* @param act        active color of slider (while mouse-over)
* @param fg         foreground color of slider
* @param initValue  initial values for the slider
* @return           returns a  slider value
*/
Slider createSlider(String key, String label, float x, float y, float min, float max, color bg, color act, color fg, float initValue) {
  Slider s = gui.addSlider(key).setPosition(x, y)
    .setRange(min, max)
    .setLabel(label)
    .setSize(200, 30)
    .setFont(constant.labelFont)
    .setColorBackground(bg)
    .setColorActive(act)
    .setColorForeground(fg)
    .setValue(initValue);
  styleCaptionLabel(s.getCaptionLabel());
  return s;
}

/**
* Controls the styling of the caption label
* @param l label value for slider
*/
void styleCaptionLabel(Label l) {
  l.setLineHeight(20)
    .setColor(0)
    .align(ControlP5.LEFT_OUTSIDE, CENTER);
  ;
}

void initUI() {
  // Button(String key, String label, float x, float y, color bg, color act, color fg)
  //testBtn = createButton("testBtn", "Test Button", width / 2, height / 2, constant.primaryCol, 
  //constant.accentCol, color(0, 255, 0));
}

void testBtn() {
  
}