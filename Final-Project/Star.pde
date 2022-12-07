class Star {
  float x, y, z;
  PShape star;

  Star() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
  }

  void update() {
    z = z - starSpeed;
    if (z < 1) {
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
    }
  }

  void show() {
    fill(255);
    noStroke();
    float x2 = map(x/z, 0, 1, 0, width/2);
    float y2 = map(y/z, 0, 1, 0, height/2);;
    pushMatrix();
    translate(x2, y2);
    scale(.1);
    star();
    popMatrix();
    stroke(255);

  }
  
  void star() {
  star = createShape();
  star.beginShape();
  star.vertex(0, -50);
  star.vertex(14, -20);
  star.vertex(47, -15);
  star.vertex(23, 7);
  star.vertex(29, 40);
  star.vertex(0, 25);
  star.vertex(-29, 40);
  star.vertex(-23, 7);
  star.vertex(-47, -15);
  star.vertex(-14, -20);
  star.endShape(CLOSE);
  shape(star);
}
}
