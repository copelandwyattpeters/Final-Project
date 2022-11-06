float x = 150;
float y = 100;
float speed = 50;
int count = 0;
int deathCount = 0;
int InvaderNumber = 40;
color cols = color(#FF69B4);
Timer t;
Timer t2;
Timer t3;
Timer t4;
Invaders[] spaceInvaders = new Invaders[InvaderNumber];
ArrayList <Projectile> projectiles = new ArrayList <Projectile>();
ArrayList <ProjectileShip> projectilesShip = new ArrayList <ProjectileShip>();
Ship ship1;
boolean allDead = false;

void setup(){
  size(750,750);
  background(#000000);
  ship1 = new Ship(width,(height*2 -50), 50);
  for (int i = 0; i < 4; i++){
    for (int j = 0; j < 10; j++){
      cols = color(#FF69B4);
      Invaders invader1 = new Invaders(x,y,speed, cols);
      spaceInvaders[count] = invader1;
      x += 100;
      count +=1;
    }
    y += 100;
    x = 150;
  }
  t = new Timer(1000);
  t2 = new Timer(8000);
  t3 = new Timer(500);
  t4 = new Timer(1000);
}


void draw(){
    if (t4.paused == false){
    if (t4.hasElapsed() == true){
      for (Projectile p : projectiles) {
        if (p.y <= height*2){
          p.move();
        }
      }
    }
  }
  if (t4.paused == false){
    if (t4.hasElapsed() == true){
      for (ProjectileShip p : projectilesShip) {
        if (p.y <= height*2){
          p.move();
        }
      }
    }
  }
  background(#000000);
  ship1.display();
   if (t3.paused == false){
    if (t3.hasElapsed() == true){
      for (int i = 0; i < spaceInvaders.length; i++){
        if (spaceInvaders[i].animate == true){
          spaceInvaders[i].animate = false;
        }
        else{
          spaceInvaders[i].animate = true;
        }
        t3.timeElapsed = millis();
      }
    }
   }
  
  for (int i = 0; i < spaceInvaders.length; i++){
    spaceInvaders[i].display();
    if (spaceInvaders[i].randomNum >= 5000){
      Projectile newProjectile = 
      new Projectile(spaceInvaders[i].x, spaceInvaders[i].y, 10, cols);
      projectiles.add(newProjectile);
    }
    int int1 = int(random(0,5001));
    spaceInvaders[i].randomNum = int1;
  }
  for (Projectile p : projectiles) {
    p.display();
  }
  
  for (ProjectileShip p : projectilesShip) {
    p.display();
  }
  
  if (t2.paused == false){
    if (t2.hasElapsed() == true){
      for (int i = 0; i < spaceInvaders.length; i++){
        spaceInvaders[i].moveVertical();
        t.timeElapsed = millis();
      }
      t2.timeElapsed = millis();
    }
  }
  
  if (t.paused == false){
    if (t.hasElapsed() == true){
      for (int i = 0; i < spaceInvaders.length; i++){
        spaceInvaders[i].moveHorizontal();
      }
      t.timeElapsed = millis();
    }
  }
  
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile p = projectiles.get(i);
    if (p.y>=height*2) {
      projectiles.remove(i);
    }
  }
  
  for (int i = projectilesShip.size() - 1; i >= 0; i--) {
    ProjectileShip p = projectilesShip.get(i);
    if (p.y<=0) {
      projectilesShip.remove(i);
    }
  }
  
  for (int i = 0; i < spaceInvaders.length; i++){
    if (spaceInvaders[i].isAlive == true){
      for (int j = projectilesShip.size() - 1; j >= 0; j--) {
        ProjectileShip p = projectilesShip.get(j);
          if (overEnemy(p, spaceInvaders[i]) == true){
            spaceInvaders[i].isAlive = false;
            projectilesShip.remove(j);
      }
      }
    }
  }
  for (int j = projectiles.size() - 1; j >= 0; j--) {
        Projectile p = projectiles.get(j);
          if (overShip(p, ship1) == true){
            projectiles.remove(j);
            ship1.lives -=1;
            
          }
  }
  if (ship1.lives == 0){
    noLoop();
    background(#000000);
    textSize(128);
    text("YOU", 200,200);
    text("LOSE", 200,400);
  }
  
  for (int i = 0; i < spaceInvaders.length; i++){
    if (spaceInvaders[i].isAlive == false){
      deathCount += 1;
    }
  }
  if (deathCount >= InvaderNumber){
    allDead = true;
  }
  else{
    deathCount = 0;
  }
  
  if (allDead == true){
    noLoop();
    background(#000000);
    textSize(128);
    text("YOU", 200,200);
    text("WIN", 200,400);
  }
}

void keyPressed(){
   if (key == 'd'){
      ship1.moveRight();
      }
   if (key == 'a'){
      ship1.moveLeft();
    }
   if (key == 'w'){
      ProjectileShip newProjectileShip = 
      new ProjectileShip(ship1.x, ship1.y, float(10));
      projectilesShip.add(newProjectileShip);
    }
}


boolean overEnemy(ProjectileShip projectile1, Invaders invader1 ){
   if (projectile1.x < invader1.x + 30){
   }
   else{
     return false;
   }
   if (projectile1.x > invader1.x - 30){
   }
   else{
     return false;
   }
   if (projectile1.y > invader1.y - 20){
   }
   else{
     return false;
   }
   if (projectile1.y < invader1.y + 20){
     return true;
   }
   else{
     return false;
   }
}

boolean overShip(Projectile projectile1, Ship ship1 ){
   if (projectile1.x < ship1.x + 50){
   }
   else{
     return false;
   }
   if (projectile1.x > ship1.x - 50){
   }
   else{
     return false;
   }
   if (projectile1.y > ship1.y - 15){
   }
   else{
     return false;
   }
   if (projectile1.y < ship1.y + 15){
     return true;
   }
   else{
     return false;
   }
}
