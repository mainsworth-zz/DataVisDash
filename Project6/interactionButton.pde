
class interactionButton
{
  //object references
  ElementViewer elementViewerReference;
  
  LineGraph lineReference;
  BarGraph barReference;
  ParallelGraph parallelReference;
  
  //style for the button
  String textPhrase = "";
  
  float xValue1, yValue1, xValue2, yValue2, boxWidth, boxHeight;
  int currentColor, fillColor, fillColorHighlight;
  
  String firstDimension = "";
  String secondDimension = "";
  
  boolean mouseIsOver = false;
  boolean triggerLatch = false;
  boolean mouseCheck = false;
  boolean turnButton = false;
  
  boolean isInteractive = false;
  boolean isViewerButton = false;
  
  //constructor
  interactionButton() {}
  
  
  void createViewerLineButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, boolean _inter, ElementViewer _viewer, LineGraph _graph)
  {
       
//    graphReference = _graphReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    textPhrase = _text;
    
    fillColor = _fill;
    fillColorHighlight = 100;
    

    
    turnButton = _turnButton;
    isInteractive = _inter;
    
    elementViewerReference = _viewer;
    isViewerButton = true;
    
    lineReference = _graph;
  }
  
    void createViewerBarButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, boolean _inter, ElementViewer _viewer, BarGraph _graph)
  {
       
//    graphReference = _graphReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    textPhrase = _text;
    
    fillColor = _fill;
    fillColorHighlight = 100;
    

    
    turnButton = _turnButton;
    isInteractive = _inter;
    
    elementViewerReference = _viewer;
    isViewerButton = true;
    
    barReference = _graph;
  }
  
  void createViewerParallelButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, boolean _inter, ElementViewer _viewer, ParallelGraph _graph)
  {
       
//    graphReference = _graphReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    textPhrase = _text;
    
    fillColor = _fill;
    fillColorHighlight = 100;
    

    
    turnButton = _turnButton;
    isInteractive = _inter;
    
    elementViewerReference = _viewer;
    isViewerButton = true;
    
    parallelReference = _graph;
  }
  
  void createBarButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, boolean _inter, BarGraph _graph, ElementViewer _viewer)
  {
       
//    graphReference = _graphReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    textPhrase = _text;
    
    fillColor = _fill;
    fillColorHighlight = 100;
    

    
    turnButton = _turnButton;
    isInteractive = _inter;
    
    barReference = _graph;
    elementViewerReference = _viewer;
    
  }
  
    void createLineButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, boolean _inter, LineGraph _graph, ElementViewer _viewer)
  {
       
//    graphReference = _graphReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    textPhrase = _text;
    
    fillColor = _fill;
    fillColorHighlight = 100;
    

    
    turnButton = _turnButton;
    isInteractive = _inter;
    
    lineReference = _graph;
    elementViewerReference = _viewer;
  }
  
    void createPCPButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, boolean _inter, ParallelGraph _graph, ElementViewer _viewer)
  {
       
//    graphReference = _graphReference;
    
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    textPhrase = _text;
    
    fillColor = _fill;
    fillColorHighlight = 100;
    

    
    turnButton = _turnButton;
    isInteractive = _inter;
    
    parallelReference = _graph;
    elementViewerReference = _viewer;
  }
  
  void setDimensions(String _dimOne, String _dimTwo)
  {
    firstDimension = _dimOne;
    secondDimension = _dimTwo;
  }
 
  
  //listener function
  void highlightButton()
  {
  if (overRect() && isInteractive)
    {
      fill(fillColorHighlight);
    
     if(mousePressed == true)
      {
        
        if(isViewerButton)
        {
          if(lineReference != null)
          {
             elementViewerReference.showSelectionMenu = false;
//             elementViewerReference.createInfoRows();
             lineReference.dimension0 = textPhrase;
             lineReference.reinitializeGraph();
             
             
          }
          
          else if (barReference != null)
          {
             elementViewerReference.showSelectionMenu = false;
             barReference.dimension0 = textPhrase; 
             barReference.reinitializeGraph();

          }
          
          else if (parallelReference != null)
          {
            elementViewerReference.showSelectionMenu = false; 
            
          }
         
          
       }
       else
       {
         if(lineReference != null) // button belongs to line graph
          {
            elementViewerReference.showSelectionMenu = true;
            elementViewerReference.lineReference = lineReference;
          }
          
          else if (barReference != null)
          {
            elementViewerReference.showSelectionMenu = true;
            elementViewerReference.barReference = barReference;
          }
          
          else if (parallelReference != null)
          {
            elementViewerReference.showSelectionMenu = true;
            elementViewerReference.parallelReference = parallelReference;
          }
       }
         
        
      }
        
    }
    
    else
      {
        fill(fillColor);
      }
      
      //redraws object

//      fill(255);
      rectMode(CENTER);
      rect(xValue1, yValue1, boxWidth, boxHeight);
      rectMode(CORNER);

     
    if(turnButton)
    {
      pushMatrix();
      translate(xValue1,yValue1);
      rotate(-HALF_PI);
      translate(-xValue1, -yValue1);
      fill(0);
      textSize(18);
      text(textPhrase, xValue1, yValue1);
      popMatrix();
    }
    else
    {
      textSize(18);
      textAlign(CENTER, CENTER);
      fill(0);
      text(textPhrase, xValue1, yValue1); 
      textSize(12);
    }
    
    fill(0);
  }

   
    
    
  
  //listener function to detect mouse interaction
  boolean overRect()  
  {

    if (mouseX >= (xValue1 - (boxWidth/2)) && mouseX <= xValue1+(boxWidth/2) && 
        mouseY >= (yValue1 - (boxHeight/2)) && mouseY <= yValue1+(boxHeight/2)) 
        {
        return true;} 
    else 
    {return false;}
    
  }
  
  //draws object
  void draw()
  {
    
//    fill(fillColor);
    rectMode(CENTER);
    rect(xValue1, yValue1, boxWidth, boxHeight);
    rectMode(CORNER);
    textSize(24);
    textAlign(CENTER, CENTER);
    
    if(turnButton)
    {
      pushMatrix();
      translate(xValue1,yValue1);
      rotate(-HALF_PI);
      translate(-xValue1, -yValue1);
      fill(0);
      textSize(18);
      text(textPhrase, xValue1, yValue1);
      popMatrix();
    }
    
    else
    {
      fill(0);
      text(textPhrase, xValue1, yValue1);
      fill(255);
    
    }
    textSize(12);
    highlightButton();
  }
  
  
}



 
 
 