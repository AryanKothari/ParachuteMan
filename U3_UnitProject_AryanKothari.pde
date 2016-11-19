import shiffman.box2d.*;
PImage skybackground; 
PImage playerpic; 
PImage birdpic; 
PImage cloudpic;
boolean point = false;
int screen = 0;
int score = 0;
Player player; 
Bird[] bird = new Bird[1000];
Cloud[] cloud = new Cloud[1000];
void setup()
{
  skybackground = loadImage("sky.jpg");
  skybackground.resize(width, height);

  background(skybackground);
  size(500, 500);

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


  playerpic = loadImage("player.png");
  birdpic = loadImage("bird.png");
  cloudpic = loadImage("cloud.png");

  imageMode(CENTER);
  image(birdpic, 100, 380, 150, 150);

  imageMode(CENTER);
  image(cloudpic, 350, 380, 150, 150);


  player = new Player(playerpic, width/2, height/3);

  for (int i = 0; i<bird.length; i++)
  {

    bird[i] = new Bird(birdpic, int(random(0, width)), random(1500, 300000), point);
    cloud[i] = new Cloud(cloudpic, int(random(0, width)), random(200, 300000));
  }
}

void draw()
{
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
    text(score, 190, 260);
    
    player.draw();
    player.move();
    for (int i = 0; i<bird.length; i++)
    {
      bird[i].draw();
      bird[i].move();
      cloud[i].draw();
      cloud[i].move();

      if (bird[i].pointtrue())
      {
        score = score + 1;
      }
    }
  }
}