class FPlayer extends FGameObject{
  int lives;
  
  FPlayer() {
    //initalize location + display
    super();
    setPosition(300,0); //inital position
    setFillColor(red);
    setRotatable(false);
    setName("player");
    
    //stat initalize
    lives = 5;
  }
  
  void act() {
    moveByControl();
    statDisplay();
    
    //checking collisions
    if (this.collideWith("spike")) {
      lives --;
    }
  }
  
  void statDisplay() {
    for (int i=0; i<this.lives; i++) {
      image(heart, 500+i*32,16);  
    }
  }
  
  void moveByControl() {
    float vx = this.getVelocityX();
    float vy = this.getVelocityY();
    if (aKey) setVelocity(-300, vy);
    if (dKey) setVelocity(300,  vy);
    if (wKey) setVelocity(vx, -300);
    if (sKey) setVelocity(vx, 300);
  }
}
