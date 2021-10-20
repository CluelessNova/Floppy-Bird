class Cloud {
  float x, y, r, xspeed;


  Cloud(float tempX, float tempY, float tempr) {

    x = tempX;
    y = tempY;
    r = tempr;
    xspeed = .1;
  }
  void display() {
    //Making clouds
    fill(255, 255, 255, 245);
    noStroke();
    ellipse(x, y, r, r);
    ellipse(x+15, y+15, r+15, r+15);
    ellipse(x-15, y+15, r+15, r+15);
    ellipse(x+30, y+30, r+15, r+15);
    ellipse(x-20, y-20, r+15, r+15);
  }

  void move() {
    //Clouds moving
    x-=xspeed;

    //Wrap clouds 
    if (x < -60) {
      x = width+40;
    }
  }
}
