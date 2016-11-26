class Bird
{
  private PImage _bird;
  private float _x;
  private float _y;
  private boolean _isActive; 


  Bird(PImage bird, float x, float y, boolean isActive)
  {
    _bird = bird;
    _x = x;
    _y = y;
    _isActive = isActive;
  }

  public void draw()
  {
    if(_isActive)
    {
    imageMode(CENTER);
    _bird.resize(width/15,height/15);
    image(_bird, _x, _y);
    }
  }
  
  public void move()
  {
    _y = _y - 2; 
  }
  
  public float x()
  {
    return _x;
  }

  public float y()
  {
    return _y;
  }
  
    public void kill()
  {
    _isActive = false;
  }
  
  public boolean collision()
  {
    return _isActive;
  }
 
}