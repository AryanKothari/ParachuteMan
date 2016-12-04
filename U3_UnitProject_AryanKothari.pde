import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer song;

Box2DProcessing box2d;
PImage skybackground; 
PImage img; 
PImage birdpic; 
PImage cloudpic;
PImage coinpic;
PImage heartpic;
boolean point = true;
boolean flyingpoints;
boolean isActive = true;
int screen = 0;
int score = 0;
Player player; 
Bird[] bird = new Bird[400];
Cloud[] cloud = new Cloud[400];
Coin[] coin = new Coin[200];
Lives lives; 
void setup()
{
  skybackground = loadImage("sky.jpg");
  skybackground.resize(width, height);

  background(skybackground);
  size(500, 500);
  
 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
 box2d.setGravity(0, -5);
  box2d.setContinuousPhysics(true);
  

  minim = new Minim(this); //Music 
  song = minim.loadFile("wind.mp3");
  song.loop();

  fill (0, 0, 100);
  textSize(50);
  text("Parachute Man", 55, 100);

  fill (0, 0, 0);
  textSize(20);
  text("Created by Aryan Kothari", 250, 480);

  fill(0, 255, 0); //play
  rect(150, 150, 150, 50);

  fill(0, 255, 0); //quit
  rect(150, 220, 150, 50);

  fill(0, 0, 255);
  textSize(30);
  text("Play now!", 155, 190);

  fill(0, 0, 255);
  textSize(30);
  text("Quit", 190, 260);


  img = loadImage("player.png");
  img.resize(width/5,height/5);
  birdpic = loadImage("bird.png");
  cloudpic = loadImage("cloud.png");
  cloudpic.resize(width/15,height/15);
  coinpic = loadImage("coin.png");
  heartpic = loadImage("heart.png");

  imageMode(CENTER);
  image(birdpic, 100, 380, 150, 150);

  imageMode(CENTER);
  image(cloudpic, 350, 380, 150, 150);


  player = new Player(width/2, height/3, img);
  lives = new Lives(heartpic, 350, 50, 3);

  for (int i = 0; i<bird.length; i++)
  {

    bird[i] = new Bird(birdpic, int(random(0, width)), random(1500, 300000), point);
    cloud[i] = new Cloud(cloudpic, int(random(0, width)), random(200, 300000));
  }

  for (int i = 0; i < coin.length; i++)
  {
    coin[i] = new Coin(coinpic, int(random(0, width)), random(200, 300000), isActive);
  }
}

void draw()
{
  
  box2d.step();
  
  if (screen == 0 && mousePressed && mouseX > 150 && mouseX < 300 && mouseY > 150 && mouseY < 200) //Play button/Go to game
  {
    screen = 1;
  }

  if (screen == 0 && mousePressed && mouseX > 150 && mouseX < 300 && mouseY > 220 && mouseY < 270) //Play button/Go to game
  {
    exit();
  }

  if (screen == 1)
  {
    background(skybackground);


    fill(0, 0, 255);
    textSize(30);
    text("Score:", 360, 50);

    fill(0, 0, 255);
    textSize(30);
    text(score, 450, 50);

    player.Draw();


    lives.draw();

    for (int i = 0; i<bird.length; i++)
    {
      bird[i].draw();
      bird[i].move();
      cloud[i].Draw();
      cloud[i].move();
    }

    for (int i = 0; i<coin.length; i++)
    {
      coin[i].draw();
      coin[i].move();
      if (player.x() < coin[i].x() + width/30 && player.x() + width/5 > coin[i].x() 
        && player.y() < coin[i].y() + height/30 && height/5 + player.y() > coin[i].y())
      {
        if (coin[i].collision())
        {
          score = score + 5;

          int LastTime = millis();
          flyingpoints = true;
          if(flyingpoints)
          {
          fill(255,0,0);
          textSize(30);
          text("5", coin[i].x(), coin[i].y());
          }
          
          if(LastTime - millis() > 5)
          {
            flyingpoints = false;
          }
          
          coin[i].kill();
        }
      }
    }

    for (int i = 0; i<bird.length; i++)
    {
      if (player.x() < bird[i].x() + width/15 && player.x() + width/5 > bird[i].x() 
        && player.y() < bird[i].y() + height/15 && height/5 + player.y() > bird[i].y())
      {
        if (bird[i].collision())
        {
          lives.loselife();
        }
        bird[i].kill();
      }
    }
    
    if(lives.lives() == 0)
    {
      screen = 3;
    }
  }
  
  if(screen == 3)
  {
    background(0);
    fill(255,255,255);
    textSize(30);
    text("You Lose", 250, 250);
  }
}