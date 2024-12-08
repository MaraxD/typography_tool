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
    .setColorBackground(color(121, 87, 87))
    .setColorForeground(color(59, 48, 48))
    .setColorActive(color(59, 48, 48));


  dropDownElement=guiControllers.addDropdownList("Font");
  customize(dropDownElement);
  for (int i=0; i<fontListSize; i++) {
    dropDownElement.addItem(fontList[i], i);
  }

  // TODO when it s active, the cursor should change shape
  //dropDownElement.setColorActive(color(255, 128));

  // adding a slider to control th size of the drawn text
  fontSizeSlider=guiControllers.addSlider("fontSlider")
    .setPosition(width-240, height-40)
    .setSize(220, 30)
    .setRange(0, 255)
    .setValue(180)
    .setColorBackground(color(121, 87, 87))
    .setColorForeground(color(102, 67, 67))
    .setColorActive(color(59, 48, 48));
  ;
  //TODO fix here
  guiControllers.getController("fontSlider").getCaptionLabel().align(ControlP5.LEFT, ControlP5.LEFT_OUTSIDE).setPaddingX(0);
  

  guiControllers.hide();
}

void customize(DropdownList ddl) {
  ddl.setPosition(width-240, 10);
  ddl.setColorBackground(color(121, 87, 87));
  ddl.setItemHeight(25);
  ddl.setBarHeight(30);
  ddl.setColorForeground(color(59, 48, 48));
  ddl.setColorActive(color(59, 48, 48));
}
