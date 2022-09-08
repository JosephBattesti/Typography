class Letter {
  
  PVector[] points;
  
  Letter( PVector[] points) {
    
    this.points=points;
    
  }
  
  void DrawNoisy(float scale,float step,float posx,float posy){
    
      pushMatrix();
      translate(posx,posy);
    
      float noiseoff=3;
      float nscale=10;
      float noisex=posx;
      float noisey=posy;
    
 for (int i=0; i<points.length-1;i+=1){
          

      if (points[i+1].x==0){
        i+=2;
      }
        
      float r = noise(noisex*nscale,noisey*nscale,i*nscale);
      float l = noise((noisex+noiseoff)*nscale,(noisex+noiseoff)*nscale,(i+noiseoff));
      
      float amp=100;
      float offset=map(r,0,1,-amp,amp)*scale;
      float offset2=map(l,0,1,-amp,amp)*scale*0.5;
    
      float x1=points[i].x*scale+offset;
      float y1=points[i].y*scale+offset2;
      float x2=points[i+1].x*scale+offset/2;
      float y2=points[i+1].y*scale+offset2/2;
      
      step=0.01;
      float deformx=map(l,0,1,0.5,2.5);
      float deformy=map(r,0,1,0.5,2.5);
      
      float amp2=50;
      float maxthick=map(r,0,1,5,amp2)*r*scale;
      float minthick=map(r,0,1,5,amp2)*scale;
      
      
  for (float t=0;t<1;t+=step){
    
    strokeWeight(map(t,0,1,minthick,maxthick));
    
    float x=x1*pow((1-t),deformx)+x2*pow((t),deformx);
    float y=y1*pow((1-t),deformy)+y2*pow((t),deformy);
   
   point(x,y);
  }
  
}
  popMatrix();
  }
  
    void Draw(float scale,float step,float deformx,float deformy,float maxthick,float minthick,float posx,float posy){
    
      
    pushMatrix();
    translate(posx,posy);
    
 for (int i=0; i<points.length-1;i+=1){
          

      if (points[i+1].x==0){
        i+=2;
      }
        
    
      float x1=points[i].x*scale;
      float y1=points[i].y*scale;
      float x2=points[i+1].x*scale;
      float y2=points[i+1].y*scale;
      
      
  for (float t=0;t<1;t+=step){
    
    strokeWeight(map(t,0,1,minthick,maxthick));
    
    float x=x1*pow((1-t),deformx)+x2*pow((t),deformx);
    float y=y1*pow((1-t),deformy)+y2*pow((t),deformy);
   
   point(x,y);
  }
  
}
  popMatrix();
  }
  
  // Draws a shape for each segment of a letter. We use a normal vector to the segment, with random amplitude "dist" and oring k. 
  void DrawShape(float scale,float posx,float posy){
    
      pushMatrix();
      translate(posx,posy);
            
    for (int i=0; i<points.length-1;i+=1){
      
      if (points[i+1].x==0){
        i+=2;
      }
      
      PVector vec1=PVector.mult(points[i],scale);
      PVector vec2=PVector.mult(points[i+1],scale);
      // To lists for each side of the segment. 
      ArrayList<PVector> ShapePoints = new ArrayList<PVector>();
      ArrayList<PVector> ShapePoints1 = new ArrayList<PVector>();
      PVector normal = PVector.sub(vec1, vec2).normalize().rotate(PI/2);
      
      // k=0 corresponds to the beging of the segment. k=1 corresponds to the end of the segment
      float k;
      float maxWidth=20;
      int pointNumb=4;
        
      for(float l=0;l<=pointNumb;l+=1){
        float dist=map(noise(t*2,l*10,posy),0,1,0,maxWidth);
        k=l/pointNumb;  
        ShapePoints.add(getNormalPoint(vec1,vec2,normal,k,dist));
        //Get new points for 
        ShapePoints1.add(getNormalPoint(vec1,vec2,normal,1-k,-dist));
        
      }
      
      //Concatenate each side to get a closed shape
      ShapePoints.addAll(ShapePoints1);
      

      beginShape();
      for (PVector p : ShapePoints) {
        point(p.x, p.y);
        vertex(p.x,p.y);
      }
      vertex(ShapePoints.get(0).x,ShapePoints.get(0).y);
      endShape();
    
    }
    
    popMatrix();
  }
  
// Get normal vector and find a point at a certain distance from the segment. Vec1 and Vec2 are the two points defining segment. 
PVector getNormalPoint(PVector vec1,PVector vec2,PVector normal,float k,float dist){
  
      PVector onLine = PVector.add(PVector.mult(vec1,1-k),PVector.mult(vec2,k));
      println(onLine.x,onLine.y);
      PVector newPoint = PVector.add(PVector.mult(normal,dist),onLine);
      
  return newPoint;
  
}
  
}
