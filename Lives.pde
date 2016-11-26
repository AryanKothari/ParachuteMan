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
    text("Lives:", 60, 50);

    fill(0, 0, 255);
    textSize(30);
    text(_lives, 150, 50);
  }
  
  public void loselife()
  {
    _lives = _lives - 1;
  }
}