
class interactionBar
{
  ElementViewer elementViewerReference;
  
  //style for the button
  StringList barValues = new StringList();
  
  float xValue1, yValue1, xValue2, yValue2;
  float barWidth, barHeight;
  int rowNumber;

//  color fillColor = color(255,0,0);
//  color fillColorHighlight = color(255,0,0);
  
  //constructor
  interactionBar() {}

  
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
//    highlightBar();
//    fill(0);
  
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
//      println("Over it.");
      elementViewerReference.updateInfoRows(barValues);
      fill(0);
    }
    
    else
    {
      stroke(0);
      fill(0);
      rect(xValue1, yValue1, xValue2, yValue2);
    }
    
  }
  
  
  boolean overBar()  {

    if (mouseX >= xValue1 && mouseX <= xValue2 && 
        mouseY >= yValue1 && mouseY <= yValue2) 
        {
//          println("over bar");
        return true;} 
    else 
    {return false;}
  }
  
  
  
}//definition ends