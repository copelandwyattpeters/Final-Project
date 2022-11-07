class ProjectileShip extends Ship{
  ProjectileShip(float x, float y, float speed){
    super(x,y, speed);
  }
  
  void display(){
    pushMatrix();
    fill(#FFFFFF);
    scale(.5);
    ellipse(x,y, 10, 10);
    popMatrix();
  }
  
  void move(){
    this.y -= 10;
  }
}
