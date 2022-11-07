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
    popMatrix();
  }
  
  void moveRight(){
    this.x += this.speed;
  }
  
  void moveLeft(){
    this.x -= this.speed;
  }
}
