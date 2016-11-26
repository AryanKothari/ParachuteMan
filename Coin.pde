class Coin
{
  private PImage _coin;
  private float _x;
  private float _y;
  private boolean _isActive;


  Coin(PImage coin, float x, float y, boolean isActive)
  {
    _coin = coin;
    _x = x;
    _y = y;
    _isActive = isActive;
  }

  public void draw()
  {
    if (_isActive)
    {
      imageMode(CENTER);
      _coin.resize(width/30, height/30);
      image(_coin, _x, _y);
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
  
  public void flyingpoints()
  {
  }
}