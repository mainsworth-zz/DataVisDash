
class BarGraph {
  
  // object references
  Table tablea;
  interactionButton interaction1 = new interactionButton();
  interactionButton interaction2 = new interactionButton();
  ElementViewer elementViewerMain;
  
  ArrayList<interactionBar> barCollection = new ArrayList<interactionBar>();

  
  // constructor
  BarGraph() {}
  
  // dimensions of the graph
  int d0, e0, w, h;
  
  // Input values
  String dimension0 = "";
  
  float [] minValues;
  float [] maxValues;
  
  // variables relating to dimensions of graph
  float windowBuffer = 5;
  float axesBuffer = 0;
  float barSize = 15;
  int tickMarkCount = 8;
  int numGuidelines = 4;
  
  // variable to hold selected row in table
  int selectedBarIndex = -1;
  
  // formatting for axes
  DecimalFormat dfX = new DecimalFormat("#");
  DecimalFormat dfY = new DecimalFormat("#");
  DecimalFormat dfG = new DecimalFormat("#.##");

  
  // sets position of graph to specific place
  void setPosition (int _d0, int _e0, int _w, int _h)
  {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
  }
  
  // creates the graph using the given table, with reference to the element viewer
  void initializeGraph(Table _data, ElementViewer _viewerReference) 
  {
    if( _data == null )
    { return; }
    else
    {
      tablea = _data;
      elementViewerMain = _viewerReference;
      if( dimension0 == "" )
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
  
  // helper function to interaction button to re-draw the graph
  void reinitializeGraph() 
  {

    minValues = new float[]{0, Float.MAX_VALUE};
    maxValues = new float[]{tablea.getRowCount(), -Float.MAX_VALUE};
    
    for ( int i = 0; i < tablea.getRowCount(); i++ )
    {
      float dim0 = tablea.getFloat(i, dimension0);
      
      minValues[1] = min(minValues[1], dim0);
      maxValues[1] = max(maxValues[1], dim0);
      
      
    }

    barCollection.clear();
    
  }
    
   // draws guidelines on axes to help improve readability
   void drawGuidelines( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) 
   {
    float dMin = plotMinD - windowBuffer;
    float eMin = plotMinE + windowBuffer;
    float dMax = plotMaxD - windowBuffer;
    float eMax = plotMaxE + windowBuffer;
    
    stroke(150);
    noFill();
    
    // Draw Guidelines
    for ( int i = 0; i <= numGuidelines; i++ ) 
    {
      float x = map( i, 0, numGuidelines, dMin, dMax );
      float y = map( i, 0, numGuidelines, eMin, eMax );
      fill(205,0,0);
      textSize(14);
      text(dfX.format( (minValues[0]) + (i *( (maxValues[0]-minValues[0]) / numGuidelines) )), x, plotMinE + 15 + windowBuffer );
      
      // change formatting based on whether the dimension is GPA
      if(dimension0 == "GPA")
      {
        text(dfG.format( (minValues[1]) + ( i * ( (maxValues[1]-minValues[1]) / numGuidelines) ) ), plotMinD - 30, y );
      }
      
      else
      {
        text(dfY.format( (minValues[1]) + (i*( (maxValues[1]-minValues[1]) / numGuidelines) ) ), plotMinD - 35, y + 5 ); //numerical values
      }
      
      line( x, eMin, x, eMax - windowBuffer );
      line( dMin, y, dMax + windowBuffer, y );
    }
  }

  // draws axes of the graph
  void drawAxes( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) {
    
    float dMin = plotMinD - windowBuffer;
    float eMin = plotMinE + windowBuffer;
    float dMax = plotMaxD;
    float eMax = plotMaxE;

    stroke(0);
    noFill();
    
    line( dMin, eMin, dMax, eMin );
    line(dMin, eMax, dMax, eMax);
    
    line( dMin, eMin, dMin, eMax );
    line(dMax, eMin, dMax, eMax);


  }
  
  // calculates the bar closest to the mouse pointer at any given point
  void closestBar()
  {
    float smallestDistance = Float.MAX_VALUE;
    int smallestIndex = -1;
    for( int i = 0; i < barCollection.size(); i++ )
    {
      
      {
        if( barCollection.get(i).overBar() )
        {
          // calculates distance between each line segment and the current mouse position
          float distance = barCollection.get(i).xValue1 - mouseX;
          if( distance < 0 )
          {
            distance = distance * -1; 
          }
          
          // will return index of closest line
          if( distance < smallestDistance )
          {
            smallestDistance = distance;
            smallestIndex = i;
          }
        
        }
       
     }
     
    }

    // ensures a closest line has been found  (-1 means no new line found)

    if(smallestIndex != -1)
    {
      elementViewerMain.selectionRow = smallestIndex;
    }
  
  }
   
   void draw() 
   {
    if( tablea == null )
    {
      return;
    }
    
    else
    {
      
      // restricts the draw function to the dimensions of the graph
      float plotMinD = d0;
      float plotMaxD = d0 + w;
      float plotMinE = e0 + h;
      float plotMaxE = e0;
      
      fill(255);
      rectMode(CORNERS);
      
      rect ( plotMinD - windowBuffer, plotMaxE, plotMaxD, plotMinE + windowBuffer ); //border
      drawAxes( plotMinD, plotMinE, plotMaxD, plotMaxE );
      
      fill(0);

      // points on graph
      int i = 0;
   
        // runs once for initialization
        if( barCollection.size()!= tablea.getRowCount() )
        {
          for ( i = 0; i < tablea.getRowCount(); i++ )
          {
            float a1 = tablea.getFloat(i, dimension0);
            float x_1 = map(i, 0, tablea.getRowCount(), plotMinD - windowBuffer, plotMaxD);
            float x_2 = map(i+1, 0, tablea.getRowCount(), plotMinD, plotMaxD);
            float y = map(a1, minValues[1], maxValues[1], plotMinE, plotMaxE);
            
            String[] barValues = new String[]{str(tablea.getFloat(i, "GPA")), str(tablea.getFloat(i, "ACT")), 
                                              str(tablea.getFloat(i, "SATV")), str(tablea.getFloat(i, "SATM")), str(i+1)}; 
            
            interactionBar interactionNewBar = new interactionBar();
            interactionNewBar.createBar(x_1, y, x_2, plotMinE + windowBuffer, i, elementViewerMain, barValues);
            barCollection.add(interactionNewBar);
          
          }
        }
        
        else // points in graph are stored in one array
        {

           for(i = 0; i < barCollection.size(); i++)
           {
             barCollection.get(i).draw();
           }
           
        }
        
      // calculate the closest bar to the mouse pointer
      closestBar();
      
      
      if(elementViewerMain.selectionRow != -1)
      {
        barCollection.get(elementViewerMain.selectionRow).highlightBar();
      }
            
      drawGuidelines(plotMinD, plotMinE, plotMaxD, plotMaxE);
      
      stroke(0);
      
      // create buttons
      
      // x axis
      rectMode(CENTER);
      interaction1.createBarButton(d0 + 150, plotMinE + 50, 150, 30, 255, "Element #", false, false, this, elementViewerMain);
      interaction1.draw();
    
      // y axis
      interaction2.createBarButton(d0 - 65, plotMaxE + 140, 30, 150, 255, dimension0, true, true, this, elementViewerMain);
      interaction2.draw();
           
        }

    }
    
  }
  
// bar graph definition ends