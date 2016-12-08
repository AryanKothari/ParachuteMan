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
    _lives = lives;
  }

  public void draw()
  {
    fill(0, 0, 255);
    textSize(30);
    text("Lives:", width/8.33, height/10);

    fill(0, 0, 255);
    textSize(30);
    text(_lives, width/3.33, height/10);
  }
  
  public void loselife()
  {
    _lives = _lives - 1;
  }
  
  public int lives()
  {
    return _lives;
  }
}