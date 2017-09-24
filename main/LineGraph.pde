
class LineGraph {
  
  //object references
  Table tablea;
  ElementViewer elementViewerMain;
  interactionButton interaction1 = new interactionButton();
  interactionButton interaction2 = new interactionButton();


  ArrayList<interactionPoint> pointCollection = new ArrayList<interactionPoint>();

  
  //dimensions of the graph
  int d0, e0, w, h;
  
  //Input values

  String dimension0 = "";
  String dimension1 = "";
  float [] minValues;
  float [] maxValues;
  
  // properties of the graph
  float windowBuffer = 5;
  float axesBuffer = 0;
  float boxSize = 8;
  int tickMarkCount = 8;
  int numGuidelines = 4;
  
  // number formatting options
  DecimalFormat dfX = new DecimalFormat("#");
  DecimalFormat dfY = new DecimalFormat("#");
  DecimalFormat dfG = new DecimalFormat("#.##");

  //constructor  
  LineGraph() {}
  
  
  void setPosition (int _d0, int _e0, int _w, int _h)
  {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
  }
  
  
  void initializeGraph(Table _data, ElementViewer _viewerMain) 
  {
    if(_data == null)
    {return;}
    else
    {
      tablea = _data;
      elementViewerMain = _viewerMain;

      if(dimension0 == "")
      {
        dimension0 = "SATM";
      }

  
  
      minValues = new float[]{ 0, Float.MAX_VALUE};
      maxValues = new float[]{tablea.getRowCount(), -Float.MAX_VALUE};
      for (int i = 0; i < tablea.getRowCount(); i++)
      {
        
        float dim0 = tablea.getFloat(i, dimension0);
       
        minValues[1] = min(minValues[1], dim0);
        maxValues[1] = max(maxValues[1], dim0);
        
      }

    }
    
  }
  
  //when dimensions change, clear point list and hide selection menu
  void reinitializeGraph() 
  {

    minValues = new float[]{0, Float.MAX_VALUE};
    maxValues = new float[]{tablea.getRowCount(), -Float.MAX_VALUE};
    
    for (int i = 0; i < tablea.getRowCount(); i++)
    {
      float dim0 = tablea.getFloat(i, dimension0);
      
      minValues[1] = min(minValues[1], dim0);
      maxValues[1] = max(maxValues[1], dim0);
      
      
    }

    pointCollection.clear();
    
  }
    
  
  

  // draws guidelines of graph
  void drawGuidelines( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) 
  {
    float dMin = plotMinD-windowBuffer;
    float eMin = plotMinE+windowBuffer;
    float dMax = plotMaxD-windowBuffer;
    float eMax = plotMaxE+windowBuffer;
    
    stroke(150);
    noFill();
    
    // Draw Guidelines
    for (int i = 0; i <= numGuidelines; i++ ) 
    {
      
      float x = map( i, 0, numGuidelines, dMin, dMax );
      float y = map( i, 0, numGuidelines, eMin, eMax );
      
      fill(205,0,0);
      textSize(14);
      text(dfX.format((minValues[0])+(i*((maxValues[0]-minValues[0])/numGuidelines))), x, plotMinE + 10 + windowBuffer );
      
      // change formatting based on dimension currently selected
      if(dimension1 == "GPA")
      {
        text(dfG.format((minValues[1])+(i*((maxValues[1]-minValues[1])/numGuidelines))), plotMinD - 30, y + 5 );
      }
      
      else
      {
        text(dfY.format((minValues[1])+(i*((maxValues[1]-minValues[1])/numGuidelines))), plotMinD - 25, y - 3 ); //numerical values
      }
      
      line( x, eMin, x, eMax-windowBuffer );
      line( dMin, y, dMax+windowBuffer, y );
    }
    
  }

  // draws axes of graph
  void drawAxes( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) {
    
    float dMin = plotMinD-windowBuffer;
    float eMin = plotMinE+windowBuffer;
    float dMax = plotMaxD;
    float eMax = plotMaxE;

    stroke(0);
    noFill();
    
    line( dMin, eMin, dMax, eMin );
    line(dMin, eMax, dMax, eMax);

    line( dMin, eMin, dMin, eMax );
    line(dMax, eMin, dMax, eMax);


  }

  void draw() 
  {
    if(tablea == null)
    {
      return;
    }
    
    else
    {
      // restricts draw function to dimensions of graph
      float plotMinD = d0 + windowBuffer + axesBuffer;
      float plotMaxD = d0 + w - windowBuffer;
      float plotMinE = e0 + h - windowBuffer - axesBuffer;
      float plotMaxE = e0 + windowBuffer;
      
      rectMode(CORNERS);
      fill(255);
      
      // creates border and draws embellishments
      rect (plotMinD-windowBuffer, plotMaxE, plotMaxD, plotMinE+windowBuffer); //border
      drawGuidelines(plotMinD, plotMinE, plotMaxD, plotMaxE);
      drawAxes(plotMinD, plotMinE, plotMaxD, plotMaxE);
      


      //points on graph
      int i = 0;
     if(pointCollection.size() != tablea.getRowCount())
      {
        for (i = 0; i < tablea.getRowCount(); i++)
        {
          
        float a1 = tablea.getFloat(i, dimension0);
        float x = map(i, 0, tablea.getRowCount(), plotMinD, plotMaxD-windowBuffer);
        float y = map(a1, minValues[1], maxValues[1], plotMinE, plotMaxE+windowBuffer);
        
        StringList pointValues = new StringList();
        pointValues.append(tablea.getString(i, "GPA"));
        pointValues.append(tablea.getString(i, "ACT"));
        pointValues.append(tablea.getString(i, "SATV"));
        pointValues.append(tablea.getString(i, "SATM"));
        pointValues.append(str(i+1)); 
        
        interactionPoint interactionNewPoint = new interactionPoint(i, x, y, 5, pointValues, elementViewerMain);
        pointCollection.add(interactionNewPoint);
        
        }
        
      }
        
     else // points in graph are stored in one array
      {
         for(i = 0; i < pointCollection.size(); i++)
         {
           pointCollection.get(i).draw();
           pointCollection.get(i).highlightPoint();
           if(i > 0)
           {
             line(pointCollection.get(i-1).x_value, pointCollection.get(i-1).y_value, pointCollection.get(i).x_value, pointCollection.get(i).y_value);
           }
         }
      }

      
      //create buttons
      
      //x axis
      rectMode(CENTER);
      interaction1.createLineButton(d0 + 148, plotMinE + 55, 150, 30, 255, "Element #", false, false, this, elementViewerMain); 
      interaction1.draw();
    
      //y axis
      interaction2.createLineButton(d0 - 80, plotMaxE + 150, 30, 150, 255, dimension0, true, true, this, elementViewerMain);
      interaction2.draw();
       
    }


  }
  
  
}
 

 