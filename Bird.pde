class Bird
{
  private PImage _bird;
  private float _x;
  private float _y;


  Bird(PImage bird, float x, float y)
  {
    _bird = bird;
    _x = x;
    _y = y;
  }

  public void draw()
  {
    imageMode(CENTER);
    _bird.resize(width/15,height/15);
    image(_bird, _x, _y);
  }
  
  public void move()
  {
    _y = _y - 5; 
  }
}