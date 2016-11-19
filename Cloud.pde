class Cloud
{
  private PImage _cloud;
  private float _x;
  private float _y;


  Cloud(PImage cloud, float x, float y)
  {
    _cloud = cloud;
    _x = x;
    _y = y;
  }

  public void draw()
  {
    imageMode(CENTER);
    _cloud.resize(width/15, height/15);
    image(_cloud, _x, _y);
  }

  public void move()
  {
    _y = _y - 5;
  }
}