
/*class BarGraph {
  
  //object references
  interactionButton interaction1 = new interactionButton();
  interactionButton interaction2 = new interactionButton();
  ElementViewer elementViewerMain = new ElementViewer();
  ArrayList<interactionBar> barCollection = new ArrayList<interactionBar>();
  Table tablea;
  
  //constructor
  BarGraph() {}
  
  //dimensions of the graph
  int d0, e0, w, h;
  
  //Input values
  String dimension0 = "";
  String dimension1 = "";
  
  float [] minValues;
  float [] maxValues;
  
  float windowBuffer = 15;
  float axesBuffer = 50;
  float barSize = 15;
  int tickMarkCount = 8;
  int numGuidelines = 4;
  
  DecimalFormat dfX = new DecimalFormat("#");
  DecimalFormat dfY = new DecimalFormat("#");
  DecimalFormat dfG = new DecimalFormat("#.##");

  
  void setPosition (int _d0, int _e0, int _w, int _h)
  {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
  }
  
  void initializeGraph(Table _data) 
  {
    if(_data == null)
    {return;}
    else
    {
      tablea = _data;
      if(dimension0 == "")
      {
        dimension0 = "SATM";
      }
      
      if(dimension1 == "")
      {
        dimension1 = "SATV";
      }
  
      minValues = new float[]{ 0, Float.MAX_VALUE};
      maxValues = new float[]{tablea.getRowCount(), -Float.MAX_VALUE};
      
      for (int i = 0; i < tablea.getRowCount(); i++)
      {
        float dim1 = tablea.getFloat(i, dimension1);
        
        minValues[1] = min(minValues[1], dim1);
        maxValues[1] = max(maxValues[1], dim1);
      }

    }
    
  }
  
  void reinitializeGraph() 
  {

    minValues = new float[]{ 0, Float.MAX_VALUE};
    maxValues = new float[]{tablea.getRowCount(), -Float.MAX_VALUE};
    for (int i = 0; i < tablea.getRowCount(); i++)
    {
      float dim1 = tablea.getFloat(i, dimension1);
      
      minValues[1] = min(minValues[1], dim1);
      maxValues[1] = max(maxValues[1], dim1);
      
      
    }

    barCollection.clear();
    elementViewerMain.hideSelectionMenu();
    
   }
   
   void drawGuidelines( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) 
   {
    float dMin = plotMinD-windowBuffer;
    float eMin = plotMinE+windowBuffer;
    float dMax = plotMaxD;
    float eMax = plotMaxE;
    
    stroke(150);
    noFill();
    
    // Draw Guidelines
    for (int i = 1; i <= numGuidelines; i++ ) 
    {
      float x = map( i, 0, numGuidelines, dMin, dMax );
      float y = map( i, 0, numGuidelines, eMin, eMax );

      if(dimension0 == "GPA")
      {      
        text(dfG.format((minValues[0])+(i*((maxValues[0]-minValues[0])/numGuidelines))), x-2, plotMinE + 15 + windowBuffer );
      }
      
      else
      {
        text(dfX.format((minValues[0])+(i*((maxValues[0]-minValues[0])/numGuidelines))), x-2, plotMinE + 15 + windowBuffer );
      }
      
      if(dimension1 == "GPA")
      {
        text(dfG.format((minValues[1])+(i*((maxValues[1]-minValues[1])/numGuidelines))), plotMinD - 15 - windowBuffer-5, y-3 );
      }
      
      else
      {
        text(dfY.format((minValues[1])+(i*((maxValues[1]-minValues[1])/numGuidelines))), plotMinD - 15 - windowBuffer-5, y-3); //numerical values
      }
      
      line( x, eMin, x, eMax );
      line( dMin, y, dMax, y );
    }
  }

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
      
      float plotMinD = d0 + windowBuffer + axesBuffer;
      float plotMaxD = d0 + w - windowBuffer;
      float plotMinE = e0 + h - windowBuffer - axesBuffer;
      float plotMaxE = e0 + windowBuffer;
      
      rectMode(CORNERS);
      fill(205);
      rect(0, 0, width, height);
      stroke(0); 
      fill(255);
      
      rect (plotMinD-windowBuffer, plotMaxE, plotMaxD, plotMinE+windowBuffer); //border
      drawGuidelines(plotMinD, plotMinE, plotMaxD, plotMaxE);
      drawAxes(plotMinD, plotMinE, plotMaxD, plotMaxE);
      


      //points on graph
      int i = 0;
      for (i = 0; i < tablea.getRowCount(); i++)
      {
        if(barCollection.size()!= tablea.getRowCount() && barCollection.size() <= tablea.getRowCount())
        {
          
        float a1 = tablea.getFloat(i, dimension1);
        float x_1 = map(i, 0, tablea.getRowCount(), plotMinD-15, plotMaxD);
        float x_2 = map(i+1, 0, tablea.getRowCount(), plotMinD-15, plotMaxD);
        float y = map(a1, minValues[1], maxValues[1], plotMinE, plotMaxE);
        
        String[] barValues = new String[]{str(tablea.getFloat(i, "GPA")), str(tablea.getFloat(i, "ACT")), str(tablea.getFloat(i, "SATM")), str(tablea.getFloat(i, "SATV")), str(i+1)}; 
        
        interactionBar interactionNewBar = new interactionBar();
        interactionNewBar.createBar(x_1, y, x_2, height-windowBuffer-axesBuffer+5, elementViewerMain, barValues);
        barCollection.add(interactionNewBar);
        
        }
        
        else // points in graph are stored in one array
        {
         for(i = 0; i < barCollection.size(); i++)
         {
           barCollection.get(i).drawBar();
           barCollection.get(i).highlightBar();
         }
      }
      
      //create buttons
      
      //x axis
      rectMode(CENTER);
      interaction1.createButton(axesBuffer+50, height - axesBuffer+15, 75, 30, 255, "Element #", elementViewerMain, false); 
    
      //y axis
      interaction2.createButton(axesBuffer-15, height-axesBuffer-55, 30, 75, 255, dimension1, elementViewerMain, true);
      interaction2.highlightButton();
      
      rectMode(CORNERS);
      
      //create event viewer
      elementViewerMain.createViewer(plotMaxD+25, plotMaxE, width - 25, height - axesBuffer-1, 255, tablea, this);
      elementViewerMain.createInfoRows();
      

            
        }

    }
    
  }
  
}//definition ends

*/