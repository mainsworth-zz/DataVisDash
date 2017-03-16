
class ElementViewer
{
  //object references
  ParallelGraph graphReference;
  ArrayList<interactionButton> buttonCollection = new ArrayList<interactionButton>();
  Table dataTable;
    
  String [] headerNames = new String []{"GPA", "ACT", "SATV", "SATM", "Element Number"};
  StringList headerValues = new StringList();
  
  float topLeftX, topLeftY, bottomRightX, bottomRightY, viewerWidth, viewerHeight;
  int fillColor, columnCount;

  boolean showSelectionMenu = false;

  ElementViewer() {}
  
  //creates a new relement viewer
  void createViewer(float _tLX, float _tLY, float _bRX, float _bRY, Table _table)
  {
    dataTable = _table;
    
    
    topLeftX = _tLX;
    topLeftY = _tLY; 
    bottomRightX = _bRX; 
    bottomRightY = _bRY;
    viewerWidth = (topLeftX - bottomRightX);
    viewerHeight = (bottomRightY - topLeftY); 
    
  }
  
  void draw()
  {
    
    rectMode(CORNERS);
    fill(255);
    rect(topLeftX, topLeftY, bottomRightX, bottomRightY);
    createInfoRows();
  }
  
  //clears current contents of viewer

  //initializes interaction for showing data of a trendline
  void createInfoRows()
  {
      for(int i=0; i < dataTable.getColumnCount()+1; i++)
      {
        float y = map( i, 0, dataTable.getColumnCount()+1, bottomRightY, topLeftY );
  
        line( topLeftX, y, bottomRightX, y );
        fill(0);
        
        textAlign(CENTER, CENTER);
        textSize(12);
        text(headerNames[i], bottomRightX + viewerWidth+55, y-60);
        
        if(headerValues.size() == 5)
        {
        textSize(12);
        text(headerValues.get(i), bottomRightX + viewerWidth+55, y-20);
        textSize(12);
        }
      }
    
   
      
  }
  
   
}
  
  