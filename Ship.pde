class Ship{
  float x;
  float y;
  float speed;
  int lives;
  Ship(float x, float y, float speed){
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.lives = 3;
  }
  
  void display(){
    pushMatrix();
    scale(.5);
    fill(#FFFFFF);
    rectMode(CENTER);
    rect(x,y, 100, 30);
    rect(x-35,y-30, 30, 30);
    rect(x+35,y-30, 30, 30);
    triangle(x-20,y-15,x+20,y-15,x,y-50);
    fill(#F70F0F);
    triangle(x-20,y-45,x-50,y-45,x-35,y-75);
    triangle(x+20,y-45,x+50,y-45,x+35,y-75);
    popMatrix();
  }
  
  void moveRight(){
    this.x += this.speed;
  }
  
  void moveLeft(){
    this.x -= this.speed;
  }
}
