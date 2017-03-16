
class interactionPoint
{
 
  //holds coordinate of points
  float x_value;
  float y_value;
  
  
  interactionPoint(float _xValue, float _yValue)
  {
     x_value = _xValue;
     y_value = _yValue;
  }
  
 
  void draw()
  {
    point(x_value, y_value);
  }
  
  
  
}