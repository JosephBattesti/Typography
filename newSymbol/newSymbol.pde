String name="U";
int n=0;
boolean record=true;
boolean recordPoint=false;
boolean recordSpace=false;
Table table;

void setup() {
  background(255);
  size(600, 500);
  stroke(0);
  noFill();
  table = new Table();
  table.addColumn("x");
  table.addColumn("y");
}

void draw() {
 
  if (record){
    
    if(recordPoint){
      savePoint();
      n+=1;
      println("Point"+n);
      recordPoint=false;
      strokeWeight(8);
      point(mouseX,mouseY);
    } 
    
    if(recordSpace){
      
      saveSpace();
      println("space");
      recordSpace=false;

    } 
    
  }
  
  else {
    
    saveTable(table, "letters/"+name+".csv");
    print("Done");
    exit();

    }
    
}  
  
void mouseClicked(){
  if(mouseButton==37){
    recordPoint = true ;
  }
  else{
    recordSpace = true ;
  }
}

void keyPressed(){
   if (key == 'r') {
      record = false ;
    }

}
  

void savePoint(){
  
  // Create a new row
  TableRow row = table.addRow();
  // Set the values of that row
  row.setFloat("x", mouseX);
  row.setFloat("y", mouseY);
  

}

void saveSpace(){
  
  // Create a new row
  TableRow row = table.addRow();
  // Set the values of that row
  row.setFloat("x", 0.0);
  row.setFloat("y", 0.0);
  
}
