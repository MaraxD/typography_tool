// typography tool //<>// //<>// //<>// //<>// //<>//
import controlP5.*;
import java.util.List;

ControlP5 cp5;
ControlP5 guiControllers;

int y=20;
int spacing=60;
PFont font, textFont;
String inputWord="", selectedFont="Serif";
int fontListSize, i=0;
String[] fontList;
DropdownList dropDownElement;
Button colorButton;
boolean isDLOpen=true, btnClicked=false;
ArrayList<Object> letterCoordinatesDict;
boolean fontChanged=false, fontSizeChanged=false;
Slider fontSizeSlider;
float selectedFontSize=30;

void setup() {
  size(600, 600);
  background(color(255, 240, 209));
  letterCoordinatesDict= new ArrayList<Object>();
  gui();
}

void draw() {
  float mouseXCoords, mouseYCoords;
  if (!inputWord.equals("")) {
    // going to the editor page

    stroke(color(121, 87, 87));
    //upper line
    line(0, 50, width, 50);

    //bottom line
    line(0, height-50, width, height-50);

    // draw in the selected size
    if (selectedFontSize != 30 && fontSizeChanged) {
      for (int i=0; i<letterCoordinatesDict.size(); i+=3) {
        text((char)letterCoordinatesDict.get(i), (float)letterCoordinatesDict.get(i+1), (float)letterCoordinatesDict.get(i+2));
      }
    }

    // draw in the selected font
    if (!selectedFont.equals("Serif")) {
      if (letterCoordinatesDict.size() !=0 && fontChanged) {
        // draw the letters gain but with the new font (clear up the previous drawn letter)
        // TODO buggy -> it puts the previously selected font
        textFont=createFont(selectedFont, selectedFontSize);
        for (int i=0; i<letterCoordinatesDict.size(); i+=3) {
          text((char)letterCoordinatesDict.get(i), (float)letterCoordinatesDict.get(i+1), (float)letterCoordinatesDict.get(i+2));
        }
        fontChanged=false;
      }
    } else {
      textFont=createFont(selectedFont, selectedFontSize);
    }


    textFont(textFont, selectedFontSize);


    // time to draw when the mouse is pressed
    // all the first presses of the button should write out the word
    if (mousePressed) {
      if (mouseY>70 && mouseY<height-50) {
        delay(80);
        mouseXCoords=mouseX;
        mouseYCoords=mouseY;
        letterCoordinatesDict.add(inputWord.charAt(i));
        letterCoordinatesDict.add(mouseXCoords);
        letterCoordinatesDict.add(mouseYCoords);
        text(inputWord.charAt(i), mouseXCoords, mouseYCoords);
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


void controlEvent(ControlEvent theEvent) {
  // getting the input from the text box
  if (theEvent.isAssignableFrom(Textfield.class)) {
    inputWord = theEvent.getStringValue();
    background(color(255, 240, 209));
    cp5.hide();
    guiControllers.show();
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {
    if (theEvent.isFrom(dropDownElement)) {
      //if a font from the drop down list was selected
      selectedFont=fontList[(int)theEvent.getController().getValue()];
      background(color(255, 240, 209));
      fontChanged=true;
    } else if (theEvent.isFrom(fontSizeSlider)) {
      selectedFontSize=theEvent.getController().getValue();
      fontSizeChanged=true;
    }
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}
