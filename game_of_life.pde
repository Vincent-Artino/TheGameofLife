int rows, columns;
int i, j;
boolean grid[][];
int minSide;
int resolution = 1 ;
int frame = 0;
PFont font;
int IntroLineLength;
int IntroLineOffset = 5;
int b = 5;
int rand;
void setup() {
  fullScreen(P2D);
  //size(600, 800);
  //minSide = width < height? width: height;
  columns  = width/resolution;
  rows = height/resolution;
  grid = new boolean[columns][rows];
  rand = 30;
  createInitial();
  rectMode(CORNER);
  //  frameRate(1);
  println(columns, rows);
  IntroLineLength = width/30;
}
void draw() {
  background(255);
  if (frame == 0)
    intro();
  else if (frame == 2)
    drawGrid();
  else if (frame == 3)
    quit();
}

void createInitial() {
  for (i=0; i<columns; i++) {
    for (j=0; j<rows; j++) {
      grid[i][j] = int(floor(random(rand))) == 0 ? true:false;
    }
  }
}

void quit() {
  background(0, 100);
  text("Do you want to Quit?", width/2, height/3);
  text("Yes", width/3, height/2 + textAscent() * 3);
  text("No", 2*width/3, height/2 + textAscent() * 3);
  switch(b) {
  case 4: 
    createLines("Yes", width/3, height/2 + 3* textAscent());
    break;  
  case 5: 
    createLines("No", 2*width/3, height/2 + 3* textAscent());
    break;
  }
}

void intro() {
  background(0);
  font = createFont("Verdana-48.vlw", 48);
  textFont(font);
  textAlign(CENTER, CENTER);
  text("THE GAME OF LIFE", width/2, height/4);
  textSize(24);
  text("Start Random Game", width/2, height/2);
  text("Create New Game", width/2, height/2 + 3*   textAscent());
  text("Quit", width/2, height/2 + 6 * textAscent());
  switch(b) {
  case 1: 
    createLines("Start Random Game", width/2, height/2);
    break;
  case 2 : 
    createLines("Create New Game", width/2, height/2 + 3* textAscent());
    break;
  case 3: 
    createLines("Quit", width/2, height/2 + 6* textAscent());
    break;
  }
}

void mouseMoved() {
  if (frame == 0) {
    if (checkInRect(mouseX, mouseY, width/2 - textWidth("Start Random Game")/2, height/2 - textAscent()/2, textWidth("Start Random Game"), textAscent())) {
      createLines("Start Random Game", width/2, height/2);
      b = 1;
    }
    if (checkInRect(mouseX, mouseY, width/2 - textWidth("Create New Game")/2, height/2 + 3* textAscent()- textAscent()/2, textWidth("Create New Gam"), textAscent())) {
      createLines("Create New Game", width/2, height/2 + 3* textAscent());
      b = 2;
    }  
    if (checkInRect(mouseX, mouseY, width/2 - textWidth("Quit")/2, height/2 + 6* textAscent()- textAscent()/2, textWidth("Create New Gam"), textAscent())) {
      createLines("Quit", width/2, height/2 + 6* textAscent());
      b = 3;
    }
  }

  if (frame == 3) {
    if (checkInRect(mouseX, mouseY, width/3 - textWidth("Yes")/2, height/2 + textAscent() * 3 - textAscent()/2, textWidth("Yes"), textAscent())) {
      createLines("Yes", width/3, height/2 + 3* textAscent());
      b = 4;
    }
    if (checkInRect(mouseX, mouseY, 2*width/3 - textWidth("No")/2, height/2 + textAscent() * 3 - textAscent()/2, textWidth("No"), textAscent())) {
      createLines("No", 2*width/3, height/2 + 3* textAscent());
      b = 5;
    }
  }
}

void mousePressed() {
  if (frame == 0) {
    if (checkInRect(mouseX, mouseY, width/2 - textWidth("Start Random Game")/2, height/2 - textAscent()/2, textWidth("Start Random Game"), textAscent())) {
      stroke(0);
      frame = 2;
    }
    if (checkInRect(mouseX, mouseY, width/2 - textWidth("Create New Game")/2, height/2 + 3* textAscent()- textAscent()/2, textWidth("Create New Gam"), textAscent())) {
      frame = 1;
    }  
    if (checkInRect(mouseX, mouseY, width/2 - textWidth("Quit")/2, height/2 + 6* textAscent()- textAscent()/2, textWidth("Create New Gam"), textAscent())) {
      frame = 3;
    }
  }
  if (frame == 3) {
    if (checkInRect(mouseX, mouseY, width/3 - textWidth("Yes")/2, height/2 + textAscent() * 3 - textAscent()/2, textWidth("Yes"), textAscent())) {
      exit();
    }
    if (checkInRect(mouseX, mouseY, 2*width/3 - textWidth("No")/2, height/2 + textAscent() * 3 - textAscent()/2, textWidth("No"), textAscent())) {
      frame = 0;
    }
  }
}

// function to check if a coordinate is present in a rectangle
boolean checkInRect(float x, float y, float rectx, float recty, float rectLength, float rectBreadth) {
  if (x > rectx && x < rectx + rectLength && y > recty && y < recty + rectBreadth)
    return true;
  else
    return false;
}

void createLines(String text, int x, float y) {
  stroke(255);
  // strokeWeight(1);
  line(x- textWidth(text)/2 - IntroLineLength, y, x - textWidth(text)/2 - IntroLineOffset, y);
  line(x + textWidth(text)/2 + IntroLineLength, y, x + textWidth(text)/2 + IntroLineOffset, y);
}

void drawGrid() {
  //  translate((width-minSide)/2, (height-minSide)/2);
  for (i=0; i<columns; i++) {
    for (j=0; j<rows; j++) {
      //println(i, j); 
      if (grid[i][j]) {
        fill(0);
        rect(resolution*i, resolution*j, resolution, resolution);
        if (!check(i, j, true))
          grid[i][j] = false;
      } else {
        fill(255);
        rect(resolution*i, resolution*j, resolution, resolution);   
        if (check(i, j, false))
          grid[i][j] = true;
      }
    }
  }
}

boolean check(int a, int b, boolean alive) {
  int n = 0;
  if (alive) {
    for (int y = -1; y < 2; y++) {
      for (int x= -1; x < 2; x++) {
        if (a+y < 0|| b + x < 0 || a + y >= columns || b + x>= rows || x + y == 0)
          continue;
        else if (grid[a+y][b+x])
          n++;
      }
    }
    if (n==2 || n==3)
      return true;
    else 
    return false;
  } else {
    for (int y = -1; y < 2; y++) {
      for (int x= -1; x < 2; x++) {
        if (a+y < 0|| b + x < 0 || a + y >= columns || b + x>= rows)
          continue;
        else if (grid[a+y][b+x])
          n++;
      }
    }
    if (n==3)
      return true;
    else 
    return false;
  }
}
