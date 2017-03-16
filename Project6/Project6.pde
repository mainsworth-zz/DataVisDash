/**********************************************
* Name: Matthew Ainsworth                     *
* Class: Data Visualization - CIS4930         *
* Assignment: Project 5                       *
***********************************************/
import java.text.DecimalFormat;

//object references
Table tablea;
ParallelGraph parallelGraph = new ParallelGraph();
ScatterMatrix scatterMatrix = new ScatterMatrix();
ElementViewer elementViewerMain = new ElementViewer();

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
    
    //draws element viewer
    elementViewerMain.createViewer(width - 130, 10,  width - 20, height - 400, tablea);
    elementViewerMain.draw();
    
    //draws scatterplot matrix
    scatterMatrix.draw();
    
    //draws parallel coordinates graph
//    parallelGraph.initializeGraph(tablea, elementViewerMain);
//    parallelGraph.setPosition(width - 340, 10, 200, 100);
//    parallelGraph.draw();



  
  }
}