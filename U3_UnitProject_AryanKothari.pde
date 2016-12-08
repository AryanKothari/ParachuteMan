/*
Hey Friends! This is my Parachute Man Project. The goal of this game is to collect the coins
while at the same time making sure to dodge the birds! Also remember use the clouds as an obstacle!
Good Luck
- Aryan Kothari
*/
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
AudioPlayer ouch;

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
int health = 3;
float s = second();
Player player; 
Bird[] bird = new Bird[400];
Cloud[] cloud = new Cloud[400];
ArrayList<Coin> coins = new ArrayList<Coin>();
Lives lives; 
void setup()
{
  skybackground = loadImage("sky.jpg");
  skybackground.resize(width, height);

  background(skybackground);
  size(500, 500);


  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 1);
  box2d.setContinuousPhysics(true);
  box2d.listenForCollisions();


  minim = new Minim(this); //Music 
  song = minim.loadFile("wind.mp3");
  song2 = minim.loadFile("CoinSoundEffect.mp3");
  ouch = minim.loadFile("Ouch.mp3");

  fill (0, 0, 100);
  textSize(50);
  text("Parachute Man", width/9.09, height/5);

  fill (0, 0, 0);
  textSize(20);
  text("Created by Aryan Kothari", width/2, height/1.04);

  fill(0, 255, 0); //play
  rect(width/3.33, height/3.33, width/3.33, height/10);

  fill(0, 255, 0); //quit
  rect(width/3.33, height/2.27, width/3.33, height/10);

  fill(0, 0, 255);
  textSize(30);
  text("Play now!", width/3.22, height/2.63);

  fill(0, 0, 255);
  textSize(30);
  text("Quit", width/2.63, height/1.92);

//changing and uploading pics
  img = loadImage("player.png");
  img.resize(width/5, height/5);
  birdpic = loadImage("bird.png");
  birdpic.resize(width/15, height/15);
  cloudpic = loadImage("cloud.png");
  cloudpic.resize(width/15, height/15);
  coinpic = loadImage("coin.png");
  coinpic.resize(width/30, height/30);
  heartpic = loadImage("heart.png");

  imageMode(CENTER);
  image(birdpic, width/5, height/1.31, width/3.33, height/3.33);

  imageMode(CENTER);
  image(cloudpic, width/1.43, height/1.32, width/3.33, height/3.33);


  player = new Player(width/2, height/3, img);
  lives = new Lives(heartpic, width/1.42, height/10, health);

  for (int i = 0; i<bird.length; i++) //Coding the classes 
  {

    bird[i] = new Bird(birdpic, int(random(0, width)), random(height/0.2, height/0.0016), point);
    cloud[i] = new Cloud(cloudpic, int(random(0, width)), random(height/2.5, height/0.0016));
  }

  for (int i =0; i < 200; i++)
  {
    coins.add(new Coin(coinpic, int(random(0, width)), random(height/0.5, height/0.0016), isActive));
  }
}

void draw()
{

  box2d.step();

  if (screen == 0 && mousePressed && mouseX > width/3.33 && mouseX < width/1.66 && mouseY > height/3.33 && mouseY < height/2.5) //Play button/Go to game
  {
    screen = 1;
    song.play();
    song.loop();
  }

  if (screen == 0 && mousePressed && mouseX > width/3.33 && mouseX < width/1.66 && mouseY > height/2.27 && mouseY < height/1.85) //Play button/Go to game
  {
    exit();
  }

  if (screen == 1)
  {
    background(skybackground);
    noCursor();


    fill(0, 0, 255);
    textSize(30);
    text("Score:", width/1.388, height/10);

    fill(0, 0, 255);
    textSize(30);
    text(score, width/1.11, height/10);

    player.Draw();
    player.Update();
    lives.draw();

    for (int i = 0; i<bird.length; i++)
    {
      bird[i].Draw();
      cloud[i].Draw();
      //println(cloud[i]._x + "," + cloud[i]._y);
    }

    for (int i = 0; i<200; i++)
    {
      coins.get(i).Draw();
    }

    if (lives.lives() == 0)
    {
      screen = 3;
    }
  }

  if (screen == 3) //losing screen
  { 
    background(0);
    song.pause();
    fill(255, 255, 255);
    textSize(30);
    text("You Lose", width/2, height/2);


    fill(0, 0, 255);
    textSize(30);
    text("Score:", width/2, height/2.5);

    fill(0, 0, 255);
    textSize(30);
    text(score, width/1.47, height/2.5);

    if (keyCode == ENTER) //restart button
    {
      screen = 1;
      box2d.setGravity(0, 1);
      score = 0;
      health = 3;
    }
  }
}

void beginContact(Contact cp) //start of collision code using box2d
{
  if (screen == 1)
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
      } else if (o2IsPlayer)
      {
        other = 1;
      } else
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
          b.ouch();
          Vec2 wind = new Vec2(10, 0);
          b.applyForce(wind);
        } else if (o1.getClass() == Coin.class)
        {
          if (s > 1)
          {
            Coin c = (Coin)o1;
            score = score + 5;
            c.kill();
            c.ching();
            s = second();
            // c.killbox2dbody();
          }
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
          b.ouch();
          Vec2 wind = new Vec2(10, -20);
          b.applyForce(wind);
        } else if (o2.getClass() == Coin.class)
        {
          Coin c = (Coin)o2;
          if (s > 1)
          {
            score = score + 5;
            c.kill();
            c.ching();
            s = second();
          }
        }
      }
    }
  }
}