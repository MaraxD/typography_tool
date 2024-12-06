// typography tool
import controlP5.*;

ControlP5 cp5;

String[] textfieldNames = {"tf1", "tf2", "tf3", "tf4", "tf5"};
int y=20;
int spacing=60;
PFont font, textFont;
String inputWord="";
int fontListSize;
String[] fontList;
DropdownList dropDownElement;
boolean isDLOpen=false;


void setup() {
  size(600, 600);
  background(color(255, 240, 209));
  // create a font for the main text
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

  dropDownElement=cp5.addDropdownList("font-list")
    .setPosition(width-240, 10)
    .setSize(100, 30)
    .setColorBackground(color(121, 87, 87));
  dropDownElement.setItemHeight(20);
  dropDownElement.setBarHeight(15);
  dropDownElement.getCaptionLabel().set("Font");
  //dropDownElement.getCaptionLabel().style().marginTop = 3;
  //dropDownElement.getCaptionLabel().style().marginLeft = 3;
  //dropDownElement.getValueLabel().style().marginTop = 3;
  for (int i=0; i<fontListSize; i++) {
    dropDownElement.addItem(fontList[i], fontList[i]);
  }
  //ddl.scroll(0);
  dropDownElement.setColorBackground(color(60));
  dropDownElement.setColorActive(color(255, 128));

  textFont(font);
}

void draw() {
  if (!inputWord.equals("")) {
    noLoop();
    // going to the editor page
    background(color(255, 240, 209));
    cp5.addButton("Color")
      .setPosition(width-120, 10)
      .setSize(100, 30)
      .setColorBackground(color(121, 87, 87));
  } else {
    // animate the intro text
    fill(color(255, 240, 209));
    stroke(color(255, 240, 209));
    rect(width/2-130, height/2-160, width+200, 60 );
    delay(200);


    pushMatrix();
    textFont=createFont(fontList[(int)random(0, fontListSize)], 30);
    textFont(textFont, 30);
    fill(0);
    text("enter your text here", width/2-130, height/2-130);
    popMatrix();
  }
}

void mousePressed() {
  if (!isDLOpen) {
    // set the height of a pulldown menu, should always be a multiple of itemHeight
    dropDownElement.setHeight(210);
    isDLOpen=true;
  } else {
    dropDownElement.setHeight(0); //close the dropdown list
    isDLOpen=false;
  }
}

void controlEvent(ControlEvent theEvent) {
  // getting the input from the text box
  if (theEvent.isAssignableFrom(Textfield.class)) {
    inputWord = theEvent.getStringValue();
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}
