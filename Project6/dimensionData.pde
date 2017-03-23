
class dimensionData
{
   String dimensionName;
   
  //holds min and max values for a specific dimension
   float minValue = Float.MAX_VALUE;
   float maxValue = -Float.MAX_VALUE;
  
  
  dimensionData(String _dimensionName, float _minValue, float _maxValue)
  {
    dimensionName = _dimensionName;
    
    minValue = _minValue;
    maxValue = _maxValue;
    
  }
  
}