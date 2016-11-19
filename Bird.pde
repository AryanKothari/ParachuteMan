class Bird
{
  private PImage _bird;
  private float _x;
  private float _y;
  private boolean _point; 


  Bird(PImage bird, float x, float y, boolean point)
  {
    _bird = bird;
    _x = x;
    _y = y;
    _point = point;
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
    if(_y < height)
    {
      _y = _y - 3;
    }
    
    if(_y < 0)
    {
      _point = true;
  
    }
  }
  
  public boolean pointtrue()
  {
    return _point;
  }
 
}