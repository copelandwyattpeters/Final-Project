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
Timer t5;
Invaders[] spaceInvaders = new Invaders[InvaderNumber];
ArrayList <Projectile> projectiles = new ArrayList <Projectile>();
ArrayList <ProjectileShip> projectilesShip = new ArrayList <ProjectileShip>();
Ship ship1;
boolean allDead = false;
boolean gameRunning = true;
boolean win = false;
int score = 0;
int counter = 0;

void setup(){
  size(750,650);
  background(#000000);
  ship1 = new Ship(width,(height*2 -50), 50);
  for (int i = 0; i < 4; i++){
    int green = int(random(0,255));
    int red = int(random(0,255));    
    int blue = int(random(0,255));
    for (int j = 0; j < 10; j++){
      cols = color(red, green, blue);
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
  if (gameRunning == true){
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
  fill(#FFFFFF);
  textSize(25);
  text("Lives: ", 600,600);
  String string = str(ship1.lives);
  text(string, 675,600);
  text("Score: ", 600,550);
  String stringScore = str(score);
  text(stringScore, 675,550);
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
    if (spaceInvaders[i].isAlive == true){
    spaceInvaders[i].display();
    if (spaceInvaders[i].randomNum >= (5000 - counter)){
      Projectile newProjectile = 
      new Projectile(spaceInvaders[i].x, spaceInvaders[i].y, 10, cols);
      projectiles.add(newProjectile);
    }
    int int1 = int(random(0,5001));
    spaceInvaders[i].randomNum = int1;
  }
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
            score +=1;
            counter += .5;
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
    background(#000000);
    textSize(50);
    text("YOU", 200,200);
    text("LOSE", 200,400);
    text("RESTART?", 200,600);
    gameRunning = false;
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
    background(#000000);
    textSize(50);
    fill(#FFFFFF);
    text("YOU", 200,200);
    text("WIN", 200,400);
    text("RESTART?", 200,600);
    gameRunning = false;
    win = true;
  }
    if (spaceInvaders[InvaderNumber-1].y >= height*2-50){
    background(#000000);
    textSize(50);
    fill(#FFFFFF);
    text("YOU", 200,200);
    text("LOSE", 200,400);
    text("RESTART?", 200,600);
    gameRunning = false;
  }
  }
  
  if (gameRunning == false){
    fill(#FFFFFF);
    if (win == true){
    background(#000000);
    textSize(50);
    text("YOU", 200,200);
    text("WIN", 200,400);
    text("RESTART?", 200,600);
    }
    if (win == false){
      background(#000000);
      textSize(50);
      text("GAME", 200,200);
      text("OVER", 200,400);
      text("Press 'r' to restart", 200,600);
    }
    
  }
}

void keyPressed(){
   if (key == 'd'){
     if (ship1.x < width*2){
      ship1.moveRight();
     }
   }
   if (key == 'a'){
     if (ship1.x > 0){
      ship1.moveLeft();
     }
    }
   if (key == 'w'){
      ProjectileShip newProjectileShip = 
      new ProjectileShip(ship1.x, ship1.y, float(10));
      projectilesShip.add(newProjectileShip);
    }
   if (gameRunning == false){ 
     if (key == 'r'){
         gameRunning = true;
        restart();
      }
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

void restart(){
  x = 150;
  y = 100;
  speed = 50;
  count = 0;
  deathCount = 0;
  InvaderNumber = 40;
  cols = color(#FF69B4);
  spaceInvaders = new Invaders[InvaderNumber];
  projectiles = new ArrayList <Projectile>();
  projectilesShip = new ArrayList <ProjectileShip>();
  allDead = false;
  gameRunning = true;
  win = false;
  score = 0;
  counter = 0;
  
  background(#000000);
  ship1 = new Ship(width,(height*2 -50), 50);
  for (int i = 0; i < 4; i++){
    int green = int(random(0,255));
    int red = int(random(0,255));    
    int blue = int(random(0,255));
    for (int j = 0; j < 10; j++){
      cols = color(red, green, blue);
      Invaders invader1 = new Invaders(x,y,speed, cols);
      spaceInvaders[count] = invader1;
      x += 100;
      count +=1;
    }
    y += 100;
    x = 150;
  }
  t.timeElapsed = millis();
  t2.timeElapsed = millis();
  t3.timeElapsed = millis();
  t4.timeElapsed = millis();
}
