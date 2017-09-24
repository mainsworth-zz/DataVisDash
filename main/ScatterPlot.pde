
class ScatterPlot 
{
  //object references
  Table tablea;
  ScatterMatrix matrixReference;
  ElementViewer elementViewer;
 //<>// //<>//
  ArrayList<interactionPoint> pointCollection = new ArrayList<interactionPoint>();

  //dimensions of the graph
  int d0, e0, w, h;
  
  //Input values
  String dimension0 = "";
  String dimension1 = "";
  
  float [] minValues;
  float [] maxValues;
  
  int axesBuffer = 0;
  int windowBuffer = 5;
  int pointSize = 5;
  
  // variable to keep track of currently selected row
  int selectedRow = -1;
  
  // flag to determine which scatterplot is being used in the main window
  boolean mainWindow = false;

  // text formatting for gridlines
  DecimalFormat dfX = new DecimalFormat("#");
  DecimalFormat dfY = new DecimalFormat("#");
  DecimalFormat dfG = new DecimalFormat("#.##");
  
  //constructor
  ScatterPlot() {}
  
  // sets position of graph
  void setPosition (int _d0, int _e0, int _w, int _h)
  {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
  }
  
  void setSelection(int _selectedRow)
  {
    selectedRow = _selectedRow;
    
  }
  
  // creates graph with given data references
  void initializeGraph(Table _data, ScatterMatrix _matrixReference, String _dimension0, String _dimension1, boolean _mainWindow) 
  {
    
    //ensures data is loaded first before proceeding
    if(_data == null)
    {  return;  }
    
    else
    {
        tablea = _data;
        matrixReference = _matrixReference;
        elementViewer = matrixReference.viewerReference;
        
        mainWindow = _mainWindow;
        
        dimension0 = _dimension0;
        dimension1 = _dimension1;
        
        if(mainWindow == true)
        {
          axesBuffer = matrixReference.axesBuffer;
          windowBuffer = matrixReference.windowBuffer;
        }
     }
     
     
     //sets range values
     minValues = new float[]{ Float.MAX_VALUE, Float.MAX_VALUE};
     maxValues = new float[]{-Float.MAX_VALUE, -Float.MAX_VALUE};
      
     //ensures there are dimensions to check for
     if(dimension0 != "" && dimension1 != "")
     {
        
        for (int i = 0; i < tablea.getRowCount(); i++)
        {
          
          float dim0 = tablea.getFloat(i, dimension0);
          float dim1 = tablea.getFloat(i, dimension1);
          
          minValues[0] = min(minValues[0], dim0);
          minValues[1] = min(minValues[1], dim1);
          maxValues[0] = max(maxValues[0], dim0);
          maxValues[1] = max(maxValues[1], dim1);
          
        }
        
     }

  }
    
  
  
  //when dimensions change, clear point list
  void reinitializeGraph() 
  {

    minValues = new float[]{ Float.MAX_VALUE, Float.MAX_VALUE};
    maxValues = new float[]{-Float.MAX_VALUE, -Float.MAX_VALUE};
    if(dimension0 != "" && dimension1 != "")
    {
      for (int i = 0; i < tablea.getRowCount(); i++)
      {
        float dim0 = tablea.getFloat(i, dimension0);
        float dim1 = tablea.getFloat(i, dimension1);
        minValues[0] = min(minValues[0], dim0);
        minValues[1] = min(minValues[1], dim1);
        maxValues[0] = max(maxValues[0], dim0);
        maxValues[1] = max(maxValues[1], dim1);      
        
      }

      pointCollection.clear();
      
    }

    
  }

   
  // draws guidelines of the graph
  void drawGuidelines( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) 
  {
    float uMin = plotMinD-windowBuffer;
    float vMin = plotMinE+windowBuffer;
    float uMax = plotMaxD-windowBuffer;
    float vMax = plotMaxE+windowBuffer;
    
    stroke(150);
    noFill();
    
    // Draw Guidelines
    for (int i = 1; i <= matrixReference.numGuidelines; i++ ) {
      float x = map( i, 0, matrixReference.numGuidelines, uMin, uMax );
      float y = map( i, 0, matrixReference.numGuidelines, vMin, vMax );
      
      if(dimension0 == "GPA")
      {      
        text(dfG.format((minValues[0])+(i*((maxValues[0]-minValues[0])/matrixReference.numGuidelines))), x-2, plotMinE + 15 + windowBuffer );
      }
      
      else
      {
        text(dfX.format((minValues[0])+(i*((maxValues[0]-minValues[0])/matrixReference.numGuidelines))), x-2, plotMinE + 15 + windowBuffer );
      }
      
      if(dimension1 == "GPA")
      {
        text(dfG.format((minValues[1])+(i*((maxValues[1]-minValues[1])/matrixReference.numGuidelines))), plotMinD - 15 - windowBuffer-5, y-3 );
      }
      
      else
      {
        text(dfY.format((minValues[1])+(i*((maxValues[1]-minValues[1])/matrixReference.numGuidelines))), plotMinD - 15 - windowBuffer-5, y-3); //numerical values
      }
      
      line( x, vMin, x, vMax-windowBuffer );
      line( uMin, y, uMax+windowBuffer, y );
      
    }
    
  }
  
  // draws axes of the graph
  void drawAxes( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) {
    
    float uMin = plotMinD-windowBuffer;
    float vMin = plotMinE+windowBuffer;
    float uMax = plotMaxD;
    float vMax = plotMaxE;

    stroke(0);
    noFill();
    
    /* draw x */
    line( uMin, vMin, uMax, vMin );
    line(uMin, vMax, uMax, vMax);
    
    /* draw y */
    line( uMin, vMin, uMin, vMax );
    line(uMax, vMin, uMax, vMax);


  }
  
  // helper function to determine if the mouse pointer is over a scatter plot matrix box
  boolean overRect()  {

    if (mouseX >= (d0 + windowBuffer + axesBuffer) && mouseX <= (d0 + w - windowBuffer) && 
        mouseY <= (e0 + h - windowBuffer - axesBuffer) && mouseY >= e0 + windowBuffer) 
        {
        return true;} 
    else 
    {return false;}
  }
  
  

  void draw() 
  {
    if(tablea == null)
    {
      return;
    }
    
    else
    {
        // restricts draw function to dimensions of the graph
        float plotMinD = d0 + windowBuffer + axesBuffer;
        float plotMaxD = d0 + w - windowBuffer;
        float plotMinE = e0 + h - windowBuffer - axesBuffer;
        float plotMaxE = e0 + windowBuffer;
        
        fill(255);
        
        // if this is not the main scatter plot, do this
        if(!mainWindow)
        {
          rectMode(CORNERS);
          if(matrixReference.selectedPlot.dimension0 == dimension0 &&
             matrixReference.selectedPlot.dimension1 == dimension1)
             {
               strokeWeight(4);
             }
          
          // if the mouse is over the box, do this
          if(overRect() && dimension0 != dimension1)
          {
                fill(205);
                if(mousePressed == true)
                {
                  matrixReference.selectGraph(dimension0, dimension1);
                  matrixReference.selectedPlot.reinitializeGraph();
                }
          }

        }
        
        
        rect (plotMinD-windowBuffer, plotMaxE, plotMaxD, plotMinE+windowBuffer); //border
        
        strokeWeight(1);  
        
        // if this is the main window, do this
      if(mainWindow)
      {
         drawGuidelines(plotMinD, plotMinE, plotMaxD, plotMaxE);
         drawAxes(plotMinD, plotMinE, plotMaxD, plotMaxE);
      }
        
      // draws diagonal row for matrix
      if(dimension0 == dimension1 && mainWindow == false)
      {
        textAlign(CENTER,CENTER);
        textSize(18);
        fill(0);
        text(dimension0, plotMinD+w/2 - 7, plotMinE - h/2 +3);
        fill(255);
      }
      
      // creates data for the points, to be used later
      else
      { 
        if(pointCollection.size() != tablea.getRowCount())
        {
          for (int i = 0; i < tablea.getRowCount(); i++)
          {
  
              
              float a0 = tablea.getFloat(i, dimension0);
              float a1 = tablea.getFloat(i, dimension1);
              float x = map(a0, minValues[0], maxValues[0], plotMinD, plotMaxD-windowBuffer);
              float y = map(a1, minValues[1], maxValues[1], plotMinE, plotMaxE+windowBuffer);
              
              StringList pointValues = new StringList();  
              
              pointValues.append(str(i));
              pointValues.append(tablea.getString(i, "SATM"));
              pointValues.append(tablea.getString(i, "SATV"));
              pointValues.append(tablea.getString(i, "ACT"));
              pointValues.append(tablea.getString(i, "GPA"));
              pointValues.reverse();
              
              interactionPoint interactionNewPoint = new interactionPoint(i, x, y, pointSize, pointValues, elementViewer);
              pointCollection.add(interactionNewPoint);
              
            }
          
        }
          
       else // points in graph are stored in one array
         {
                          
               
               for(int i = 0; i < pointCollection.size(); i++)
               {
      
                 // makes only the main window's points have interactivity
                 if(mainWindow)
                 {
                   
                   pointCollection.get(i).highlightPoint(); //interaction function
                 
                 }
                 
                 else
                 {
                   pointCollection.get(i).draw();
                 }
                 
                 
               }
               
               // highlights a point in all scatter plots that references the selected row
               if(elementViewerMain.selectionRow != -1 && !mainWindow)
               {
                  pointCollection.get(elementViewerMain.selectionRow).draw(); 
               }
   
               
           }
  
        }
          
          
     }

  }
    
    
}
  

 

 