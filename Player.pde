class Player
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
}