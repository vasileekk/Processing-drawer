PImage img;
void settings() {
  img = loadImage("1.png");
  if(img!=null){
    size(img.width, img.height);
  }
  else{
    size(1600, 900);    
  }
}

void setup(){
  strokeWeight(5);
}

// vertex-curvevertex-rect-ellipse
int inputType = 5;
int selected = 0;

color defFill = color(200);
color defStroke = color(50);
color selFill = defFill;
color selStroke = defStroke;

ArrayList<Shp> arr = new ArrayList<Shp>();

void draw() {
  clear();
  background(240);
  if (img != null )
  {
    image(img, 0, 0);
  }
  stroke(selStroke);
  fill(selFill);
  square(width-110,10, 100);
  
  fill(100);
  textSize(36);
  String st = " ";
  switch(inputType){
    case 1:
      st = "vertex";
      break;
    case 2:
      st = "curveVertex";
      break;
    case 3:
      st = "rect";
      break;
    case 4:
      st = "ellipse";
      break;
    case 5:
      st = "Color Selection";
      break;
  }
  text(st, 20, 40);
  stroke(50);
  fill(200);
  if(selected != arr.size() && arr.size()>0){
    arr.get(arr.size()-1).aim(mouseX, mouseY);
  }
  
  for (int i = 0; i < arr.size(); i++){
    if(selected!=i)arr.get(i).draw();
  }
}

void keyReleased(){
  switch(key){
      case 's':
        save();
        break;
      case 'z':
        deleteLast();
        break;
      case 'r':
        resetColors();
        break;
      case 'e':
        selectInput("Select a image:", "fileSelected");
        break;
      case 'w':
        selectInput("Select a image:", "fileSelected");
        changeImgScale();
        break;  
      case ENTER:
        if((inputType == 1 || inputType == 2) && selected != arr.size()){
          if(inputType == 2)arr.get(arr.size()-1).addP(mouseX, mouseY);
          selected++;
        }
        break;
      case '1':
        if(selected == arr.size()) inputType = 1;
        break;
      case '2':
        if(selected == arr.size()) inputType = 2;
        break;
      case '3':
        if(selected == arr.size()) inputType = 3;
        break;
      case '4':
        if(selected == arr.size()) inputType = 4;
        break;
      case '5':
        if(selected == arr.size()) inputType = 5;
        break;
  }
}

void mousePressed(){
  if(inputType == 5){
    loadPixels();
    if(mouseButton == LEFT){
      selFill = pixels[mouseX+mouseY*pixelWidth];
    }
    else if(mouseButton == RIGHT){
      selStroke = pixels[mouseX+mouseY*pixelWidth];
    }
  }
  else{
    if(selected == arr.size()){
     Shp s = new Shp(inputType, mouseX, mouseY, selFill, selStroke);
     arr.add(s);
    }
    else{
     arr.get(arr.size()-1).addP(mouseX, mouseY);
     if(inputType!= 1 && inputType!= 2)selected++;   
    }
  }
}

void deleteLast(){
  if(arr.size() > 0 && selected == arr.size()){
   arr.remove(arr.size() - 1);
   selected--;
  }
}

void resetColors(){
 selFill = defFill; 
 selStroke = defStroke;
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Something went wrong");
  } else {
    img = loadImage(selection.getAbsolutePath());
  }
}

void changeImgScale(){
  if(img.width>width){
   img.resize(width, 0);
  }
  if(img.height > height){
   img.resize(0, height);
  }
  
}

void save(){
  ArrayList<String> out = new ArrayList<String>();
  for(int i = 0; i < arr.size(); i++){
    out.add("fill("+red(arr.get(i).fl)+", "+green(arr.get(i).fl)+", "+blue(arr.get(i).fl)+");");
    out.add("stroke("+red(arr.get(i).str)+", "+green(arr.get(i).str)+", "+blue(arr.get(i).str)+");");
    // vertex-curvevertex-rect-ellipse
    switch(arr.get(i).type){
      case 1:
        out.add("beginShape();");
        for(int j = 0; j < arr.get(i).pts.size(); j++){
          out.add("vertex("+arr.get(i).pts.get(j).x+", "+arr.get(i).pts.get(j).y+");");
        }
        out.add("endShape();");
        break;
      case 2:
        out.add("beginShape();");
        for(int j = 0; j < arr.get(i).pts.size(); j++){
          out.add("curveVertex("+arr.get(i).pts.get(j).x+", "+arr.get(i).pts.get(j).y+");");
        }
        out.add("endShape();");
        break;
      case 3:
        out.add("rect(" + arr.get(i).pts.get(0).x + ", " + arr.get(i).pts.get(0).y + ", " + (arr.get(i).pts.get(1).x - arr.get(i).pts.get(0).x) + ", " + (arr.get(i).pts.get(1).y - arr.get(i).pts.get(0).y) + ");");
        break;
      case 4:
        int x1 = (arr.get(i).pts.get(0).x + arr.get(i).pts.get(1).x)/2;
        int y1 = (arr.get(i).pts.get(0).y + arr.get(i).pts.get(1).y)/2;
        out.add("ellipse(" + x1 + ", " + y1 + ", " + (arr.get(i).pts.get(1).x - arr.get(i).pts.get(0).x) + ", " + (arr.get(i).pts.get(1).y - arr.get(i).pts.get(0).y) + ");");
        break;
      default:
        out.add("\n//Something went wrong here\n");
    }
    out.add("\n");
  }
  String output[] = new String[out.size()];
  for(int i = 0; i < out.size(); i++){
    output[i] = out.get(i);
  }
  
  saveStrings("output.txt", output);
}
