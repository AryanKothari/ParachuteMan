class Lives
{
  private PImage _heart;
  private float _x;
  private float _y;
  private int _lives;

  Lives(PImage heart, float x, float y, int lives)
  {
    _heart = heart;
    _x = x;
    _y = y;
  }

  public void draw()
  {
    if(_lives == 3)
    {
    imageMode(CENTER);
    _heart.resize(width/15, height/15);
    image(_heart, _x, _y);
    imageMode(CENTER);
    _heart.resize(width/15, height/15);
    image(_heart, _x + 10, _y);
    imageMode(CENTER);
    _heart.resize(width/15, height/15);
    image(_heart, _x + 20, _y);
    }
  }
}