import shiffman.box2d.*;
PImage skybackground; 
PImage playerpic; 
PImage bird; 
PImage cloud;
Player player; 
Objects object;

void setup()
{
  skybackground = loadImage("sky.jpg");
  skybackground.resize(width,height);
  
  background(skybackground);
  size(500,500);
  playerpic = loadImage("player.png");
  bird = loadImage("bird.png");
  cloud = loadImage("cloud.png");
  
  
  player = new Player(playerpic, width/2, height/3);
  
  //for(int i = 0; i < object.length; i++)
  //{
    object = new Objects(bird, cloud, 200, 200);
 // }
}

void draw()
{
  player.draw();
  object.birddraw();
  object.clouddraw();
  
}