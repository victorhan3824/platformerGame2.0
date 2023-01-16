class FBridge extends FGameObject {
  
  FBridge(float x, float y) {
    super();
    setPosition(x, y);
    attachImage(bridge);
    setName("bridge");
    setStatic(true);
    setFriction(1);
  }
  
  void act() {
    if (this.collideWith("player")) {
      setStatic(false); 
      setSensor(true);
    }
  }
  
}
