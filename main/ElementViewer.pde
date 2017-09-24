
class ElementViewer
{
  
  //object references
  Table dataTable;
  BarGraph barReference;
  LineGraph lineReference; 
  ParallelGraph parallelReference;
   
  ArrayList<interactionButton> buttonCollection = new ArrayList<interactionButton>();  
  StringList headerValues = new StringList();
  
  String [] headerNames = new String []{"GPA", "ACT", "SATV", "SATM", "Element Number"};
  
  // variable to keep track of currently selected row
  int selectionRow = -1;
  
  // properties of the element viewer
  int fillColor, columnCount;
  float topLeftX, topLeftY, bottomRightX, bottomRightY, viewerWidth, viewerHeight;

  boolean showSelectionMenu = false;

  // constructor
  ElementViewer() {}
  
  
  // creates a new relement viewer
  void createViewer(float _tLX, float _tLY, float _bRX, float _bRY, Table _table)
  {
    
    dataTable = _table;
    
    // sets dimensions of viewer
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
    viewerWidth = (bottomRightX - topLeftX);
    viewerHeight = (bottomRightY - topLeftY); 
    
  }
  
  void draw()
  {
    
    rectMode(CORNERS);
    fill(255);
    rect(topLeftX, topLeftY, bottomRightX, bottomRightY);
    createInfoRows();
  }
  

  //initializes interaction for showing data of a trendline
  void createInfoRows()
  {
    
      // normal viewing
      if(!showSelectionMenu)
      {
        //clears references, so new ones can be made later for interactions
        
        lineReference = null;
        barReference = null; 
        parallelReference = null;
        
        if(buttonCollection.size() != 0)
        {
          buttonCollection.clear();
        }
        
        for(int i=0; i < dataTable.getColumnCount()+1; i++)
        {
          
          float y = map( i, 0, dataTable.getColumnCount()+1, bottomRightY, topLeftY );
    
          line( topLeftX, y, bottomRightX, y );
          
          fill(0);
          textAlign(CENTER, CENTER);
          textSize(12);
          
          text(headerNames[i], bottomRightX - viewerWidth+55, y-60);
          
          if(headerValues.size() == 5)
          {
            textSize(12);
            text(headerValues.get(i), bottomRightX - viewerWidth+55, y-20);
            textSize(12);
          }
          
        }
        
      }
      
      // if an interaction button has been clicked on
      else if (showSelectionMenu)
      {
      
        for(int i=0; i < dataTable.getColumnCount(); i++)
          {
            float y = map( i, 0, dataTable.getColumnCount(), bottomRightY - 48, topLeftY - 48 );
            
            rectMode(CORNERS);
            fill(255,0,0);
            
            if(buttonCollection.size()!= tablea.getColumnCount())
            {
              
              //interacting with line graph
              if(lineReference != null)
              {
                interactionButton interactionNewButton = new interactionButton();
                interactionNewButton.createViewerLineButton((topLeftX+bottomRightX)/2, y, viewerWidth, viewerHeight/dataTable.getColumnCount(), 255, headerNames[i], false, true, this, lineReference);
                buttonCollection.add(interactionNewButton);
              }
              
              else if (barReference != null)
              {
                interactionButton interactionNewButton = new interactionButton();
                interactionNewButton.createViewerBarButton((topLeftX+bottomRightX)/2, y, viewerWidth, viewerHeight/dataTable.getColumnCount(), 255, headerNames[i], false, true, this, barReference);
                buttonCollection.add(interactionNewButton); 
              }
              
              else if (parallelReference != null)
              {
                interactionButton interactionNewButton = new interactionButton();
                interactionNewButton.createViewerParallelButton((topLeftX+bottomRightX)/2, y, viewerWidth, viewerHeight/dataTable.getColumnCount(), 255, headerNames[i], false, true, this, parallelReference);
                buttonCollection.add(interactionNewButton); 
              }

            }
            
            else
            {
              buttonCollection.get(i).draw();
            }
            
            text(headerNames[i], bottomRightX + viewerWidth+55, y-65);
  
          }
    
      }
      
  }
  
  // called when a new row has been selected
  void updateInfoRows(StringList _headers)
  {
      for(int i = 0; i < _headers.size(); i++)
      {
        headerValues.set(i, _headers.get(i)); 
      }
    
  }
 
   
}
  
  