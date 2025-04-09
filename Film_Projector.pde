// Projector Sketch – Test 3 Update

float angle = 0;
boolean isPlaying = false;
color reelColor;
boolean flash = false;

void setup() {
  size(500, 500);
  background(30);
  noFill();
  reelColor = color(200, 50, 50); // Set static reel color
  frameRate(30);
  rectMode(CENTER);
}

void draw() {
  background(30);
  drawProjector();
  drawMovieReel();
  drawDynamicShapes();
  drawOldFilmPattern(); // Adding the old film pattern

  if (isPlaying) {
    angle += 0.05; // Continuous rotation when playing
    flash = frameCount % 10 < 5; // Toggle flashing effect (on/off every 5 frames)
  }
}

void drawProjector() {
  // Projector body
  fill(50);
  rect(250, 320, 200, 100, 20);

  // Light beam centered (flashing)
  noStroke();
  if (flash) {
    fill(255, 255, 150, 100);  // Light beam color when flashing
  } else {
    fill(255, 255, 150, 50);   // Dim light beam when not flashing
  }
  triangle(350, 300, 500, 220, 500, 380);

  // Flashing square effect in the middle of the light beam
  if (flash) {
    fill(255);  // Flashing square when flashing
  } else {
    fill(0);    // Square disappears when not flashing
  }
  rect(322, 300, 50, 30);

  // Lens (flashing)
  if (flash) {
    fill(200);  // Lens color when flashing
  } else {
    fill(150);  // Dim lens when not flashing
  }
  ellipse(350, 300, 50, 30);

  // Projector legs (brown)
  fill(139, 69, 19); // Brown color
  rect(170, 406, 20, 80); // Left leg
  rect(340, 406, 20, 80); // Right leg
}

void drawMovieReel() {
  float reelSize = 80;
  drawReel(150, 240, reelSize); // Left reel
  drawReel(350, 240, reelSize); // Right reel
}

void drawReel(float x, float y, float size) {
  stroke(255);
  strokeWeight(3);
  fill(reelColor);
  ellipse(x, y, size, size); // Outer circle

  pushMatrix();
  translate(x, y);
  rotate(angle);
  fill(100);
  rect(0, 0, size * 0.5, size * 0.5); // Inner rotating square

  for (int i = 0; i < 8; i++) { // Perforations
    float a = TWO_PI / 8 * i;
    float px = cos(a) * (size * 0.35);
    float py = sin(a) * (size * 0.35);
    fill(255);
    ellipse(px, py, size * 0.1, size * 0.1);
  }
  popMatrix();
}

void drawDynamicShapes() {
  for (int i = 0; i < 9; i++) {
    float angleOffset = i * TWO_PI / 7;
    float angle = frameCount * -0.05 + angleOffset;
    float x = sin(angle) * 165 + width / 2;
    float y = cos(angle) * 165 + height / 2;

    float size = 20; // Small fixed-size circles

    fill(200); // Light gray fill (optional, or remove for transparent center)
    stroke(192); // Silver stroke
    strokeWeight(3);
    ellipseMode(CENTER);
    ellipse(x, y, size, size);
  }
}


  


void drawOldFilmPattern() {
  // Film perforations (top & bottom)
  stroke(255, 255, 255, 50);
  for (float x = 0; x < width; x += 60) {
    for (float y = 0; y < 10; y += height - 10) {
      fill(255, 255, 255, 120);
      ellipse(x, y, 10, 10); // Top
      ellipse(x, y + height, 10, 10); // Bottom
    }
  }

  // Scratches
  for (int i = 0; i < 5; i++) {
    float y = random(0, height);
    float len = random(200, 200);
    stroke(255, 255, 255, 80);
    line(random(0, width - len), y, random(len, width), y);
  }

  // Faded edges
  noFill();
  stroke(255, 255, 255, 30);
  ellipse(width / 2, height / 2, width, height);
  ellipse(width / 2, height / 2, width * 0.9, height * 0.9);

  // Noise (dust/dots)
  for (int i = 0; i < 30; i++) {
    float x = random(width);
    float y = random(height);
    stroke(255, 255, 255, 100);
    point(x, y);
  }
}

void mousePressed() {
  isPlaying = !isPlaying; // Toggle play/pause on mouse click
}
