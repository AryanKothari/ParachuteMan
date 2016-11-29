  class Player extends Entity
{

  private PImage _player;
  private float _x;
  private float _y;

  Player(PImage playerpic, float x, float y)
  {
    _player = playerpic;
    _x = x;
    _y = y;
  }

  public void draw()
  {
    imageMode(CENTER);
    image(_player, _x, _y, width/5, height/5);

  }

  public void move()
  {
    _x = mouseX;
  }
  
  public float x()
  {
    return _x;
  }
  
    public float y()
  {
    return _y;
  }
}