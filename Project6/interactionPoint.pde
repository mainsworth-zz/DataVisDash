
class interactionPoint
{
 
  //holds coordinate of points
  float x_value;
  float y_value;
  float size;
  
  
  interactionPoint(float _xValue, float _yValue, float _size)
  {
     x_value = _xValue;
     y_value = _yValue;
     size = _size;
  }
  
  void setup()
  {
     smooth();
     ellipseMode(CENTER);
  }
  
 
  void draw()
  { 
    ellipse(x_value, y_value, size, size);
  }
  
  
  
}