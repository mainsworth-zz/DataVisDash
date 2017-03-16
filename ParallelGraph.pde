

class ParallelGraph {
  
  //object references
  ArrayList<TrendLine> trendLines = new ArrayList<TrendLine>();
  ArrayList<interactionButton> interactionButtons = new ArrayList<interactionButton>();
  ArrayList<dimensionData> dimensionValues = new ArrayList<dimensionData>();
  ElementViewer viewerReference;
  
  //dimensions of the graph
  int d0, e0, w, h;
  
  //Input values
  Table tablea;
  StringList viewerListing = new StringList();
  StringList dimensionListing = new StringList();
  StringList updatingListing = new StringList();
  float [] minValues;
  float [] maxValues;
  
  //settings for the graph
  float windowBuffer = 0;
  float axesBuffer = 0;
  float boxSize = 8;
  int tickMarkCount = 8;
  int numGuidelines = 4;
  int numOfDimensions = 4;
  
  int selectedLineIndex = -1;
  
  //formats for numbers
  DecimalFormat dfX = new DecimalFormat("#");
  DecimalFormat dfY = new DecimalFormat("#");
  DecimalFormat dfG = new DecimalFormat("#.##");

  //helper variables for updating coordinate lines
  boolean updatingDimensions = false;
  String updateDimOne;
  String updateDimTwo;
  
  
  //constructor  
  ParallelGraph() 
  {
        //sets list of dimensions, in order
        viewerListing.set(0, "SATM");
        viewerListing.set(1, "SATV");
        viewerListing.set(2, "ACT");
        viewerListing.set(3, "GPA"); 
        
        
        dimensionListing.set(0, "SATM");
        dimensionListing.set(1, "SATV");
        dimensionListing.set(2, "ACT");
        dimensionListing.set(3, "GPA"); 
        
        updatingListing.set(0, "SATM");
        updatingListing.set(1, "SATV");
        updatingListing.set(2, "ACT");
        updatingListing.set(3, "GPA"); 
  }
  
  //sets position of graph
  void setPosition (int _d0, int _e0, int _w, int _h)
  {
    d0 = _d0;
    e0 = _e0;
    w = _w;
    h = _h;
  }
  
  //creates a new graph using given table
  void initializeGraph(Table _data, ElementViewer _viewer) 
  {
    if(_data == null || _viewer == null)
    {return;}
    else
    {
      tablea = _data;
      viewerReference = _viewer;

    }
  }
  
  
 
 //creates data values for each parallel line
 void populateDataDimensions()
 {
    dimensionValues.clear();
    for(int i = 0; i < dimensionListing.size(); i++)
    {
        float minValue = Float.MAX_VALUE;
        float maxValue = -Float.MAX_VALUE;
         for (int j = 0; j < tablea.getRowCount(); j++)
          {

           float dim1 = tablea.getFloat(j, dimensionListing.get(i));
       
            minValue = min(minValue, dim1);
            maxValue = max(maxValue, dim1);
          }
           dimensionData dimensionBounds= new dimensionData(dimensionListing.get(i), minValue, maxValue);
           dimensionValues.add(dimensionBounds);    
  }
   
 }
 
 //called whenever an interaction button is used to move parallel lines
 void updateDimensions()
 {
    for(int i = 0; i < numOfDimensions; i++)
    {
       dimensionListing.set(i, updatingListing.get(i)); 
    }
    
    updatingDimensions = false;
   
 }

   
  //draws tickmarks on each parallel line
  void drawGuidelines( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) 
  {
    float dMin = plotMinD-windowBuffer - 40;
    float eMin = plotMinE+windowBuffer;
    float dMax = plotMaxD-windowBuffer;
    float eMax = plotMaxE+windowBuffer;
    
    stroke(0);
    noFill();
    
    // Draw Guidelines
    for (int i = 1; i <= numOfDimensions; i++ ) 
    {
    
      float y = map( i, 0, numOfDimensions, eMin+115, eMax );
      
          //numbers for axes
          fill(255, 0, 0);


          println(dimensionValues.get(i-1).minValue);
          textSize(12);

  
         for (int j = 1; j <= numOfDimensions; j++)
         {
           float x = map( j, 0, numOfDimensions, dMin, dMax );
           line( x-5, y, x+5, y);
           textAlign(LEFT);
           if(i == 1)
           {
             if(dimensionValues.get(j-1).dimensionName == "GPA")
             {
               text(dfG.format(dimensionValues.get(j-1).minValue), x+10, y+3); //numerical values

             }
             else{
             text(dfY.format(dimensionValues.get(j-1).minValue), x+10, y+3); //numerical values
             }
 
           }
           
           else if(i != numOfDimensions)
           {
             
             if(dimensionValues.get(j-1).dimensionName == "GPA")
             {
               text(dfG.format(dimensionValues.get(j-1).minValue+(((i)*(dimensionValues.get(j-1).maxValue-dimensionValues.get(j-1).minValue)/(numGuidelines+1)))), x+10, y+3);
             }
             
             else
             {
               text(dfY.format(dimensionValues.get(j-1).minValue+(((i)*(dimensionValues.get(j-1).maxValue-dimensionValues.get(j-1).minValue)/(numGuidelines+1)))), x+10, y+3); 
             }  
            }
           
           else if (i == numOfDimensions)
           {
             
             if(dimensionValues.get(j-1).dimensionName == "GPA")
             {
                 text(dfG.format(dimensionValues.get(j-1).maxValue), x+10, y+3); //numerical values
             }
             
             else
             {
               text(dfY.format(dimensionValues.get(j-1).maxValue), x+10, y+3); //numerical values
             }
             
           }
           
         }
    }
    
  }

  //draws axes of graph
  void drawAxes( float plotMinD, float plotMinE, float plotMaxD, float plotMaxE ) 
  {
    
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
  
  //draws each parallel line
  void drawDimensions(float plotMinD, float plotMinE, float plotMaxD, float plotMaxE)
  {
    float dMin = plotMinD-windowBuffer- 25;
    float eMin = plotMinE+windowBuffer;
    float dMax = plotMaxD-windowBuffer - 25;
    float eMax = plotMaxE+windowBuffer;
    
    stroke(150);
    noFill();
    
    
    // Draw vertical dimension lines
    for (int i = 1; i <= numOfDimensions; i++ ) 
    {
      
      float x = map( i, 0, numOfDimensions, dMin, dMax );
 //     float y = map( i, 0, numOfDimensions, eMin, eMax );
      
       strokeWeight(5);
       stroke(0);
       line( x, eMin - 2, x, eMax-windowBuffer );
       line( x-5, eMax - windowBuffer + 5, x, eMax  - windowBuffer);
       line( x, eMax - windowBuffer, x+5, eMax - windowBuffer + 5);
       textAlign(CENTER, CENTER);
       text( dimensionListing.get(i-1), x+3, height - 30 );
       stroke(150);
      
    }
    
    
 
    
  }
  
  //creates interaction button objects
  void dimensionButtons(float plotMinD, float plotMaxD)
  {
     float dMin = plotMinD-windowBuffer;
     float dMax = plotMaxD-windowBuffer;
        //Create button interactions to move dimensions
     interactionButtons.clear();
     for(int i = 1; i <= numOfDimensions-1; i++)
     {

      float x = map( i, 0, numOfDimensions, dMin, dMax );
//      float y = map( i, 0, numOfDimensions, eMin, eMax );
      
      interactionButton newButton = new interactionButton(x+100, height-30, 100, 35, 255, "<--Switch-->", this, dimensionListing.get(i-1), dimensionListing.get(i));
      interactionButtons.add(newButton);
      interactionButtons.get(i-1).draw();
      
     } 
    
    
  }
  
  //function used to determine the closest line in the graph
  void closestLine()
  {
    float smallestDistance = Float.MAX_VALUE;
    int smallestIndex = -1;
    for(int i = 0; i < trendLines.size(); i++)
    {
      //checks each line segment between each dimension, to further improve accuracy
     if (trendLines.get(i).mouseOnLine(trendLines.get(i).trendPoints.get(0).x_value, trendLines.get(i).trendPoints.get(0).y_value, 
             trendLines.get(i).trendPoints.get(1).x_value, trendLines.get(i).trendPoints.get(1).y_value)
         ||  trendLines.get(i).mouseOnLine(trendLines.get(i).trendPoints.get(1).x_value, trendLines.get(i).trendPoints.get(1).y_value, 
             trendLines.get(i).trendPoints.get(2).x_value, trendLines.get(i).trendPoints.get(2).y_value) 
         ||  trendLines.get(i).mouseOnLine(trendLines.get(i).trendPoints.get(2).x_value, trendLines.get(i).trendPoints.get(2).y_value, 
             trendLines.get(i).trendPoints.get(3).x_value, trendLines.get(i).trendPoints.get(3).y_value))
      {
        //calculates distance between each line segment and the current mouse position
        float distance1 = trendLines.get(i).mouseDistance(trendLines.get(i).trendPoints.get(0).x_value, 
                                                          trendLines.get(i).trendPoints.get(0).y_value, 
                                                          trendLines.get(i).trendPoints.get(1).x_value, 
                                                          trendLines.get(i).trendPoints.get(1).y_value);
        float distance2 = trendLines.get(i).mouseDistance(trendLines.get(i).trendPoints.get(1).x_value, 
                                                          trendLines.get(i).trendPoints.get(1).y_value, 
                                                          trendLines.get(i).trendPoints.get(2).x_value, 
                                                          trendLines.get(i).trendPoints.get(2).y_value);
        float distance3 = trendLines.get(i).mouseDistance(trendLines.get(i).trendPoints.get(2).x_value, 
                                                          trendLines.get(i).trendPoints.get(2).y_value, 
                                                          trendLines.get(i).trendPoints.get(3).x_value, 
                                                          trendLines.get(i).trendPoints.get(3).y_value);
        
        //will return index of closest line
        if(distance1 < smallestDistance)
        {
          smallestDistance = distance1;
          smallestIndex = i;
        }
        
        if(distance2 < smallestDistance)
        {
          smallestDistance = distance2;
          smallestIndex = i;
        }
        
        if(distance3 < smallestDistance)
        {
          smallestDistance = distance3;
          smallestIndex = i;
        }

     }
     
    }

    //ensures a closest line has been found  (-1 means no new line found)
    if(selectedLineIndex != -1)
    {
       trendLines.get(selectedLineIndex).selectedLine = false;
    }
    if(smallestIndex != -1)
    {
      
      viewerReference.headerValues.set(0, str(smallestIndex));
      for(int i = 0; i < 4; i++)
      {
        viewerReference.headerValues.set(i+1, tablea.getString(smallestIndex, i)); 
      }
      selectedLineIndex = smallestIndex;
      trendLines.get(selectedLineIndex).selectedLine = true;
      trendLines.get(selectedLineIndex).draw();
  //    println(selectedLineIndex);
  
    }
    
    
  }
  

  void draw() 
  {
    if(tablea == null)
    {
      return;
    }
    
    else
    {
      //sets boundaries of graph
      float plotMinD = d0 + windowBuffer;
      float plotMaxD = d0 + w - windowBuffer;
      float plotMinE = e0 + h - windowBuffer - axesBuffer;
      float plotMaxE = e0 + windowBuffer;
      
      rectMode(CORNERS);
//      fill(205);
//      rect(0, 0, width, height);
      stroke(0); 
      fill(255);
      
      rect (plotMinD-windowBuffer, plotMaxE, plotMaxD, plotMinE+windowBuffer); //border
      drawAxes(plotMinD, plotMinE, plotMaxD, plotMaxE);
      
      if(updatingDimensions == true)
      {
      updateDimensions();
      }
      
      populateDataDimensions();
      drawDimensions(plotMinD-150, plotMinE, plotMaxD-25, plotMaxE+50);
      
      trendLines.clear();
      for(int i = 0; i < tablea.getRowCount(); i++)
      {
        
        TrendLine practiceTrend = new TrendLine(tablea, this, dimensionListing, viewerListing, i);
        trendLines.add(practiceTrend);
        trendLines.get(i).draw();

      }
      
      //creates window elements
      dimensionButtons(plotMinD-150,plotMaxD-25);
      drawGuidelines(plotMinD-150, plotMinE-50, plotMaxD-25, plotMaxE+50);
      closestLine();

            
    }

  }
     
}
 