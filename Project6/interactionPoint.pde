
// data structure for scatter plot and line graphs

class interactionPoint
{
  
  // object references
  ElementViewer elementViewerReference;
  
  StringList pointValues = new StringList();
  
  // number associated with row in table
  int rowNumber;
  
  //holds coordinate of points
  float x_value;
  float y_value;
  
  // determines size of point to be drawn
  float size;
  
  // color of point
  color fillColor = color(255,0,0);
  color fillColorHighlight = color(0,0,0);
  
  // currently selected row in table
  int selectionRow = -1;
  

  // constructor
  interactionPoint(int _rowNumber, float _xValue, float _yValue, float _size, StringList _pointValues, ElementViewer _viewerReference)
  {
     pointValues = _pointValues;
     elementViewerReference = _viewerReference;
     
     rowNumber = _rowNumber;
     
     x_value = _xValue;
     y_value = _yValue;
     
     size = _size;
     
  }
  
  void setup()
  {
     smooth();
     ellipseMode(CENTER);
  }
  
  // changes currently selected row
  void setSelection(int _selectionRow)
  {
    selectionRow = _selectionRow; 
    
  }
  
  // creates interactivity for point
  void highlightPoint()
  {
    
    // if point is related to the currently selected row in table, or hovered over 
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
    
    // if not, draw normally
    else
    {
      fill(fillColor);
    }
    
    ellipse(x_value, y_value, size, size);
    
  }
  
  
  // function to determine if mouse is over the point
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
    // if the point is the currently selected, draw
    if(rowNumber == elementViewerMain.selectionRow)
    {
       fill(255,0,0); 
    }
    
    ellipse(x_value, y_value, size, size);
    fill(255);
    
  }
  
  
} // definition ends