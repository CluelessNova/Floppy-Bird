class Pipes {
  float xpos, w, top, bottom, xspeed;
  int c = color(0, 255, 0);

  Pipes() {
    xpos = width;
    top = random(height/2);
    bottom = random(height/2);
    xspeed = .5;
    w = 40;
  }

  void display() {
    fill(c);
    //Top pipe
    rect(xpos, 0, w, top);
    //Bottom pipe
    rect(xpos, height-bottom, w, bottom);
  }

  void move() {
    //Making pipes move
    xpos-=xspeed;
  }

  //Checking if the bird and either pipe collides 
  boolean checkHit(Bird bird) {
    if ((bird.xpos+bird.r > xpos) && (bird.xpos-bird.r < (xpos+w))) {
      if ((bird.ypos < (top+bird.r)) || (bird.ypos > (height-bottom-bird.r))) {

        return (true);
      }
    }
    return (false);
  }

  //Checking if the bird doesn't hit either pipe and goes through the middle
  boolean goal(Bird bird) {
    if ((bird.xpos+bird.r == (xpos+w+bird.r))) {
      if ((bird.ypos > (top+bird.r)) || (bird.ypos < (height-bottom-bird.r))) {

        return (true);
      }
    }
    return (false);
  }
}
