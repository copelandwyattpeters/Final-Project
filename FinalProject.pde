// VARIABLES
// Position for Invaders
float x = 150;
float y = 100;
// Speed in which invaders move
float speed = 50;
// Count for invader positioning
int count = 0;
// Tracks number of invaders which have been killed
int deathCount = 0;
// Number of invaders drawn to screen
int InvaderNumber = 40;
// Color of invaders (changed based on difficulty)
color cols = color(#FF69B4);
// Time bonus to keep track of high scores
int timeBonus = 1000;

// Times Horizontal Movement
Timer t;
// Times Verical Movement
Timer t2;
// Times Invader Animations
Timer t3;
// Times Projectile Animations
Timer t4;
// Times Color Change for Ship
Timer t5;
// Times Ship Projectile Cooldown
Timer t6;

// Make new lists for invaders, projectiles from invaders, and projectiles from the ship
Invaders[] spaceInvaders = new Invaders[InvaderNumber];
ArrayList <Projectile> projectiles = new ArrayList <Projectile>();
ArrayList <ProjectileShip> projectilesShip = new ArrayList <ProjectileShip>();
// Make ship 1
Ship ship1;
// Keep track of if all of the enemies are dead
boolean allDead = false;
// Boolean for if the game is active
boolean gameRunning = false;
// True if a win condition is met
boolean win = false;
// Enables start screen to appear
boolean start = true;
// Enables instruction screen to appear
boolean instruction = false;
// Enables high score screen to appear
boolean highScores = false;
// Player score
int score = 0;
// As it increases, invaders are more likely to shoot projectiles
// increases after every invader death
int counter = 0;
// 1-4 type for invader designs
int type = 4;
Star[] stars = new Star[800];
float starSpeed;
PFont font, font2;
// 0 = Easy, 1 = Medium, 2 = Hard
int difficulty = 0;

import processing.sound.*;
SoundFile menu_file, ping_file, life_file;


// SETUP
void setup(){
  size(750,650);
  menu_file = new SoundFile(this,"background1.wav");
  menu_file.play();
  menu_file.amp(1);
  menu_file.loop();
  background(#000000);
  font = createFont("space_invaders.ttf", 20);
  font2 = createFont("MachineStd-Bold.otf", 20);
   for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  ping_file = new SoundFile(this,"ping.mp3");
  life_file = new SoundFile(this,"ship_life.wav");

}

//DRAW
void draw(){
  // Display start screen 
  if (!gameRunning && start == true) {
    startScreen();
    return;
  }
  
  // Move all projectiles from invaders 
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
  
  // Move all projectiles from the ship
  if (t4.paused == false){
    if (t4.hasElapsed() == true){
      for (ProjectileShip p : projectilesShip) {
        if (p.y <= height*2){
          p.move();
        }
      }
    }
  }
  
  // Refill the background
  background(#000000);
  // Display the ship
  ship1.display();
  
  // If t3 time has elapsed, switch animation status of the invaders
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
  
  // Display Invaders based on their animation status if they are currently alive
  for (int i = 0; i < spaceInvaders.length; i++){
    if (spaceInvaders[i].isAlive == true){
      spaceInvaders[i].display();
      // Determine if the invader will produce a projectile based on random number
      if (spaceInvaders[i].randomNum >= (5000 - counter)){
        Projectile newProjectile = 
        new Projectile(spaceInvaders[i].x, spaceInvaders[i].y, 10, cols);
        projectiles.add(newProjectile);
      }
    // Reset random number for each invader  
    int int1 = int(random(0,5001));
    spaceInvaders[i].randomNum = int1;
   }
  }
  // Display invader projectiles
  for (Projectile p : projectiles) {
    p.display();
  }
  
  // Display ship projectiles
  for (ProjectileShip p : projectilesShip) {
    p.display();
  }
  
  // Move invaders vertically if t2 elapses
  if (t2.paused == false){
    if (t2.hasElapsed() == true){
      for (int i = 0; i < spaceInvaders.length; i++){
        spaceInvaders[i].moveVertical();
        t.timeElapsed = millis();
      }
      t2.timeElapsed = millis();
    }
  }
  
  // If t elapses, move invaders horizontally
  if (t.paused == false){
    if (t.hasElapsed() == true){
      for (int i = 0; i < spaceInvaders.length; i++){
        spaceInvaders[i].moveHorizontal();
      }
      t.timeElapsed = millis();
      timeBonus -= 10;
    }
  }
  
  // Remove projectiles from invaders which have a y position off of the screen
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile p = projectiles.get(i);
    if (p.y>=height*2) {
      projectiles.remove(i);
    }
  }
  
  // Remove projectiles from ship which have a y position off of the screen
  for (int i = projectilesShip.size() - 1; i >= 0; i--) {
    ProjectileShip p = projectilesShip.get(i);
    if (p.y<=0) {
      projectilesShip.remove(i);
    }
  }
  
  // Remove invaders which are struck by projectiles
  for (int i = 0; i < spaceInvaders.length; i++){
    if (spaceInvaders[i].isAlive == true){
      // Loop through all ship projectiles to determine if they are over an invader
      for (int j = projectilesShip.size() - 1; j >= 0; j--) {
        ProjectileShip p = projectilesShip.get(j);
          if (overEnemy(p, spaceInvaders[i]) == true){
            // If they hit an invader, set status to dead and remove projectile
            spaceInvaders[i].isAlive = false;
            projectilesShip.remove(j);
            // Increment score
            score += spaceInvaders[i].points;
            // Increase the probability of remaining invaders to produce a projectile
            counter += .5;
        }
      }
    }
  }
  
  // Determine if a projectile from an invader hits the ship
  for (int j = projectiles.size() - 1; j >= 0; j--) {
        Projectile p = projectiles.get(j);
          if (overShip(p, ship1) == true){
            // Remove projectile if it hits the ship
            projectiles.remove(j);
            // Decrease ship lives by 1
            ship1.lives -=1;
            // Cause ship to turn red to demonstrate that it has been hit
            ship1.animate = true;
            life_file.play();
            life_file.amp(0.3);
            t5.timeElapsed = millis();
            
          }
  }
  
  // If the t5 elapses after a ship has been hit, return to normal color
  if (t5.hasElapsed() == true){
    ship1.animate = false;
  }
  
  // Set screen to loss screen if the player loses all lives
  if (ship1.lives == 0){
  screen("lose");
  gameRunning = false;
  }
  
  // Increase death count of invaders by looping though and seeing which are dead
  for (int i = 0; i < spaceInvaders.length; i++){
    if (spaceInvaders[i].isAlive == false){
      deathCount += 1;
    }
  }
  
  // If all of the invaders are dead, set to true
  if (deathCount >= InvaderNumber){
    allDead = true;
  }
  // Else, return death count to 0 before running the previous loop again
  else{
    deathCount = 0;
  }
  
  // If all dead is true, player wins. Display win screen
  if (allDead == true){
    screen("win");
    gameRunning = false;
    win = true;
  }
  //  Player loses if invaders go too far in y direction
    if (spaceInvaders[InvaderNumber-1].y >= height*2-50){
      screen("lose");
      gameRunning = false;
    }
    
    fill(#FFFFFF);
    textFont(font);
    text("Lives: ", 604,600);
    String string = str(ship1.lives);
    text(string, 684,600);
    text("Score: ", 600,550);
    String stringScore = str(score);
    text(stringScore, 685,550);
  }
  
  // Display appropriate screens following end of game based on win status
  

  if (gameRunning == false){
    if (instruction == false){
      if (highScores == false){
        if (win == true){
          screen("win");
          gameRunning = false;
        }
        if (win == false){
          screen("lose");
          gameRunning = false;
        }
      }
      else{
        highScoreScreen();
      }
    }
    else{
      instructionScreen();
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
   // Add new ship projectile anytime 'w' is pressed 
   if (key == 'w'){
      ping_file.play();
      ping_file.amp(0.1);
      ProjectileShip newProjectileShip = 
      new ProjectileShip(ship1.x, ship1.y, float(10));
      projectilesShip.add(newProjectileShip);
    } 
   if (gameRunning == false){ 
     if (key == 'r'){
        start = true;
        startScreen();
      }
      if (key == 'e') {
       exit();
       }
   }
}

// Determine if the ship projectile is over the enemy invader
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

// Determine if the invader projectiles are over the ship
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

// Restart the settings of the game for medium difficulty
// Characterized by blue/purple invaders
void restart(){
  x = 150;
  y = 100;
  speed = 50;
  count = 0;
  deathCount = 0;
  InvaderNumber = 40;
  cols = color(#FF69B4);
  type = 4;
  spaceInvaders = new Invaders[InvaderNumber];
  projectiles = new ArrayList <Projectile>();
  projectilesShip = new ArrayList <ProjectileShip>();
  allDead = false;
  gameRunning = true;
  win = false;
  score = 0;
  counter = 0;
  timeBonus = 1000;
  int green = 100;
  int red = 0;   
  int blue = 255;
  
  background(#000000);
  ship1 = new Ship(width,(height*2 -50), 50);
  for (int i = 0; i < 4; i++){
    red += 50;
    for (int j = 0; j < 10; j++){
      cols = color(red, green, blue);
      Invaders invader1 = new Invaders(x,y,speed, cols);
      invader1.type = type;
      invader1.points = invader1.type*10;
      spaceInvaders[count] = invader1;
      x += 100;
      count +=1;
    }
    y += 100;
    x = 150;
    type -= 1;
    
  }
  t = new Timer(1000);
  t2 = new Timer(8000);
  t3 = new Timer(500);
  t4 = new Timer(1000);
  t5 = new Timer(100);
  
  t.timeElapsed = millis();
  t2.timeElapsed = millis();
  t3.timeElapsed = millis();
  t4.timeElapsed = millis();
  t5.timeElapsed = millis();
  
}

// Restart the settings of the game for easy difficulty
// Characterized by green/blue invaders
void restartEasy(){
  x = 150;
  y = 100;
  speed = 25;
  count = 0;
  deathCount = 0;
  InvaderNumber = 20;
  cols = color(#FF69B4);
  type = 2;
  spaceInvaders = new Invaders[InvaderNumber];
  projectiles = new ArrayList <Projectile>();
  projectilesShip = new ArrayList <ProjectileShip>();
  allDead = false;
  gameRunning = true;
  win = false;
  score = 0;
  counter = 0;
  timeBonus = 1000;
  int red = 100;
  int green = 255;
  int blue = 0;
  
  background(#000000);
  ship1 = new Ship(width,(height*2 -50), 50);
  ship1.lives = 5;
  for (int i = 0; i < 2; i++){
    blue += 150;
    for (int j = 0; j < 10; j++){
      cols = color(red, green, blue);
      Invaders invader1 = new Invaders(x,y,speed, cols);
      invader1.type = type;
      invader1.points = invader1.type*10;
      spaceInvaders[count] = invader1;
      x += 100;
      count +=1;
    }
    y += 100;
    x = 150;
    type -= 1;
    
  }
  t = new Timer(1000/2);
  t2 = new Timer(8000);
  t3 = new Timer(500);
  t4 = new Timer(1000);
  t5 = new Timer(100);
  
  t.timeElapsed = millis();
  t2.timeElapsed = millis();
  t3.timeElapsed = millis();
  t4.timeElapsed = millis();
  t5.timeElapsed = millis();
}

// Restart the settings of the game for hard difficulty
// Characterized by red/orange invaders
void restartHard(){
  x = 150;
  y = 100;
  speed = 75;
  count = 0;
  deathCount = 0;
  InvaderNumber = 60;
  cols = color(#FF69B4);
  type = 4;
  spaceInvaders = new Invaders[InvaderNumber];
  projectiles = new ArrayList <Projectile>();
  projectilesShip = new ArrayList <ProjectileShip>();
  allDead = false;
  gameRunning = true;
  win = false;
  score = 0;
  counter = 0;
  timeBonus = 1000;
  int red = 255;
  int green = 0;
  int blue = 100;
  
  background(#000000);
  ship1 = new Ship(width,(height*2 -50), 50);
  ship1.lives = 1;
  for (int i = 0; i < 6; i++){
    green += 50;
    for (int j = 0; j < 10; j++){
      cols = color(red, green, blue);
      Invaders invader1 = new Invaders(x,y,speed, cols);
      invader1.type = type;
      invader1.points = invader1.type*10;
      spaceInvaders[count] = invader1;
      x += 100;
      count +=1;
    }
    y += 100;
    x = 150;
    if (type == 1){
      type = 2;
    }
    type -= 1;
    
  }
  t = new Timer(1000/1.75);
  t2 = new Timer(8000/3.0625);
  t3 = new Timer(500);
  t4 = new Timer(1000);
  t5 = new Timer(100);
  
  t.timeElapsed = millis();
  t2.timeElapsed = millis();
  t3.timeElapsed = millis();
  t4.timeElapsed = millis();
  t5.timeElapsed = millis();
}

// Display the starting screen for the game
void startScreen() {
  background(0);
  starSpeed = 1;
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
  popMatrix();
  rectMode(CORNER);
  fill(0);
  rect(100,200,550,220);
  
  // Hard Button
  if (dist(mouseX, 0, width/2+175, 0) <= 75 && dist(0, mouseY, 0, height/2 + 60) <= 30) {
    fill(30);
    noStroke();
    rectMode(CENTER);
    rect(width/2+175, height / 2 + 60, 150, 60, 20);
    
    if (mousePressed) {
      difficulty = 2;
      restartHard();
      gameRunning = true;
      start = false;
    }
  }
  
  // Easy Button
  if (dist(mouseX, 0, width/2-175, 0) <= 75 && dist(0, mouseY, 0, height/2 + 60) <= 30) {
    fill(30);
    noStroke();
    rectMode(CENTER);
    rect(width/2-175, height / 2 + 60, 150, 60, 20);
    
    if (mousePressed) {
      difficulty = 0;
      restartEasy();
      gameRunning = true;
      start = false;
    }
  }
  
  // Medium Button
  if (dist(mouseX, 0, width/2, 0) <= 75 && dist(0, mouseY, 0, height/2 + 60) <= 30) {
    fill(30);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height / 2 + 60, 150, 60, 20);
    
    if (mousePressed) {
      difficulty = 1;
      restart();
      gameRunning = true;
      start = false;
    }
  }
  
  // Instructions
  if (dist(mouseX, 0, width - 100, 0) <= 75 && dist(0, mouseY, 0, height - 150) <= 30) {
    fill(30);
    noStroke();
    rectMode(CENTER);
    rect(width - 100, height -150 , 150, 60, 20);
    
    if (mousePressed) {
      start = false;
      instruction = true;
      highScores = false;
    }
  }
  
  // High Scores
  if (dist(mouseX, 0, width - 100, 0) <= 75 && dist(0, mouseY, 0, height - 75) <= 30) {
    fill(30);
    noStroke();
    rectMode(CENTER);
    rect(width - 100, height - 75 , 150, 60, 20);
    
    if (mousePressed) {
      start = false;
      instruction = false;
      highScores = true;
    }
  }
  
  textFont(font2);
  textSize(90);
  textAlign(CENTER, CENTER);
  fill(254, 162, 32);
  text("Space Invaders", width / 2, height / 2 - 60);
   fill(255, 234, 0);
  text("Space Invaders", width / 2 - 3, height / 2 - 60);
  textFont(font);
  fill(35, 247, 32);
  textSize(28);
  text("medium", width / 2, height / 2 + 60);
  text("easy", width / 2-175, height / 2 + 60);
  text("hard", width / 2+175, height / 2 + 60);
  
  textSize(15);
  text("instructions", width - 100, height - 150);
  text("high scores", width - 100, height - 75);
}

void screen(String outcome) {
  background(0);
  textFont(font2);
  textSize(90);
  fill(254, 162, 32);
  textAlign(CENTER, CENTER);
  String txt = "";
  if (outcome == "lose") {
    txt = "YOU LOSE";
    text(txt, width / 2, height / 2 - 60);
    fill(255, 234, 0);
    text(txt, width / 2 - 3, height / 2 - 60);
    textFont(font);
    textSize(28);
    fill(35, 247, 32);
    String stringScore5 = "Final Score: " + "0";
    text(stringScore5, width/2, height / 2 + 60);
    text("Press 'r' to restart", width/2, height / 2 + 100);
    text("Press 'e' to exit", width/2, height / 2 + 140);
  }
  if (outcome == "win") {
    txt = "YOU WIN";
    text(txt, width / 2, height / 2 - 60);
    fill(255, 234, 0);
    text(txt, width / 2 - 3, height / 2 - 60);
    textFont(font);
    textSize(28);
    fill(35, 247, 32);
    String stringScore = str(score);
    String stringScore2 = "Score: " + stringScore;
    text(stringScore2, width/2, height / 2 + 60);
    String stringBonus = str(timeBonus);
    String stringScore4 = "Time Bonus: " + stringBonus;
    text(stringScore4, width/2, height / 2 + 100);
    String finalScore = str(score+timeBonus);
    String stringScore5 = "Final Score: " + finalScore;
    text(stringScore5, width/2, height / 2 + 140);
    text("Press 'r' to restart", width/2, height / 2 + 180);
    text("Press 'e' to exit", width/2, height / 2 + 220);
  }
}

void instructionScreen(){
  background(0);
  starSpeed = 1;
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
  popMatrix();
  rectMode(CENTER);
  fill(0);
  rect(width/2,height/2,650,500);
  
  // Back Home
  if (dist(mouseX, 0, 100, 0) <= 75 && dist(0, mouseY, 0, height - 35) <= 30) {
    fill(30);
    noStroke();
    rectMode(CENTER);
    rect(100, height - 35 , 150, 60, 20);
    
    if (mousePressed) {
      start = true;
      instruction = false;
    }
  }
  
  textSize(30);
  fill(35, 247, 32);
  text("movement instructions: ", width/2, 100);
  textSize(20);
  text("press 'a' to move ship left ", width/2, 140);
  text("press 'd' to move ship right ", width/2, 170);
  text("press 'w' to fire projectile ", width/2, 200);
  textSize(30);
  text("easy difficulty:", width/2, 300);
  textSize(20);
  text("20 enemies, slow movement, fewer projectiles", width/2, 340);
  textSize(30);
  text("Medium difficulty:", width/2, 400);
  textSize(20);
  text("40 enemies, average speed, ship cooldown", width/2, 440);
  textSize(30);
  text("hard difficulty:", width/2, 500);
  textSize(20);
  text("60 enemies, fast speed, longer cooldown", width/2, 540);
  text("back home", 100, height - 35);
}

void highScoreScreen(){
  background(0);
  starSpeed = 1;
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
  popMatrix();
  rectMode(CENTER);
  fill(0);
  rect(width/2,height/2,650,500);
  
  // Back Home
  if (dist(mouseX, 0, 100, 0) <= 75 && dist(0, mouseY, 0, height - 35) <= 30) {
    fill(30);
    noStroke();
    rectMode(CENTER);
    rect(100, height - 35 , 150, 60, 20);
    
    if (mousePressed) {
      start = true;
      highScores = false;
    }
  }
  
  textSize(30);
  fill(35, 247, 32);
  text("high scores ", width/2, 100);
  textSize(20);
  text("back home", 100, height - 35);
}
