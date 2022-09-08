class Letter {
  
  PVector[] points;
  
  Letter( PVector[] points) {
    
    this.points=points;
    
  }
  
  void DrawNoisy(float scale,float step,float noisex,float noisey){
    
      float noiseoff=3;
      float nscale=10;
    
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
  
  }
  
    void Draw(float scale,float step,float deformx,float deformy,float maxthick,float minthick){
    
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
  
  }
  
}
