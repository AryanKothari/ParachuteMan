class Coin extends Entity
{
  private PImage _coin;
  private float _x;
  private float _y;
  private boolean _isActive;
  private Body _body;


  Coin(PImage coin, float x, float y, boolean isActive)
  {
    _coin = coin;
    _x = x;
    _y = y;
    _isActive = isActive;
     CreateBody(BodyType.DYNAMIC);
     _body.setUserData(this);
  }
   private void CreateBody(BodyType bType)
  {
    //This is the scalar size of the box that we're going to create
    // we can grab these from an image OR use typical width & height of rectangle
    int imgH = _coin.height;
    int imgW = _coin.width;



    //Here we create the shape by FIRST converting the scalar size of our image
    // to box2d's WORLD size. We divide by 2 because our x,y coordinate are located
    // in the center of the image. After we have the dimensions in box2d coordinates
    // we define the shape's size by using setAsBox()
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(imgW/2);
    float box2dH = box2d.scalarPixelsToWorld(imgH/2);
    sd.setAsBox(box2dW, box2dH);


    //Fixtures are used to describe the size, shape, and material properties of an object in the 
    // physics scene. One body can have multiple fixtures attached to it, and the center of mass 
    // of the body will be affected by the arrangement of its fixtures.
    // More info: http://www.iforce2d.net/b2dtut/fixtures  (Code is in C++ but should be readable)

    //Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics check more info link for more detail
    fd.density = 0;
    fd.friction = 0.3;
    fd.restitution = 0;

    //BodyDefs are a body definition holds all the data needed to construct a rigid body. 
    // You can safely re-use body definitions. Shapes are added to a body after construction.

    //Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = bType;

    //This is where we set the initial position of the _body (entity)
    bd.position.set(box2d.coordPixelsToWorld(_x, _y));

    _body = box2d.createBody(bd);
    _body.createFixture(fd);
  }

  public void Draw()
  {
    //First we get the position of where the body is. This function will return a PVector data type. 
    // You can think of this as 1 data type that holds the x and y coordinates of our body (entity)
    // inside of it. 
    PVector pos = box2d.getBodyPixelCoordPVector(_body);
    // Get its angle of rotation from the body. This will let us know if we need to draw it rotated or not
    float a = _body.getAngle();
    if (_isActive)
    {
      imageMode(CENTER);
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(-a);
      image(_coin, 0, 0);     //We draw it at 0,0 because we've already TRANSLATED to the correct
      popMatrix();
    }// x,y using the translate function and x,y returned from box2d
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
  
  public void killbox2dbody()
  {
    box2d.destroyBody(_body);
  }
  
  public boolean _isActive()
  {
    return _isActive;
  }
  
  public void ching()
  {
    song2.play();
    song2.rewind();
    _body.setGravityScale(-1000);
  }
}