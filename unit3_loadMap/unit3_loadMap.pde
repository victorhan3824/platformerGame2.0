import fisica.*;
FWorld world;

color white = #FFFFFF;
//colors used to load in map; pixilart.com; common pallette
color black = #000000;
color red   = #ed1c24;
color brown = #9c5a3c; 
color orange= #ff7e00;
color green = #a8e61d;
color Lblue = #99d9ea;
color Dblue = #4d6df3; 
color purple= #6f3198;
color grey  = #b5a5d5;

//Images used in game;
PImage ice, brick, spike, trampoline, bridge;
PImage trunk, intersect, center, west, east; //tree images

//other files
PImage map1, map2; //map Files
PImage heart;
int gridSize = 32; //size of every pixel
float zoom = 1.5; //scale factor

boolean wKey, aKey, sKey, dKey, upKey, downKey, leftKey, rightKey;
FPlayer player;

ArrayList<FGameObject> terrain;
//=============================================================================
void setup() {
  size(700,700);
  Fisica.init(this);
  map1 = loadImage("map.png");
  map2 = loadImage("map2.png");
  terrain = new ArrayList<FGameObject>();
  loadImageFiles();
  loadWorld(map2);
  loadPlayer();
}

void loadImageFiles() {
  //loadImage
  brick = loadImage("img/brick.png");
  ice = loadImage("img/blueBlock.png");
  spike = loadImage("img/spike.png");
  trunk = loadImage("img/tree_trunk.png");
  intersect = loadImage("img/tree_intersect.png");
  center = loadImage("img/treetop_center.png");
  east = loadImage("img/treetop_e.png");
  west = loadImage("img/treetop_w.png");
  trampoline = loadImage("img/trampoline.png");
  bridge = loadImage("img/bridge.png");
  
  heart = loadImage("heart.png");
  //resize image
  PImage[] P = {brick, ice, spike, trunk, intersect,
    center, east, west, heart, trampoline, bridge};
  for (int i=0; i<P.length; i++) {
    P[i].resize(gridSize, gridSize);  
  }
}

void loadPlayer() {
  player = new FPlayer(); 
  world.add(player);
}

void loadWorld(PImage map) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 980); 
  //loading the map
  for (int x=0; x<map.width; x++) {
    for (int y=0; y<map.height; y++) {
      //map.get(x, y); gets the color at pixel at this pixel number (x,y)
      // map.width & map.height --> height/width of image (ie. 50x120)
       
      //initalize box
      FBox b = new FBox(gridSize, gridSize); //intialize FBox
      b.setPosition(x*gridSize, y*gridSize); //set position of FBox
      b.setStatic(true);
      b.setFriction(0.3);
      b.setRestitution(0.1);
      
      //retrieve color
      color c = map.get(x, y); //current color
      color d = map.get(x, y+1); //color below
      color l = map.get(x-1, y); //color to the left
      color r = map.get(x+1, y); //color to the right
      
      //add in the Fboxes based on color at the pixel
      if (c == black) { //ground
        addFbox(b, brick, "brick");
        b.setFriction(1);
      }
      if (c == Lblue) { //ice
        addFbox(b, ice, "ice");
        b.setFriction(0);
      }
      if(c == grey) { //spike
        addFbox(b, spike, "spike");
      }
      if (c == purple) {
        addFbox(b, trampoline, "trampoline");
        b.setRestitution(1.5);
      }
      if (c == brown) {
        FBridge br = new FBridge(x*gridSize, y*gridSize); 
        world.add(br);
        terrain.add(br); //add into terrain arrayList to call the act funtion of FBridge class
      }
      
      addingTrees(c, d, l, r, b);
    }
  }    
}

void addingTrees(color c, color d, color l, color r, FBox box) {
  //only add trees
  if (c == orange) { //trunk
    addFbox(box, trunk, "trunk");  
  } 
  
  if (c == green && d == orange) {
    addFbox(box, intersect, "intersect");  
  } else if (c == green) {
    if (l == green && r == green) addFbox(box, center, "center"); 
    else if (l == green) addFbox(box, east, "east");
    else addFbox(box, west, "west");
  }
}

void addFbox(FBox box, PImage img, String name) {
  box.attachImage(img);
  box.setName(name);
  world.add(box);
}

//=========================================================================
void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom + width/2, -player.getY()*zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}

void draw() {
  background(0);
  drawWorld();
  actWorld();
}

void actWorld() {
  player.act();
  
  for (int i=0; i < terrain.size(); i++) {
    //acting all the terrains
    FGameObject t = terrain.get(i);
    t.act();
  }
}
