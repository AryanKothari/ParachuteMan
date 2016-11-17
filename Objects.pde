class Objects
{
  private PImage _bird;
  private PImage _cloud;
  private float _x;
  private float _y; 

  Objects(PImage bird, PImage cloud, float x, float y)
  {
    _bird = bird;
    _cloud = cloud;
    _x = x;
    _y = y;
  }

  public void birddraw()
  {
    imageMode(CENTER);
    image(_bird, _x, _y, width/10, height/10);
  }

  public void clouddraw()
  {
    imageMode(CENTER);
    image(_cloud, _x + 20, _y + 20, width/10, height/10);
  }
}