
class FGameObject extends FBox {

  FGameObject() {
    super(gridSize, gridSize);
  }
  
  void act() {}

  boolean collideWith(String objBeingChecked) { 
    //collsion code shared
    ArrayList<FContact> contacts = this.getContacts();
    for (int i=0; i<contacts.size(); i++) { //loop through the list
      FContact fc = contacts.get(i);
      if (fc.contains(objBeingChecked)) {
        return true;
      }
    }
    return false;
  }
}
