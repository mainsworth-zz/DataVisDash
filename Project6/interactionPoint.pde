
class interactionPoint
{
 
  //holds coordinate of points
  int rowNumber;
  float x_value;
  float y_value;
  float size;
  color fillColor = color(255,0,0);
  color fillColorHighlight = color(0,0,0);
  
  int selectionRow = -1;
  
  StringList pointValues = new StringList();
  
  ElementViewer elementViewerReference;
  
  interactionPoint(int _rowNumber, float _xValue, float _yValue, float _size, StringList _pointValues, ElementViewer _viewerReference)
  {
     rowNumber = _rowNumber;
     x_value = _xValue;
     y_value = _yValue;
     size = _size;
     
     pointValues = _pointValues;
     elementViewerReference = _viewerReference;
  }
  
  void setup()
  {
     smooth();
     ellipseMode(CENTER);
  }
  
  void setSelection(int _selectionRow)
  {
    selectionRow = _selectionRow; 
    
  }
  
   //creates interactivity for point
  void highlightPoint()
  {
    if (overPoint() || rowNumber == elementViewerReference.selectionRow)
    {
      fill(fillColorHighlight);
      if(mousePressed == true && overPoint())
      {
        if(elementViewerReference.selectionRow != rowNumber)
        {
          elementViewerReference.selectionRow = rowNumber;
        }

        elementViewerReference.updateInfoRows(pointValues);
      }
    }
    
    else
    {
      fill(fillColor);
    }
    
    ellipse(x_value, y_value, size, size);
    
  }

  boolean overPoint() {
    float disX = x_value - mouseX;
    float disY = y_value - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < size/2 ) {
      return true;
    } else {
      return false;
    }
  }
  
 
  void draw()
  {
    if(rowNumber == elementViewerMain.selectionRow)
    {
       fill(255,0,0); 
    }
    ellipse(x_value, y_value, size, size);
    fill(255);
  }
  
  
  
}