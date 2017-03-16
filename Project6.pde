/**********************************************
* Name: Matthew Ainsworth                     *
* Class: Data Visualization - CIS4930         *
* Assignment: Project 5                       *
***********************************************/
import java.text.DecimalFormat;

//object references
Table tablea;
ParallelGraph parallelGraph = new ParallelGraph();
ElementViewer elementViewerMain = new ElementViewer();

void setup() {
 size(800,400);
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
    
    //draws element viewer
    elementViewerMain.createViewer(width - 130, 10,  width - 20, height - 100, tablea);
    elementViewerMain.draw();
    
    //draws parallel coordinates graph
    parallelGraph.initializeGraph(tablea, elementViewerMain);
    parallelGraph.setPosition(5, 0, width - 150, height -10);
    parallelGraph.draw();

  
  }
}