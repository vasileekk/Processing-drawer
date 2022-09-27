class Shp{
  // vertex-curvevertex-rect-ellipse
  int type;
  color str;
  color fl;
  class Pt{
   int x, y;
   Pt(int x1, int y1){
    x = x1;
    y = y1;
   }
  }
  ArrayList<Pt> pts;
  
  Shp(int t, int x, int y, color f, color s){
    fl = f;
    str = s;
    type = t;
    Pt p = new Pt(x, y);
    pts = new ArrayList<Pt>();
    pts.add(p);
  }
  
  void addP(int x, int y){
    Pt p = new Pt(x, y);
    pts.add(p);
  }
  
  void aim(int x, int y){
    stroke(str);
    fill(fl);
    switch(type){
      case 1:
      beginShape();
      for (int i = 0; i < pts.size(); i++){
         vertex(pts.get(i).x, pts.get(i).y);
      }
      vertex(x, y);
      endShape();
        break;
        
      case 2:
      beginShape();
      for (int i = 0; i < pts.size(); i++){
         curveVertex(pts.get(i).x, pts.get(i).y);
      }
      curveVertex(x, y);
      endShape();
        break;
        
      case 3:
      rect(pts.get(0).x, pts.get(0).y, x - pts.get(0).x, y - pts.get(0).y);
        break;
        
      case 4:
      int x1 = (pts.get(0).x + x)/2;
      int y1 = (pts.get(0).y + y)/2;
      ellipse(x1, y1, x - pts.get(0).x, y - pts.get(0).y);
        break;
        
    }
  }
  
  void draw(){
    stroke(str);
    fill(fl);
    
    switch(type){
      case 1:
      beginShape();
      for (int i = 0; i < pts.size(); i++){
         vertex(pts.get(i).x, pts.get(i).y);
      }
      endShape();
        break;
        
      case 2:
      beginShape();
      for (int i = 0; i < pts.size(); i++){
         curveVertex(pts.get(i).x, pts.get(i).y);
      }
      endShape();
        break;
        
      case 3:
      rect(pts.get(0).x, pts.get(0).y, pts.get(1).x - pts.get(0).x, pts.get(1).y - pts.get(0).y);
        break;
        
      case 4:
      int x1 = (pts.get(0).x + pts.get(1).x)/2;
      int y1 = (pts.get(0).y + pts.get(1).y)/2;
      ellipse(x1, y1, pts.get(1).x - pts.get(0).x, pts.get(1).y - pts.get(0).y);
        break;
        
    }
  }
}
