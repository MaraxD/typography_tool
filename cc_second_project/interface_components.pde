 //<>//

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
    .setColorActive(color(255, 240, 209))
    ;

  guiControllers=new ControlP5(this);
  guiControllers.addButton("Color")
    .setPosition(width-120, 10)
    .setSize(100, 30)
    .setColorBackground(color(121, 87, 87));

  // add event listener to the button
  myListener = new MyControlListener();
  //guiControllers.getController("Color").addListener(myListener);

  dropDownElement=guiControllers.addDropdownList("Font")
    .setPosition(width-240, 10)
    .setColorBackground(color(121, 87, 87))
    .setItemHeight(25)
    .setBarHeight(30);
  for (int i=0; i<fontListSize; i++) {
    dropDownElement.addItem(fontList[i], i);
  }

  // TODO when it s active, the cursor should change shape
  //dropDownElement.setColorActive(color(255, 128));
  guiControllers.hide();
}
