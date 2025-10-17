// === Passive Transport + Chemotaxis (Run Away from Mouse) ===
// All randomness uses Math.random(); no random() or ? operators used.

Particle[] molecules;
int numMolecules = 120;

// Membrane and channel
float membraneY;
float channelX, channelWidth, channelHeight;

void setup() {
  size(800, 400);
  membraneY = height / 2;
  channelX = width / 2 - 25;
  channelWidth = 50;
  channelHeight = 120;

  molecules = new Particle[numMolecules];

  for (int i = 0; i < molecules.length; i++) {
    float y;
    if (i < numMolecules / 2) {
      y = (float)(Math.random() * (membraneY - 100));
    } else {
      y = (float)(Math.random() * (height - (membraneY + 50)) + (membraneY + 50));
    }
    float x = (float)(Math.random() * width);
    molecules[i] = new Particle(x, y);
  }
}

void draw() {
  background(15, 170, 200);

  // Membrane
  noStroke();
  fill(180, 240, 255);
  rect(0, membraneY - 15, width, 30);

  // Channel protein
  fill(180, 130, 255);
  rect(channelX, membraneY - channelHeight / 2, channelWidth, channelHeight, 20);

  // Title
  fill(255);
  textSize(13);
  text("Active Transport + Chemotaxis (Push the Particles from inside the Cell to Outside Through Channel Protein)", 15, 30);


  for (int i = 0; i < molecules.length; i++) {
    molecules[i].move();
    molecules[i].checkMembrane();
    molecules[i].display();
  }
}


class Particle {
  float x, y;
  color c;

  Particle(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    c = color((int)(Math.random() * 155 + 100),
              (int)(Math.random() * 155 + 100),
              (int)(Math.random() * 255));
  }

  void move() {
    
    float stepX = (float)(Math.random() * 2 - 1); // -1 to 1
    float stepY = (float)(Math.random() * 2 - 1);

    
    float dx = x - mouseX;
    float dy = y - mouseY;
    float d = sqrt(dx * dx + dy * dy);

    
    if (d < 100) {
      float mag = sqrt(dx * dx + dy * dy);
      if (mag != 0) {
        dx = dx / mag;
        dy = dy / mag;
      }
      stepX += dx * 1.5;
      stepY += dy * 1.5;
    }

    x += stepX;
    y += stepY;

   
    if (x < 0) x = width;
    if (x > width) x = 0;
    if (y < 0) y = 0;
    if (y > height) y = height;
  }

  void checkMembrane() {
    
    if (Math.abs(y - membraneY) < 15 && (x < channelX || x > channelX + channelWidth)) {
      if (y < membraneY) {
        y -= 2;
      } else {
        y += 2;
      }
    } 
    
    else if (x > channelX && x < channelX + channelWidth) {
      if (y < membraneY - channelHeight / 2) {
        y += (float)(Math.random() * 1.0 + 0.5);
      }
      if (y > membraneY + channelHeight / 2) {
        y -= (float)(Math.random() * 1.0 + 0.5);
      }
    }
  }

  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, 8, 8);
  }
}
