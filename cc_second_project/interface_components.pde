Slider fontSizeSlider; //<>//
DropdownList dropDownElement;
Button colorButton, clearButton, surprizeMeButton;
ControlP5 cp5, guiControllers, colorButtonOptions;
color[] listOfColors={color(142, 180, 134), color(83, 100, 147), color(201, 104, 104), color(205, 92, 80)};

void gui() {
  fontList=PFont.list();
  fontListSize=fontList.length;

  // create a font for the text box
  font=createFont("arial", 40);
  cp5=new ControlP5(this);

  // create the underline
  line(width/2-130, height/2-60, width/2+130, height/2-60);

  // create the text box
  cp5.addTextfield("")
    .setPosition(width/2-130, height/2-100)
    .setSize(260, 40)
    .setFont(font)
    .setColor(color(102, 67, 67))
    .setColorBackground(color(255, 240, 209))
    .setColorForeground(color(255, 240, 209))
    .setColorActive(color(255, 240, 209));
  ;
  ;

  // create the button for the colors
  guiControllers=new ControlP5(this);
  colorButton=guiControllers.addButton("Color")
    .setPosition(width-120, 10)
    .setSize(100, 30);
  customizeButton(colorButton);

  // create the erase button
  clearButton=guiControllers.addButton("Clear")
    .setPosition(width-(width-120+100), 10)
    .setSize(100, 30);
  customizeButton(clearButton);

  // create the buttons that will act as color options
  colorButtonOptions=new ControlP5(this);
  for (int i=0; i<listOfColors.length; i++) {
    // create the four buttons for the four colors
    colorButtonOptions.addButton("colorOptions"+i)
      .setPosition(width-120+(25*i), 50)
      .setSize(21, 25)
      .setValue(listOfColors[i])
      .setColorBackground(listOfColors[i])
      .setLabelVisible(false);
  }

  // button for generative functionality
  surprizeMeButton=guiControllers.addButton("I'm feeling lucky")
    .setPosition(width-(width-120+100), height-40)
    .setSize(100, 30);
  customizeButton(surprizeMeButton);

  // create font option list
  dropDownElement=guiControllers.addDropdownList("Font")
    .setPosition(width-240, 10)
    .setItemHeight(25)
    .setBarHeight(30);
  customizeDropdownList(dropDownElement);

  for (int i=0; i<fontListSize; i++) {
    dropDownElement.addItem(fontList[i], i);
  }

  // adding a slider to control the size of the drawn text
  fontSizeSlider=guiControllers.addSlider("fontSlider")
    .setPosition(width-240, height-40)
    .setSize(220, 30)
    .setRange(0, 255)
    .setValue(selectedFontSize)
  ;
  customizeSlider(fontSizeSlider);

  guiControllers.hide();
  colorButtonOptions.hide();
}
