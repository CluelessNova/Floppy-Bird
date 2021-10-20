class Bird {
  float xpos, ypos, r, gravity, velocity, jump;

  Bird() {
    xpos = width/6;
    ypos = height/2;
    r = 20;
    gravity = .1;
    velocity = 0;
    jump = -5;
  }

  void display() {
    //Making bird
    fill(100,100,0);
    triangle(xpos+r, ypos-5, xpos+r, ypos+5, xpos+r+10, ypos);
    fill(200, 120, 255);
    noStroke();
    ellipse(xpos, ypos, r*2, r*2);
    fill(200, 120, 255);
    stroke(0);
    ellipse(xpos-5, ypos+2, 20, 10);
    noStroke();
    ellipse(xpos+2,ypos+2,10,10);
    fill(255);
    ellipse(xpos+7, ypos-5, 13, 13);
    fill(0);
    ellipse(xpos+8, ypos-5, 5, 5);
  }

  void gravity() {
    //Bird falling
    ypos+=velocity;
    velocity+=gravity;

    //If bird hits ground/roof
    if (ypos > height-30-r) {
      ypos = height-30-r;
      velocity = 0;
    }
    if (ypos < 0) {
      ypos = 0;
      velocity = 0;
    }
  }

  void jump() {
    //Bird jump
    velocity+=jump;
  }
}
