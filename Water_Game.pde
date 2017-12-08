
ArrayList <Particula> Particulas;
int num;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
PImage c1;
PImage wg;
int pantalla = 0;
import processing.sound.*;
SoundFile file;



Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<Box> boxes;

void setup() {
  size(640,360);
  file = new SoundFile(this, "p1.mp3");
  file.play();
  c1 = loadImage("1.png");
  wg = loadImage("2.png");
  Particulas = new ArrayList <Particula>();
  for(int i=0; i<200;i++){
    Particulas.add(new Particula());
  
  }
  smooth();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
    boundaries.add(new Boundary(3,0,1500,50));
     boundaries.add(new Boundary(3,0,1500,50));
  boundaries.add(new Boundary(320,200,250,2));
  boundaries.add(new Boundary(186,190,20,20));
   boundaries.add(new Boundary(454,190,20,20));
    boundaries.add(new Boundary(370,148,20,20));
    boundaries.add(new Boundary(290,128,20,20));
  boundaries.add(new Boundary(width/4,height-30,180,10));
  boundaries.add(new Boundary(3*width/4,height-5,width/2-100,10));
  boundaries.add(new Boundary(width-5,height/2,10,height));
  boundaries.add(new Boundary(5,height/2,10,height));

}

void draw() {
  switch(pantalla){
  case 0:
  inicio();
  break;
  
  case 1:
  juego();
  break;
  
  }
}
void inicio(){
background(random(255),random(255),random(255));
image(wg,0,0);
if(mousePressed){
pantalla=1;
  }
}
//-------------------------------------------------------------------------------

void juego(){
   background(0,80,230);
  image(c1,196,117);
  fill(255);
  text("Preciona E/e Para salir",30,70);
  fill(255);
  text("Preciona R/r Para regresar al inicio",440,70);
  
//___________________________________________________________________________________________________________________________________________________________________  



  // We must always step through time!
  box2d.step();

  // When the mouse is clicked, add a new Box object
  if (random(6) < 0.1) {
    Box p = new Box(random(width),300);
    boxes.add(p);
  }
  
  if (keyPressed) {
    if((key == 'n' || key == 'N' )){
    for (Box b: boxes) {
     Vec2 wind = new Vec2(0,380);
     b.applyForce(wind);
    }
  }
  }
  //_________________________________________________________
  if (keyPressed) {
    if((key == 'l' || key == 'L' )){
    for (Box b: boxes) {
     Vec2 wind = new Vec2(80,0);
     b.applyForce(wind);
    }
  }
  }
  //_________________________________________________________
  if (keyPressed) {
    if((key == 'a' || key == 'A' )){
    for (Box b: boxes) {
     Vec2 wind = new Vec2(-80,0);
     b.applyForce(wind);
    }
  }
  }
  //__________________________________________________________
  if (keyPressed) {
    if((key == 'e' || key == 'E' )){
    exit();
    }
  }
  //__________________________________________________________
   if (keyPressed) {
    if((key == 'r' || key == 'R' )){
    pantalla = 0;
    }
  }
  
  
  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  for(Particula p: Particulas) {
  p.Dibujar();
  p.Mover();
  }
   
}

class Particula{
  int ancho;
  int alto;
  int r,g,b;
  float px, py;
  int velocidad;
  float direccion; //angulo 0 - TWO_PI;
  
  Particula(int ancho_, int alto_, int r_, int g_, int b_, float px_, float py_, int velocidad_, float direccion_){
    ancho= ancho_;
    alto= alto_;
    r= r_;
    g= g_;
    b= b_;
    px= px_;
    py= py_;
    velocidad= velocidad_;
    direccion= direccion_;
  }
  Particula(){
    ancho = int(random(30));
    alto = ancho;
    r= int (random(110));
    g= int (random(242));
    b= int (random(203));
    velocidad= 1 + int(random(2));
    direccion = random(TWO_PI);
    px=random(700);
    py=random(700);
  }
  
  void Dibujar(){
    switch(num) {
  case 0: 
  ellipse( px, py, ancho, alto);
    break;
  
}
    noStroke();
    rectMode(CENTER);
    fill(r,g,b,160);
    
  }
 

  
  void Mover(){
    px+=cos(direccion)*velocidad;
    py+=sin(direccion)*velocidad;
    if (px >= 700) {
     direccion=random(PI/2,3*(PI/2));
  }
  if (px <= 0) {
     direccion=random(-PI/2,PI/2);
  }
   if (py <= 0) {
     direccion=random(0,PI);
  }
  if (py >= 640) {
     direccion=random(PI,2*PI);
  }
    
  }
  
 
}


  