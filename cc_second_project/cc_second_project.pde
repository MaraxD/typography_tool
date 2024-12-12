import controlP5.*; //<>//
import java.util.List;

int fontListSize, letterIterator=0, rgbValues;
PFont font, textFont;
String inputWord="", selectedFont="Serif";
String[] fontList;
boolean fontChanged=false, fontSizeChanged=false, colorChanged=false, isColorButtonPressed=true, isSurprizeMeButtonPressed=false;
ArrayList<Object> letterCoordinatesList; // [0] the letter, [1] x coord, [2] y coord ,...
float selectedFontSize=30, t=0, circleX, circleY, circleDiam, mouseXCoords, mouseYCoords;
color selectedColor=color(0), backgroundColor=color(255, 240, 209);

void setup() {
  size(600, 600);
  background(backgroundColor);
  letterCoordinatesList= new ArrayList<Object>();
  gui();
}

void draw() {
  if (!inputWord.equals("")) {
    // going to the editor page

    stroke(color(121, 87, 87));
    //upper line
    line(0, 50, width, 50);

    //bottom line
    line(0, height-50, width, height-50);

    // color in the selected shade
    //println(selectedColor);
    if (colorChanged) {
      fill(selectedColor);
      for (int i=0; i<letterCoordinatesList.size(); i+=3) {
        text((char)letterCoordinatesList.get(i), (float)letterCoordinatesList.get(i+1), (float)letterCoordinatesList.get(i+2));
      }
      colorChanged=!colorChanged;
    } else {
      fill(selectedColor);
    }

    // draw in the selected size
    if (selectedFontSize != 30) {
      textFont(textFont, selectedFontSize);
      for (int j=0; j<letterCoordinatesList.size(); j+=3) {
        text((char)letterCoordinatesList.get(j), (float)letterCoordinatesList.get(j+1), (float)letterCoordinatesList.get(j+2));
      }
    }

    // draw in the selected font
    if (!selectedFont.equals("Serif")) {
      if (letterCoordinatesList.size() !=0 && fontChanged) {
        // draw the letters again but with the new font (clear up the previous drawn letters)
        textFont=createFont(selectedFont, selectedFontSize);
        textFont(textFont, selectedFontSize);
        for (int i=0; i<letterCoordinatesList.size(); i+=3) {
          text((char)letterCoordinatesList.get(i), (float)letterCoordinatesList.get(i+1), (float)letterCoordinatesList.get(i+2));
        }
        fontChanged=!fontChanged;
      }
    } else {
      textFont=createFont(selectedFont, selectedFontSize);
      textFont(textFont, selectedFontSize);
    }

    // time to draw when the mouse is pressed
    if (mousePressed) {
      if (mouseY>70 && mouseY<height-50) {
        delay(80);
        mouseXCoords=mouseX;
        mouseYCoords=mouseY;
        letterCoordinatesList.add(inputWord.charAt(letterIterator));
        letterCoordinatesList.add(mouseXCoords);
        letterCoordinatesList.add(mouseYCoords);
        text(inputWord.charAt(letterIterator), mouseXCoords, mouseYCoords);
        if (letterIterator == inputWord.length()-1) {
          letterIterator=0;
        } else {
          letterIterator++;
        }
      }
    }

    // draw up the generative circles when the 'i m feeling lucky' button is pressed
    if (isSurprizeMeButtonPressed) {
      println(selectedColor);
      showMovingCircles(letterCoordinatesList, selectedColor, selectedFont, selectedFontSize);
    }
  } else {
    // animate the intro text
    fill(color(255, 240, 209));
    noStroke();
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
