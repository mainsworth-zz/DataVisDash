
// data structure for parallel coordinate plane
// each trendline is a row in the table, referencing each of the dimensions


class TrendLine
{
  // object references
  Table referenceTable;
  ParallelGraph graphReference;
  ElementViewer viewerReference;
  
  //holds a collection of line objects to reference this object
  ArrayList<interactionPoint> trendPoints = new ArrayList<interactionPoint>();
  float [] dataArray = new float[]{0,0,0,0};
  
  StringList dimensionList = new StringList();
  StringList viewerList = new StringList();
  StringList viewerValues = new StringList();
  
  // holds value of currently seelected values
  int rowNumber = -1;

  // flag for if this is the currently selected row in the table
  boolean selectedLine = false;
  
  
 //constructor
 TrendLine(Table _referenceTable, ParallelGraph _graphReference, StringList _dimensions, StringList _headers, int _rowNumber, ElementViewer _viewerReference)
 {
   
   referenceTable = _referenceTable;
   graphReference = _graphReference;
   viewerReference = _viewerReference;
   rowNumber = _rowNumber;
   
   dimensionList = _dimensions.copy();
   viewerList = _headers.copy();
 
 }
   
 
 //pulls data from table to associate with this trendline
 void populateData()
 {
   // resets value in viewer, to avoid memory leaks
   viewerValues.clear();
   
   // pulls data from specific row in table
   TableRow currentRow = referenceTable.getRow(rowNumber);
   
   viewerValues.set(0, str(rowNumber+1));
   for(int i = 0; i < dimensionList.size(); i++)
   {

     dataArray[i] = currentRow.getFloat(dimensionList.get(i));
     viewerValues.set(i+1, currentRow.getString(viewerList.get(i)));
   }
   
   // reverses the order, based on how the element viewer is structured
   viewerValues.reverse();
  
  
 }
  //<>// //<>//
 // pulls data from table and creates points on graph, to be connected
 void createPoints()
 {
        //sets boundaries of points to boundaries of graph
        float dMin = graphReference.d0 + graphReference.windowBuffer;
        float eMin = graphReference.e0 + graphReference.h - graphReference.windowBuffer;
        float dMax = graphReference.d0 + graphReference.w - graphReference.windowBuffer;
        float eMax = graphReference.e0 + graphReference.windowBuffer + graphReference.windowBuffer;  
     
     
     //clears arraylist to avoid memory leak  
     trendPoints.clear();
     
     //adds new points to arraylist
     for(int i = 0; i < graphReference.numOfDimensions; i++)
     {
       
        float x = map( i, 0, graphReference.numOfDimensions-1, dMin, dMax-25 );
        float y = map( dataArray[i], graphReference.dimensionValues.get(i).minValue, graphReference.dimensionValues.get(i).maxValue, eMin+15, eMax+5);
        
        StringList pointValues = new StringList();
            pointValues.append(tablea.getString(i, "SATM"));
            pointValues.append(tablea.getString(i, "SATV"));
            pointValues.append(tablea.getString(i, "ACT"));
            pointValues.append(tablea.getString(i, "GPA"));
            
        interactionPoint newPoint = new interactionPoint(i+2, x, y, 1, pointValues, viewerReference);
        trendPoints.add(newPoint);
        
     }
   
 }
 
 
  //calculates distance mouse is from line
  float mouseDistance(float x1, float y1, float x2, float y2) 
  {
  
    float d1 = dist(x1, y1, mouseX, mouseY);
    float d2 = dist(x2, y2, mouseX, mouseY);
    
    return d1+d2;
  }
  
  
  // highlights a line if it is the currently selected
  void highlightLine()
  {
     if(selectedLine || rowNumber == viewerReference.selectionRow)
     {
       strokeWeight(10);
       stroke(230,0,0);
       
       if(viewerReference.selectionRow != rowNumber)
       {
         viewerReference.selectionRow = rowNumber;
       }

     }
    
  }

  // helper function to calculate distance mouse is from the line
  boolean mouseOnLine(float x_value1, float y_value1, float x_value2, float y_value2) {
  float d = dist( x_value1, y_value1, x_value2, y_value2 );
  float d1 = dist( x_value1, y_value1, mouseX, mouseY );
  float d2 = dist( x_value2, y_value2, mouseX, mouseY );

  if ((d1 + d2) < d+1) 
  {
    return true;
  }

  return false;
}
 

 void draw()
 {
   
      //takes in data
      populateData();
      createPoints();
      
      
      //creates lines
      strokeWeight(3);
      interactionLine line1 = new interactionLine(trendPoints.get(0), trendPoints.get(1));
      interactionLine line2 = new interactionLine(trendPoints.get(1), trendPoints.get(2));
      interactionLine line3 = new interactionLine(trendPoints.get(2), trendPoints.get(3));
      
      //listener function for interaction
      highlightLine();
      
      //draws lines
      line1.draw();
      line2.draw();
      line3.draw();

      strokeWeight(1);
      stroke(105);
   
 }
  
  
}