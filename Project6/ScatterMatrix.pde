
class ScatterMatrix
{
  // object references and initializations

  ElementViewer viewerReference;  
  ScatterPlot scatterplot = new ScatterPlot();
  ScatterPlot selectedPlot = new ScatterPlot();
  
  ArrayList<ScatterPlot> scatterArray = new ArrayList<ScatterPlot>();

  String [] dimensionList = new String[]{"SATM", "SATV", "ACT", "GPA"};
  
  
  // axes and guidelines variables
  int numGuidelines = 4;
  int tickMarkCount = 8;
  int axesBuffer = 50;
  int windowBuffer = 15;

  // splom variables
  
    // matrix boxes
    int boxWidth = 75;
    int boxHeight = 75;
    int spaceBetween = 3;
    
    //main window box
    int mainBoxWidth = 400;
    int mainBoxHeight = 400;
  
    // dimensions of scatter matrix
    int topLeftX;
    int topLeftY;
    int splomWidth;
    int splomHeight;
  
  // variable to hold currently selected row
  int selectedRow = -1;

  // dimensions of graph being used
  String dimension0 = "";
  String dimension1 = "";
  
  // used in scatter matrix to change main scatterplot's dimensions
  void selectGraph(String _dimension0, String _dimension1)
  {
    dimension0 = _dimension0;
    dimension1 = _dimension1;
  }
  
  // creates graph with given dimensions
  void initializeGraph(int _topLeftX, int _topLeftY, int _splomWidth, int _splomHeight)
  {
      topLeftX = _topLeftX;
      topLeftY = _topLeftY;
      splomWidth = _splomWidth;
      splomHeight = _splomHeight;
      
  }
  
  // adds the element viewer to the graph
  void addViewer(ElementViewer reference)
  {
    viewerReference = reference; 
    
  }
  
  // changes the currently selected row
  void setSelection(int _selectedRow)
  {
     selectedRow = _selectedRow;
    
  }
  
  
  
  void draw()
  {
      if(tablea == null)
      {  return;  }
      
      else
      {
        if(dimension0 == "")
          {  dimension0 = "SATM";  }
        if(dimension1 == "")
          {  dimension1 = "SATV";  }
          
  
        rectMode(CORNERS);
        stroke(0); 
        fill(255);
        
        // ensures there are exactly the number of scatter plot boxes we need for the matrix
        if(scatterArray.size() != 10)
        {
  
          for(int i = 0; i < 4; i++)
          {
            for(int j = 0; j <= i; j++)
            {
                ScatterPlot scatterPlotObject = new ScatterPlot();
                scatterPlotObject.initializeGraph(tablea, this, dimensionList[j], dimensionList[i], false);
                scatterPlotObject.setPosition((topLeftX + mainBoxWidth) + (boxWidth+spaceBetween)*j, topLeftY + 40 + (boxHeight+spaceBetween)*i, boxWidth, boxHeight);
                scatterArray.add(scatterPlotObject);
            }
          }
        }
  
        //initializes main graph
        scatterplot.initializeGraph(tablea, this, dimension0, dimension1, true);
        scatterplot.setPosition(topLeftX, topLeftY, mainBoxWidth, mainBoxHeight);
        selectedPlot = scatterplot;
        
        // if there is no currently selected plot, do nothing.
        if(selectedPlot == null)
        {}
        
        else
        {
          selectedPlot.draw();
          for(int i = 0; i < scatterArray.size(); i++)
          {
           scatterArray.get(i).draw();          
          }
        
        }
      
      }
  
    }

}