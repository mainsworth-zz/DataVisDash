
// object for dashboard to interact with graphs

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
  
  // dimensions relating to the button interaction
  String firstDimension = "";
  String secondDimension = "";
  
  // flags to determine the exact interactivity of the button
  boolean mouseIsOver = false;
  boolean triggerLatch = false;
  
  boolean mouseCheck = false;
  boolean turnButton = false;
 
  boolean isInteractive = false;
  boolean isViewerButton = false;
  
  //constructor
  interactionButton() {}
  
  
  // used when button relates to Line Graph
  void createViewerLineButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, 
                              boolean _inter, ElementViewer _viewer, LineGraph _graph)
  {
    
    // object references
    elementViewerReference = _viewer;
    lineReference = _graph;
    
    // set physical dimensions of button
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    // text associated with button
    textPhrase = _text;
    
    // color associated
    fillColor = _fill;
    fillColorHighlight = 100;
   
    // flag to determine if the button needs to be turned
    turnButton = _turnButton;
    
    // flag to determine if button is interactive
    isInteractive = _inter;
    
    // flag to determine if the button is built on the viewer
    isViewerButton = true;

  }
  
  // conastructor for when button is related to Bar Graph
  void createViewerBarButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, 
                             boolean _inter, ElementViewer _viewer, BarGraph _graph)
  {
    
    elementViewerReference = _viewer;
    barReference = _graph;
    
    // dimensions of button
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    // text associated with button
    textPhrase = _text;
    
    // color associated
    fillColor = _fill;
    fillColorHighlight = 100;
    

    // flag to determine if button needs to be adjusted
    turnButton = _turnButton;
    
    // flag to determine if button is interactive
    isInteractive = _inter;

    // flag to determine if button is built on viewer
    isViewerButton = true;
    

  }
  
  void createViewerParallelButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, boolean _inter, ElementViewer _viewer, ParallelGraph _graph)
  {
    // object references
    elementViewerReference = _viewer;
    parallelReference = _graph;
    
    // dimensions of button
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    // text of button
    textPhrase = _text;
    
    // color of button
    fillColor = _fill;
    fillColorHighlight = 100;
    

    // flag to rotate button if needed
    turnButton = _turnButton;
    
    // flag to make interactive
    isInteractive = _inter;
    
    // flag relating button to element viewer
    isViewerButton = true;
    

  }
  
  // creates button associated with bar graph
  void createBarButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, 
                       boolean _inter, BarGraph _graph, ElementViewer _viewer)
  {
    
    // object references
    barReference = _graph;
    elementViewerReference = _viewer;
    
    // dimensions of button
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    // text of button
    textPhrase = _text;
    
    // color of button
    fillColor = _fill;
    fillColorHighlight = 100;
   
    // flag to rotate button, if needed
    turnButton = _turnButton;
    
    // flag to make button interactive
    isInteractive = _inter;

  
  }
  
  // create button associated with line graph
  void createLineButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, 
                        boolean _inter, LineGraph _graph, ElementViewer _viewer)
  {
    
    // object references
    lineReference = _graph;
    elementViewerReference = _viewer;
    
    // dimensions of button
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    // text of button
    textPhrase = _text;
    
    // color of button
    fillColor = _fill;
    fillColorHighlight = 100;
    
    // flag to rotate button, if needed
    turnButton = _turnButton;
    
    // flag to make button interactive
    isInteractive = _inter;

  }
  
  // create button associated with PCP graph
  void createPCPButton(float _x1, float _y1, float _x2, float _y2, int _fill, String _text, boolean _turnButton, 
                       boolean _inter, ParallelGraph _graph, ElementViewer _viewer)
  {
    
    // object references
    parallelReference = _graph;
    elementViewerReference = _viewer;
    
    // dimensions of button
    xValue1 = _x1;
    yValue1 = _y1;
    boxWidth = _x2;
    boxHeight = _y2;
    
    // text of button 
    textPhrase = _text;
    
    // color of button
    fillColor = _fill;
    fillColorHighlight = 100;
      
    // flag to rotate button if needed
    turnButton = _turnButton;
    
    // flag to make button interactive
    isInteractive = _inter;
    
  
  }
 
  // sets dimensions relating button, if needed
  void setDimensions(String _dimOne, String _dimTwo)
  {
    firstDimension = _dimOne;
    secondDimension = _dimTwo;
  }
 
  
  //listener function to determine if the mouse pointer is over button
  void highlightButton()
  {
    // if the mouse is over an interactive button
    if (overRect() && isInteractive)
    {
       // change color to show user it is interactive  
       fill(fillColorHighlight);
    
       // if mouse was pressed
       if(mousePressed == true)
       {
        
        // button is on the element viewer
        if(isViewerButton)
        {
          
          // line graph button
          if(lineReference != null)
          {
             elementViewerReference.showSelectionMenu = false;
             lineReference.dimension0 = textPhrase;
             lineReference.reinitializeGraph();
             
             
          }
          
          // bar graph button
          else if (barReference != null)
          {
             elementViewerReference.showSelectionMenu = false;
             barReference.dimension0 = textPhrase; 
             barReference.reinitializeGraph();

          }
          
          // pcp button
          else if (parallelReference != null)
          {
            elementViewerReference.showSelectionMenu = false; 
            
          }
         
          
       } // end (is viewer) check
       
       
       else // if the button is on the dashboard
       {
         
         if(lineReference != null) // button belongs to line graph
          {
            elementViewerReference.showSelectionMenu = true;
            elementViewerReference.lineReference = lineReference;
          }
          
          else if (barReference != null) // belongs to bar graph
          {
            elementViewerReference.showSelectionMenu = true;
            elementViewerReference.barReference = barReference;
          }
          
          else if (parallelReference != null) // belongs to pcp graph
          {
            elementViewerReference.showSelectionMenu = true;
            elementViewerReference.parallelReference = parallelReference;
          }
       }
         
        
      }
        
    }
    
    // if mouse pointer is not over button
    else
      {
        fill(fillColor);
      }
      
      //redraws object
      rectMode(CENTER);
      rect(xValue1, yValue1, boxWidth, boxHeight);
      rectMode(CORNER);

    // if button needs to be rotated on y-axis
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
    
    // button drawn on x-axis
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
  
  
} // definition ends



 
 
 