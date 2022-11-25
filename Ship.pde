class Ship{
  float x;
  float y;
  float speed;
  int lives;
  boolean animate;
  Ship(float x, float y, float speed){
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.lives = 3;
    this.animate = false;
  }
  
  void display(){
    if (this.animate == false){
    pushMatrix();
    scale(.5);
    fill(#FFFFFF);
    rectMode(CENTER);
    rect(x,y, 100, 10);
    rect(x,y-35, 30, 100);
    rect(x-35,y-15, 30, 30);
    rect(x+35,y-15, 30, 30);
    fill(#6349DB);
    triangle(x-15,y-82.5,x+15,y-82.5,x,y-125);
    fill(#F70F0F);
    triangle(x-20,y-30,x-50,y-30,x-35,y-65);
    triangle(x+20,y-30,x+50,y-30,x+35,y-65);
    popMatrix();
    }
    else{
      this.animate();
    }
  }
  
  void animate(){
    noStroke();
    pushMatrix();
    scale(.5);
    fill(#FFFFFF);
    rectMode(CENTER);
    rect(x,y, 100, 10);
    rect(x,y-35, 30, 100);
    rect(x-35,y-15, 30, 30);
    rect(x+35,y-15, 30, 30);
    fill(#6349DB);
    triangle(x-15,y-82.5,x+15,y-82.5,x,y-125);
    fill(#F70F0F);
    triangle(x-20,y-30,x-50,y-30,x-35,y-65);
    triangle(x+20,y-30,x+50,y-30,x+35,y-65);
    popMatrix();
  }
  
  void moveRight(){
    this.x += this.speed;
  }
  
  void moveLeft(){
    this.x -= this.speed;
  }
}
