import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer song;
AudioPlayer song2;

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
  box2d.setGravity(random(-0.5,0.5),1);
  box2d.setContinuousPhysics(true);
  box2d.listenForCollisions();


  minim = new Minim(this); //Music 
  song = minim.loadFile("wind.mp3");
  song2 = minim.loadFile("CoinSoundEffect.mp3");
 
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
  img.resize(width/5, height/5);
  birdpic = loadImage("bird.png");
  birdpic.resize(width/15,height/15);
  cloudpic = loadImage("cloud.png");
  cloudpic.resize(width/15, height/15);
  coinpic = loadImage("coin.png");
  coinpic.resize(width/30, height/30);
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
    player.Update();


    lives.draw();

    for (int i = 0; i<bird.length; i++)
    {
      bird[i].Draw();
      cloud[i].Draw();
      //println(cloud[i]._x + "," + cloud[i]._y);
    }

    for (int i = 0; i<coin.length; i++)
    {
      coin[i].Draw();
    }
      
    if (lives.lives() == 0)
    {
      screen = 3;
    }
  }

  if (screen == 3)
  {
    background(0);
    fill(255, 255, 255);
    textSize(30);
    text("You Lose", 250, 250);


    fill(0, 0, 255);
    textSize(30);
    text("Score:", 250, 200);

    fill(0, 0, 255);
    textSize(30);
    text(score, 340, 200);
  }
}

void beginContact(Contact cp)
{
  println("WE HIT SOMETHING!");
  //Grab the fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  // Get both bodies from the fixtures
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  println("Collision between: " + o1.getClass() + " AND " + o2.getClass());

  boolean o1IsPlayer = o1.getClass() == Player.class;
  boolean o2IsPlayer = o2.getClass() == Player.class;

  if ( o1IsPlayer || o2IsPlayer )
  {
    int other=0;
    if (o1IsPlayer)
    {
      other = 2;
    } 
    else if (o2IsPlayer)
    {
      other = 1;
    } 
    else
    {
      println("ERROR");
    }
    
    println("Other is: " + other);
    
    if (other == 1)
    {
      println("Other is: " + o1.getClass());
      if (o1.getClass() == Bird.class)
      {
        println("This bird gonna die.");
         Bird b = (Bird)o1;
         lives.loselife();
         //b.kill();
      } 
      else if (o1.getClass() == Coin.class)
      {
        Coin c = (Coin)o1;
        score = score + 5;
        c.kill();
        c.ching();
      }
    }
    
    if (other == 2)
    {
      println("Other is: " + o2.getClass());
      if (o2.getClass() == Bird.class)
      {
        println("This bird gonna die.");
        Bird b = (Bird)o2;
        lives.loselife();
        //b.kill();
      } 
      else if (o2.getClass() == Coin.class)
      {
        Coin c = (Coin)o2;
        score = score + 5;
        c.kill();
        c.ching();
      }
    }
  }
}