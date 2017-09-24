
// data structure that is a part of a TrendLine

class interactionLine
{
  // holds points that make up the line
  interactionPoint dimensionOne;
  interactionPoint dimensionTwo;
  
  // constructor
  interactionLine(interactionPoint _dimensionOne, interactionPoint _dimensionTwo)
  {
    dimensionOne = _dimensionOne;
    dimensionTwo = _dimensionTwo;
    
  }
  
  void draw()
  {
    line(dimensionOne.x_value+3, dimensionOne.y_value, dimensionTwo.x_value-3, dimensionTwo.y_value);
  }
  
   
  
}