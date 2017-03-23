/**********************************************
* Name: Matthew Ainsworth                     *
* Class: Data Visualization - CIS4930         *
* Assignment: Project 6                       *
***********************************************/
import java.text.DecimalFormat;

//object references
Table tablea;
ParallelGraph parallelGraph = new ParallelGraph();
ScatterMatrix scatterMatrix = new ScatterMatrix();
ElementViewer elementViewerMain = new ElementViewer();
BarGraph barGraph = new BarGraph();
LineGraph lineGraph = new LineGraph();

int selectedRow = -1;


void setup() {
 size(1200,800);
 background(255);
 textSize(14);
 smooth();
  selectInput("Select a file to process:", "fileSelected");
  

}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    tablea = loadTable(selection.getAbsolutePath(), "header");
  }
  
}





void draw() {
 if (tablea == null)
    { return; }
 else
  { 
    rectMode(CORNERS);
    fill(205);
    rect(0, 0, width, height);
    fill(255);
    //draws element viewer
    elementViewerMain.createViewer(width - 130, 10,  width - 20, height - 400, tablea);
    elementViewerMain.draw();
    
    //draws scatterplot matrix
    scatterMatrix.initializeGraph(0, height-410, 500, 500);
    scatterMatrix.addViewer(elementViewerMain);
    scatterMatrix.draw();
    
    if(selectedRow != -1)
    {
      scatterMatrix.setSelection(selectedRow);
    }
    
    //draws parallel coordinates graph
    parallelGraph.initializeGraph(tablea, elementViewerMain);
    parallelGraph.setPosition(50, 10, 500, 200);
    parallelGraph.draw();
    
    
    //draws bar graph
    barGraph.initializeGraph(tablea, elementViewerMain);
    barGraph.setPosition(685, 25, 300, 300);
    barGraph.draw();
    
    //draws line graph
    lineGraph.initializeGraph(tablea, elementViewerMain);
    lineGraph.setPosition(width - 350, height - 380, 300, 300);
    lineGraph.draw();


  
  }
}