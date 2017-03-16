
class interactionBar
{
  ElementViewer elementViewerReference;
  
  //style for the button
  String barValues[] = new String[5];
  
  float xValue1, yValue1, xValue2, yValue2;
  float barWidth, barHeight;


  color fillColor = color(255,0,0);
  color fillColorHighlight = color(0,0,0);
  
  //constructor
  interactionBar() {}

  
  void createBar(float _x1, float _y1, float _x2, float _y2, ElementViewer _elementReference, String[] _barValues)
  {
    elementViewerReference = _elementReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    xValue2 = _x2;
    yValue2 = _y2;
    
    barWidth = (xValue2 - xValue1);
    barHeight = (yValue2 - yValue1);
    
    for (int i = 0; i < 5; i++)
    {
      if(_barValues != null)
      {
        barValues[i] = _barValues[i];
      }
    }
    
    fill(fillColor);
    rectMode(CORNERS);
    rect(xValue1, yValue1, xValue2, yValue2);

  } 
  
  void drawBar()
  {
    rectMode(CORNERS);
    rect(xValue1, yValue1, xValue2, yValue2);
  }
  
  void highlightBar()
  {
    if (overBar())
    {
      fill(fillColorHighlight);
//      elementViewerReference.updateInfoRows(barValues);
    }
    
    else
    {
      fill(fillColor);
    }
    
    rect(xValue1, yValue1, xValue2, yValue2);
    
  }
  
  boolean overBar()  {

    if (mouseX >= xValue1 && mouseX <= xValue2 && 
        mouseY >= yValue1 && mouseY <= yValue2) 
        {
        return true;} 
    else 
    {return false;}
  }
  
  
  
}//definition ends