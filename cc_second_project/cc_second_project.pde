// typography tool //<>// //<>// //<>//
import controlP5.*;

ControlP5 cp5;
ControlP5 guiControllers;

int y=20;
int spacing=60;
PFont font, textFont;
String inputWord="", selectedFont;
int fontListSize, i=0;
String[] fontList;
DropdownList dropDownElement;
Button colorButton;
boolean isDLOpen=true, btnClicked=false;
MyControlListener myListener;
PGraphics result;

// creating a custom event listener by inhereting the ControlListener interface
class MyControlListener implements ControlListener {
  public void controlEvent(ControlEvent theEvent) {
    println("i got an event from color btn, " +
      theEvent.getController().getValue());
  }
}


void setup() {
  size(600, 600);
  background(color(255, 240, 209));
  gui();
}

void draw() {
  if (!inputWord.equals("")) {
    // going to the editor page
    //background(color(255, 240, 209));
    guiControllers.show();

    stroke(color(121, 87, 87));
    //upper line
    line(0, 50, width, 50);

    //bottom line
    line(0, height-50, width, height-50);

    // time to draw whne the mouse is pressed
    if (mousePressed) {
      if(mouseY>70 && mouseY<height-50){
        delay(80);
        text(inputWord.charAt(i), mouseX, mouseY);
        if (i == inputWord.length()-1) {
          i=0;
        } else {
          i++;
        }
      }
    }
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

void keyPressed(){
  if(keyCode == 10 && !inputWord.equals("")){
    background(color(255, 240, 209));
  }
}

// TODO refactor
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
    selectedFont=fontList[(int)theEvent.getController().getValue()];
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}
