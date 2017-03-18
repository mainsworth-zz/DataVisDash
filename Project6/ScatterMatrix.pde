
class ScatterMatrix
{
  //object references and initializations
//  interactionButton interaction1 = new interactionButton();
//  interactionButton interaction2 = new interactionButton();
  ElementViewer viewerReference;
  ArrayList<ScatterPlot> scatterArray = new ArrayList<ScatterPlot>();

  ScatterPlot scatterplot = new ScatterPlot();
  ScatterPlot selectedPlot = new ScatterPlot();
  String [] dimensionList = new String[]{"SATM", "SATV", "ACT", "GPA"};
  
  //catalyst variables for moving SPLOM
  int leftMargin = 410;
  int topMargin = 356;
  
  //axes and guidelines variables
  int numGuidelines = 4;
  int tickMarkCount = 8;
  int axesBuffer = 50;
  int windowBuffer = 15;

  //splom variables
  int boxWidth = 75;
  int boxHeight = 75;
  int spaceBetween = 3;
  
  int topLeftX;
  int topLeftY;
  int splomWidth;
  int splomHeight;
  
  int selectedRow = -1;

  //dimensions of graph being used
  String dimension0 = "";
  String dimension1 = "";
  
  void selectGraph(String _dimension0, String _dimension1)
  {
    dimension0 = _dimension0;
    dimension1 = _dimension1;
  }
  
  void initializeGraph(int _topLeftX, int _topLeftY, int _splomWidth, int _splomHeight)
  {
      topLeftX = _topLeftX;
      topLeftY = _topLeftY;
      splomWidth = _splomWidth;
      splomHeight = _splomHeight;
      
  }
  
  void addViewer(ElementViewer reference)
  {
    viewerReference = reference; 
    
  }
  
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
        {  dimension0 = "SATV";  }
      if(dimension1 == "")
        {  dimension1 = "SATM";  }
        

      rectMode(CORNERS);
//      fill(205);
//      rect(0, 0, width, height);
      stroke(0); 
      fill(255);
      
      if(scatterArray.size() != 10)
      {

        for(int i = 0; i < 4; i++)
        {
          for(int j = 0; j <= i; j++)
          {
              ScatterPlot scatterPlotObject = new ScatterPlot();
              scatterPlotObject.initializeGraph(tablea, this, dimensionList[j], dimensionList[i], false);
              scatterPlotObject.setPosition(leftMargin + (boxWidth+spaceBetween)*j, topMargin + boxHeight + (boxHeight+spaceBetween)*i, boxWidth, boxHeight);
              scatterArray.add(scatterPlotObject);
          }
        }
      }

      //initializes main graph
      scatterplot.initializeGraph(tablea, this, dimension0, dimension1, true);
      scatterplot.setPosition(10, height - 410, 400, 400);
      selectedPlot = scatterplot;
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
         
    
       
        
      
      //create buttons
/*      
      //x axis
      rectMode(CENTER);
      interaction1.createButton(axesBuffer+225, height - axesBuffer-150, 75, 30, 255, selectedPlot.dimension0, elementViewerMain, false); 
    
      //y axis
      interaction2.createButton(axesBuffer-15, 200, 30, 75, 255, selectedPlot.dimension1, elementViewerMain, true);
      
      rectMode(CORNERS);
      fill(255);
      rect(width-335, height-200, width-30, height-250);
      fill(0);
      text("Select a scatterplot to be drawn.",  width - 180, height-225);
*/
      
  }
  
  }

}