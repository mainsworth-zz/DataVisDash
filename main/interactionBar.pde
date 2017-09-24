
// object used for bar graph

class interactionBar
{
  
  // object references
  ElementViewer elementViewerReference;
  
  //style for the button
  StringList barValues = new StringList();
  
  float xValue1, yValue1, xValue2, yValue2;
  float barWidth, barHeight;
  
  // row number corresponding to table
  int rowNumber;
  
  //constructor
  interactionBar() {}

  
  // creates object using values given
  void createBar(float _x1, float _y1, float _x2, float _y2, int _row, ElementViewer _elementReference, String[] _barValues)
  {
    elementViewerReference = _elementReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    xValue2 = _x2;
    yValue2 = _y2;
    
    rowNumber = _row;
    
    barWidth = (xValue2 - xValue1);
    barHeight = (yValue2 - yValue1);
    
    for (int i = 0; i < 5; i++)
    {
      if(_barValues != null)
      {
        barValues.set(i, _barValues[i]);
      }
    }

  } 
  
  void draw()
  {
    rectMode(CORNERS);
    fill(0);
    rect(xValue1, yValue1, xValue2, yValue2);
  
  }
  
  void highlightBar()
  {
    if (overBar() || rowNumber == elementViewerReference.selectionRow)
    {
      stroke(205,0,0);
      fill(205,0,0);
      rect(xValue1, yValue1, xValue2, yValue2);
      
      if(elementViewerReference.selectionRow != rowNumber)
      {
         elementViewerReference.selectionRow = rowNumber; 
      }
      
      // updates element viewer based on bar's values
      elementViewerReference.updateInfoRows(barValues);
      fill(0);
    }
    
    // if not selected bar, draw normally
    else
    {
      stroke(0);
      fill(0);
      rect(xValue1, yValue1, xValue2, yValue2);
    }
    
  }
  
  // function to determine if mouse is over the bar
  boolean overBar()  
  {

    if (mouseX >= xValue1 && mouseX <= xValue2 && 
        mouseY >= yValue1 && mouseY <= yValue2) 
        {  return true;  } 
    else 
    {  return false;  }
    
  } 
  
}//definition ends