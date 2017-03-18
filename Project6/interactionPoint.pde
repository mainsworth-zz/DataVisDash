
class interactionPoint
{
 
  //holds coordinate of points
  float x_value;
  float y_value;
  float size;
  color fillColor = color(255,0,0);
  color fillColorHighlight = color(0,0,0);
  
  StringList pointValues = new StringList();
  
  ElementViewer elementViewerReference;
  
  interactionPoint(float _xValue, float _yValue, float _size, StringList _pointValues, ElementViewer _viewerReference)
  {
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
  
   //creates interactivity for point
  void highlightPoint()
  {
    if (overPoint())
    {
      fill(fillColorHighlight);
      if(mousePressed == true)
      {

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
    ellipse(x_value, y_value, size, size);
  }
  
  
  
}