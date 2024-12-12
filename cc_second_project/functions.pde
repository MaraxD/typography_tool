// color customizing functions
void customizeDropdownList(DropdownList ddl) {
  ddl.setColorBackground(color(121, 87, 87));
  ddl.setColorForeground(color(59, 48, 48));
  ddl.setColorActive(color(59, 48, 48));
}

void customizeButton(Button btn) {
  btn.setColorBackground(color(121, 87, 87));
  btn.setColorForeground(color(59, 48, 48));
  btn.setColorActive(color(59, 48, 48));
}

void customizeTextfield(Textfield t) {
  t.setColor(color(102, 67, 67));
  t.setColorBackground(color(255, 240, 209));
  t.setColorForeground(color(255, 240, 209));
  t.setColorActive(color(255, 240, 209));
}

void customizeSlider(Slider s) {
  s.setColorBackground(color(121, 87, 87));
  s.setColorForeground(color(102, 67, 67));
  s.setColorActive(color(59, 48, 48));
}

void resetBackground(color backgroundColor) {
  background(backgroundColor);
}

// generative function
void showMovingCircles(ArrayList<Object> letterCoords, color selectedColor, String selectedFont, float selectedFontSize) {
  resetBackground(backgroundColor);

  // draw the upper and lower lines on each frame
  stroke(color(121, 87, 87));
  //upper line
  line(0, 50, width, 50);

  //bottom line
  line(0, height-50, width, height-50);

  fill(selectedColor);
  PFont textFont=createFont(selectedFont, selectedFontSize);
  textFont(textFont, selectedFontSize);

  for (int i=0; i<letterCoords.size(); i+=3) {
    text((char)letterCoords.get(i), (float)letterCoords.get(i+1), (float)letterCoords.get(i+2));
  }

  t+=0.05; //smoothness

  fill(0);
  for (int i=0; i<25; i++) {
    for (int j=0; j<15; j++) {
      circleX=25*i;
      circleY=55+35*j;

      circleDiam=10+10*cos(t+i+j);
      for (int k=0; k<letterCoords.size(); k+=3) {
        float distance=dist(circleX, circleY, (float)letterCoords.get(k+1), (float)letterCoords.get(k+2));
        if (distance<30) {
          circleDiam=2;
          break;
        }
      }

      ellipse(circleX, circleY, circleDiam, circleDiam);
    }
  }
}

// event handler
void controlEvent(ControlEvent theEvent) {
  // getting the input from the text box
  if (theEvent.isAssignableFrom(Textfield.class)) {
    inputWord = theEvent.getStringValue() != "" ? theEvent.getStringValue() : "";
    resetBackground(backgroundColor);
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
      resetBackground(backgroundColor);
      fontChanged=!fontChanged;
    } else if (theEvent.isFrom(fontSizeSlider)) {
      selectedFontSize=theEvent.getController().getValue();
      resetBackground(backgroundColor);
      fontSizeChanged=!fontSizeChanged;
    } else if (theEvent.isFrom(clearButton)) {
      resetBackground(backgroundColor);
      if (isSurprizeMeButtonPressed) {
        isSurprizeMeButtonPressed=!isSurprizeMeButtonPressed;
      }
      letterCoordinatesList.clear();
    } else if (theEvent.isFrom(colorButton)) {
      // show different small buttons with colors
      colorButtonOptions.show();
      isColorButtonPressed=!isColorButtonPressed;
    } else if (theEvent.isFrom(surprizeMeButton)) {
      isSurprizeMeButtonPressed=!isSurprizeMeButtonPressed;
    }

    // added an extra verification, so this part is not executed at setup
    if (theEvent.getController().getLabel().contains("colorOptions") && !inputWord.equals("")) {
      rgbValues=(int)theEvent.getController().getValue();
      // bitwise shift to the right get the colors from memory
      int red=(rgbValues>>16)& 0xFF; // -> rgbValues/ 2^16
      int green=(rgbValues>>8)  & 0xFF;
      int blue=rgbValues & 0xFF;
      selectedColor=color(red, green, blue);
      colorChanged=!colorChanged;
    }

    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}
