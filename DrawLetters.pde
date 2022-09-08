boolean record;
boolean recordPoint;
float step=0.001;
float t=0;
float tstep=0.05;
Table table;
int counter=0;
String [] letters={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
ArrayList<Letter> Alphabet = new ArrayList<Letter>();


import processing.svg.*;


public void settings()
  {  
     System.setProperty("jogl.disable.openglcore", "false");
  size(1200, 1000);
  }

void setup() {
  size(1200, 1000);
  stroke(255);
  background(0,0,0,0);
  frameRate(20);
  for(String c : letters){
    Letter temp=new Letter(loadData(c));
    Alphabet.add(temp);
  }
}

void draw() {
  // Transparent Background  
  fill(0,0,0,50);
  rect(0,0,width+20,height+20);
  noFill();
   
  if (record) {
    beginRecord(SVG, "output" + millis() + ".svg");
  }
  
 
  
  ////NoiseDance
  //float scale=0.05;
  //float amount=15;
  //float nfreq=0.002;
  //noiseDance(scale,amount,nfreq);
  
  
  ////Draw Word
  //for (int i=0;i<10;i+=1){
  //pushMatrix();
  //float y=100*i;
  //float spacex=100;
  //translate(0,y);
  //DrawWord("Arnaud",scale,spacex,y);
  //popMatrix();
  //}
  
  if (record) {
    endRecord();
    record = false;
    println("SVG file saved");
  }
  t+=tstep;
}


void DrawWord(String Word,float scale,float spacex,float y){
  Word=Word.toUpperCase();
  for (int i=0;i<Word.length();i+=1){
    pushMatrix();
    translate(spacex*i,0);
    Letter letter=new Letter(loadData(str(Word.charAt(i))));
    letter.DrawNoisy(scale,step,i,y);
    popMatrix();
  }
}

void noiseDance(float scale,float amount,float nfreq){

  float amptemp=50;
  for (int j=0;j<amount;j+=1){
    for(int k=0;k<amount;k+=1){
    
    float x=map(j,0,amount,0,width)+map(random(1),0,1,-amptemp,amptemp);
    float y=map(k,0,amount,0,height)+map(random(1),0,1,-amptemp,amptemp);
    float n=noise(x*nfreq,y*nfreq,t);
    pushMatrix();
    translate(x,y);
    int p = (int) random(letters.length);
     
    if(n<0.3){
      //DrawLetter(points,scale,j,k);
       Alphabet.get(p).DrawNoisy(scale,step,x,y);
    
    }
    
    popMatrix();
    }
  }
}


PVector[] loadData(String letter) {
  // Load CSV file into a Table object
  // "header" option indicates the file has a header row
  table = loadTable("/newSymbol/letters/"+letter+".csv", "header");
  
  // The size of the array of Bubble objects is determined by the total number of rows in the CSV
  PVector[] points = new PVector[table.getRowCount()];
  
  // You can access iterate over all the rows in a table
  int rowCount = 0;
  for (TableRow row : table.rows()) {
    // You can access the fields via their column name (or index)
    float x = row.getFloat("x");
    float y = row.getFloat("y");
     
    points[rowCount] = new PVector();
    points[rowCount].x=x;
    points[rowCount].y=y;
    rowCount++;
  }
  
  return points;
}

void saveFrames(){
  counter+=1;
  saveFrame("output/gif-"+nf(counter, 3)+".png");
  if(counter>100){
    exit();
  }
}


void keyPressed() {

  if (key == 'r') {
    record = true ;
  }
    
}
  
void mouseClicked(){
  recordPoint = true ;
}
