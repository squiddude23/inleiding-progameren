int score = 0;  
int lives = 3;  
float baseSpeed = 2;
float maxSpeed = 5;   // maximale snelheid (pas aan om moeilijkheid te veranderen)
float speedGrowth = 0.2; // bepaalt hoe snel de ballen sneller gaan bij hogere score

int RectW = 80;       // breedte van de paddle
ArrayList<Ball> balls; // lijst met alle actieve ballen

void setup() {
  size(500, 500);
  balls = new ArrayList<Ball>();
  balls.add(new Ball()); // start met 1 bal
}

void draw() {
  background(17, 212, 242);

  fill(144, 47, 235);
  rect(mouseX - RectW/2, 450, RectW, 30);

  // snelheid laten stijgen met score
  float speed = min(baseSpeed + score * speedGrowth, maxSpeed);

  // alle ballen updaten
  for (Ball b : balls) {
    b.update(speed);
  }

  // score en levens weergeven
  fill(0);
  textSize(20);
  text("Score: " + score, 20, 30);
  text("Lives: " + lives, 400, 30);

  // meer ballen toevoegen bij hogere scores
  if (score >= 10 && balls.size() < 2) balls.add(new Ball());
  if (score >= 20 && balls.size() < 3) balls.add(new Ball());
  if (score >= 30 && balls.size() < 4) balls.add(new Ball());

  if (lives <= 0) {
    gameOver();
  }
}

void gameOver() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("GAME OVER", width/2, height/2 - 20);
  textSize(20);
  text("Final Score: " + score, width/2, height/2 + 20);
  noLoop();
}


class Ball {
  float x, y;
  color c;
  float size = 40;

  // constructor
  Ball() {
   reset();
  }

  // update: beweegt, tekent en checkt botsingen
  void update(float spd) {
    fill(c);
    ellipse(x, y, size, size);
    y += spd; // beweeg naar beneden met huidige snelheid

    // check botsing met paddle
    if (dist(x, y, mouseX, 465) < size/2 + 15) {
      score++;
      reset();
    }

    // als de bal onderaan het scherm valt (niet gevangen)
    if (y > height) {
      lives--; // -1 leven
      reset(); // bal opnieuw spawnen
    }
  }

  // reset: zet de bal terug bovenaan met nieuwe kleur
  void reset() {
    x = random(40, width - 40);
    y = 0;
    c = color(random(255), random(255), random(255)); // willekeurige kleur
  }
}
