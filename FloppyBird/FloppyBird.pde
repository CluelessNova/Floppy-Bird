import processing.sound.*;
SoundFile jump;
SoundFile pointUp;
SoundFile hit;
SoundFile music;

Bird bird;
Cloud[] clouds = new Cloud[5];
ArrayList<Pipes> pipes = new ArrayList<Pipes>();
int score;
int counter;
int pScore;
int highscore = 0;
boolean startGame = false;
boolean dead = false;
boolean reset = false;


void setup() {

  size(480, 640);

  //surface.setLocation(50, 50);

  bird = new Bird();

  //Variables
  score = 0;
  counter = 0;

  //Initializing clouds
  for (int c = 0; c < clouds.length; c++) {
    clouds[c] = new Cloud(random(width), random(height/3), random(30, 50));
  }

  //Audio Clips
  jump = new SoundFile(this, "JumpSound.wav");
  pointUp = new SoundFile(this, "PointUp.wav");
  hit = new SoundFile(this, "Hit.wav");
  music = new SoundFile(this, "8BitMusic.wav");
  music.loop();
}

void draw() {
  background(0, 0, 255);
  

  //Sun
  noStroke();
  fill(255, 255, 0);
  ellipse(400, 70, 75, 75);


  //Clouds
  for (int c = 0; c < clouds.length; c++) {
    clouds[c].display();
    clouds[c].move();
  }

  //When the framecounter reaches a divisible by 400, create a new pipe in the arraylist
  if (counter % 400 == 0)
  {
    pipes.add(new Pipes());
  }

  if (startGame == true) {
    //Pipes
    for (int p = 0; p < pipes.size(); p++) {

      Pipes pipe = pipes.get(p);
      pipe.display();
      pipe.move();
      if (pipe.checkHit(bird)) {
        // println("HIT");
        pipe.c = color(255, 0, 0);
        dead = !dead;
        hit.play();
      } else {
        pipe.c= color(0, 255, 0);
      }
      //If the bird makes it through the pipes, add 1 score
      if (pipe.goal(bird)) {
        //println("GOAL");
        score++;
        pointUp.play();
      }
      //If the bird hits a pipe, create the end screen
      if (dead == true) {
        pipe.xspeed = 0;
        pipe.xpos = -100;
        reset = !reset;
        if (reset == true) {
        }
      }
    }
  }


  //Score
  if (startGame == true) {
    String scoreT = " ";
    fill(0);
    textSize(75);
    text(scoreT+score, 200, 50, 200, 200);
  }

  //Ground
  fill(135, 85, 22);
  rectMode(CORNER);
  rect(0, height-30, width, height);

  //Bird
  bird.display();
  bird.gravity();
  counter ++;


  //Highscore function

  //Creates a new variable 
  pScore = score;

  //If the previous score value is either greater than or equal to the highscor
  //Make the previous score value the new highscore value

  if (pScore >= highscore) {
    highscore = pScore;
  }



  //End screen
  if (startGame == true) {
    if (dead == true) {
      music.pause();
      
      bird.ypos = 0;
      bird.gravity = .1;
      bird.velocity = 0;
      bird.jump = -5;
      fill(0);
      rect(0, 0, width, height);

      //Score from previous game
      String pScoreT = "Previous Score: ";
      fill(255);
      textSize(30);
      text(pScoreT+pScore, 125, 50, 250, 200);

      //Highscore from current run
      String highscoreT = "Highscore: ";
      fill(255);
      textSize(30);
      text(highscoreT+highscore, 150, 150, 200, 200);



      //What button to press to play again

      if ((mouseX > 173) && (mouseX < 307) && (mouseY < 345) && (mouseY > 298)) {
        stroke(255);
        strokeWeight(2);
        rectMode(CENTER);
        fill(200, 0, 0, 200);
        rect(width/2, height/2, 135, 50);

        String Restart = "RESTART";
        fill(255);
        textSize(30);
        text(Restart, 250, 320, 150, 50);

        if (mousePressed) {
          music.play();
          reset = !reset;
          dead = !dead;
          pipes.remove(0);
          score = 0;
        }
      } else {
        stroke(255);
        strokeWeight(2);
        rectMode(CENTER);
        fill(200, 0, 00, 100);
        rect(width/2, height/2, 135, 50);

        String Restart = "RESTART";
        fill(255);
        textSize(30);
        text(Restart, 250, 320, 150, 50);
      }
    }
  }

  //Only shows the start screen once
  if (startGame == false) {
    beginScreen();
  }
  println(mouseX, mouseY);
}

void keyPressed() {
  //Make bird jump
  if (key == ' ') {
    bird.jump();
    jump.play();
  }
}


//Start Screen
void beginScreen() {

  //Starts the screen 
  if (startGame == false) {

    //Pipes
    for (int g = 0; g < pipes.size(); g++) {

      Pipes pipe = pipes.get(g);
      pipe.display();
      pipe.move();
      if (pipe.checkHit(bird)) {
        // println("HIT");
        pipe.c = color(255, 0, 0);
      } else {
        pipe.c= color(0, 255, 0);
      }
    }
  }

  //Creates a random jump generator
  if (counter % 35 == 0) {
    bird.jump();
    bird.jump = random(-5, -1);
  }

  //What buttom to press to jump 
  String controlsT = "To Jump: Press SPACE";
  fill(50, 250, 150);
  textSize(30);
  text(controlsT, 80, 300, 400, 300);

  //The start button
  if ((mouseX > 188) && (mouseX < 293) && (mouseY >193) && (mouseY <240)) {
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    fill(50, 250, 150, 200);
    rect(width/2, height/3, 105, 50);

    String startT = "START";
    fill(0);
    textSize(30);
    text(startT, 250, 220, 120, 50);

    if (mousePressed) {
      startGame = !startGame;
      bird.jump = -5;
      pipes.remove(0);
    }
  } else {
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    fill(50, 250, 150, 100);
    rect(width/2, height/3, 105, 50);

    String startT = "START";
    fill(0);
    textSize(30);
    text(startT, 250, 220, 120, 50);
  }

  //Ground
  fill(135, 85, 22);
  rectMode(CORNER);
  rect(0, height-30, width, height);
}
