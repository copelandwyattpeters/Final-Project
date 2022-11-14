class Invaders{
  float x;
  float y;
  float speed;
  boolean isAlive;
  boolean isShooting;
  boolean horizontal;
  boolean vertical;
  color cols;
  boolean animate;
  int randomNum;
  
  Invaders(float x, float y, float speed, color cols){
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.isAlive = true;
    this.isShooting = false;
    this.horizontal = true;
    this.vertical = false;
    this.cols = cols;
    this.animate = false;
    this.randomNum = 0;
  }
  
  void display(){
    if (this.isAlive == true){
      noStroke();
      if (this.animate == false){
      noStroke();
      pushMatrix();
      scale(.5);
      rectMode(CENTER);
      fill(cols);
      rect(x,y,35,25);
      fill(#000000);
      rect(x-10,y,8,5);
      rect(x+10,y,8,5);
      fill(cols);
      rect(x,y-15,25,5);
      rect(x,y-20,10,5);
      rect(x-20,y,10,15);
      rect(x+20,y,10,15);
      rect(x+25,y-10,5,5);
      rect(x+30,y-15,5,5);
      rect(x-25,y-10,5,5);
      rect(x-30,y-15,5,5);
      rect(x+25,y+10,5,5);
      rect(x+30,y+15,5,5);
      rect(x-25,y+10,5,5);
      rect(x-30,y+15,5,5);
      rect(x-10,y+15,5,5);
      rect(x-5,y+20,5,5);
      rect(x+10,y+15,5,5);
      rect(x+5,y+20,5,5);
      popMatrix();
      }
      else{
        this.animate();
      }
    }
  }
    
  
 void animate(){
  noStroke();
  pushMatrix();
  scale(.5);
  rectMode(CENTER);
  fill(cols);
  rect(x,y,35,25);
  fill(#000000);
  rect(x-10,y,8,5);
  rect(x+10,y,8,5);
  fill(cols);
  rect(x,y-15,25,5);
  rect(x,y-20,10,5);
  rect(x-20,y,10,15);
  rect(x+20,y,10,15);
  rect(x+25,y-10,5,5);
  rect(x+30,y-15,5,5);
  rect(x-25,y-10,5,5);
  rect(x-30,y-15,5,5);
  rect(x+25,y+10,5,5);
  rect(x+30,y+15,5,5);
  rect(x-25,y+10,5,5);
  rect(x-30,y+15,5,5);
  rect(x-10,y+15,5,5);
  rect(x-15,y+20,5,5);
  rect(x+10,y+15,5,5);
  rect(x+15,y+20,5,5);
  popMatrix();
  }
  
  void moveVertical(){
    this.y += this.speed;
    if (this.horizontal == true){
      this.horizontal = false;
    }
    else{
      this.horizontal = true;
    }
  }
  
  void moveHorizontal(){
    if (this.horizontal == true){
      this.x += this.speed;
    }
    else{
      this.x -= this.speed;
    }
  }
}
