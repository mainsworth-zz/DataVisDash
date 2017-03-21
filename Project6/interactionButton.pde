
class interactionButton
{
  //object references
//  ElementViewer elementViewerReference;
//  ParallelGraph graphReference;
  
  //style for the button
  String textPhrase = "";
  
  float xValue1, yValue1, xValue2, yValue2, boxWidth, boxHeight;
  int currentColor, fillColor, fillColorHighlight;
  
  String firstDimension = "";
  String secondDimension = "";
  
  boolean mouseIsOver = false;
  boolean triggerLatch = false;
  boolean mouseCheck = false;
  boolean turnButton = false;
  
  //constructor
  interactionButton() {}
  
  void createButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton)
  {
       
//    graphReference = _graphReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    textPhrase = _text;
    
    fillColor = _fill;
    fillColorHighlight = 100;
    

    
    turnButton = _turnButton;
    
    
  }
  
  void setDimensions(String _dimOne, String _dimTwo)
  {
    firstDimension = _dimOne;
    secondDimension = _dimTwo;
  }
 
  
  //listener function
  void highlightButton()
  {
 /* if (overRect())
    {
      fill(fillColorHighlight);
      
      if(mousePressed == true)
      {
        if(graphReference.updatingDimensions == false)
        {
          for(int i = 0; i < graphReference.numOfDimensions; i++)
          {
            if(graphReference.dimensionListing.get(i) == secondDimension)
            {
              graphReference.updatingListing.set(i, firstDimension);
              graphReference.updatingListing.set(i-1, secondDimension);
              graphReference.updatingDimensions = true;
            }
          }
          
          
          mouseCheck = false;
          
        }
        
      }
    
    }
    
    else
      {
        fill(fillColor);
      }
      */
      //redraws object

      fill(255);
      rectMode(CENTER);
      rect(xValue1, yValue1, boxWidth, boxHeight);
      rectMode(CORNER);

     
    if(turnButton)
    {
      pushMatrix();
      translate(xValue1,yValue1);
      rotate(-HALF_PI);
      translate(-xValue1, -yValue1);
      fill(0);
      textSize(18);
      text(textPhrase, xValue1, yValue1);
      popMatrix();
    }
    else
    {
      textSize(18);
      textAlign(CENTER, CENTER);
      fill(0);
      text(textPhrase, xValue1, yValue1); 
      textSize(12);
    }
    
    
  }

   
    
    
  
  //listener function to detect mouse interaction
  boolean overRect()  
  {

    if (mouseX >= (xValue1 - (boxWidth/2)) && mouseX <= xValue1+(boxWidth/2) && 
        mouseY >= (yValue1 - (boxHeight/2)) && mouseY <= yValue1+(boxHeight/2)) 
        {
        return true;} 
    else 
    {return false;}
    
  }
  
  //draws object
  void draw()
  {
    
//    fill(fillColor);
    rectMode(CENTER);
    rect(xValue1, yValue1, boxWidth, boxHeight);
    rectMode(CORNER);
    textSize(24);
    textAlign(CENTER, CENTER);
    
    if(turnButton)
    {
      pushMatrix();
      translate(xValue1,yValue1);
      rotate(-HALF_PI);
      translate(-xValue1, -yValue1);
      fill(0);
      textSize(18);
      text(textPhrase, xValue1, yValue1);
      popMatrix();
    }
    
    else
    {
      fill(0);
      text(textPhrase, xValue1, yValue1);
      fill(255);
    
    }
    textSize(12);
    highlightButton();
  }
  
  
}



 
 
 