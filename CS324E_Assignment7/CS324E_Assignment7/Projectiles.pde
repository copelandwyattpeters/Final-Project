class Projectile extends Invaders{
  boolean remove;
  Projectile(float x, float y, float speed, color cols){
    super(x,y, speed, cols);
    this.remove = false;
  }
  
  void display(){
    pushMatrix();
    fill(#FFFFFF);
    scale(.5);
    ellipse(x,y, 10, 10);
    popMatrix();
  }
  
  void move(){
    this.y += 10;
  }
}
