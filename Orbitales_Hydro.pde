import peasy.*;

PeasyCam cam;

// n, l, m, Z

int n = 20, l = 13, m = 4;

WaveFunction wf = new WaveFunction(n, l, m, 1);
double cursor = 0.05, epsilon = cursor/50;

//5, 3, 1: 0.05, /20 // 9, 5, 3/ 0.05 / 20  // 4, 2, 1: 0.05 / 20 // 4, 2, 2, 0.3, /3

ArrayList<PVector> points = new ArrayList<PVector>(), strength = new ArrayList<PVector>();
double thetaStep = 0.002, rStep = 0.0003, phiStep = 0.4;
double rMax = 1;
float zoom = 1000;

double amplificationFactor = 10000;
  
void setup() {
  
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 50);
  colorMode(HSB, 100, 100, 100);
  
  for (double theta = 0; theta <= PI/2; theta += thetaStep) {
    for (double r = 0; r <= rMax; r += rStep) {
      Complex evaluation = wf.evaluateWaveFunction(r, theta, 0);
      if (evaluation.mod() > cursor - epsilon && evaluation.mod() < cursor + epsilon) {
        for (double phi = 0; phi < 2*PI; phi += phiStep) {
          points.add(new PVector((float)r * cos((float)phi) * sin((float)theta) * zoom, (float) r * sin((float)phi) * sin((float)theta) * zoom,(float) r * cos((float)theta) * zoom));
          strength.add(new PVector(100, modFloat((float) (m * phi), 2*PI) * 100 / (2*PI)));
          // (float) (evaluation.mod() * amplificationFactor)
          points.add(new PVector((float)r * cos((float)phi) * sin((float)(PI - theta)) * zoom, (float) r * sin((float)phi) * sin((float)(PI - theta)) * zoom,(float) r * cos((float)(PI - theta)) * zoom));
          strength.add(new PVector(100, modFloat((float) (m * phi), 2*PI) * 100 / (2*PI)));
          // (float) (evaluation.mod() * amplificationFactor)
        }
      }
    }
  }
  
  println("done");
  
  translate(width/2, height/2);
  background(0);
  noFill();
  
  println(points.size());
  
  cam.lookAt(0, 0, 0);
  
  print(cam.getLookAt()[0], cam.getLookAt()[1], cam.getLookAt()[2]);
  noFill();
  strokeWeight(2);
  
}


void draw() {
  
  background(0);
  
  for (int i = 0; i < points.size(); i++) {
    PVector f = strength.get(i);
    stroke(f.y, 100, f.x);
    PVector p = points.get(i);
    point(p.x, p.y, p.z);
  }
  
}



private float modFloat(float f, float mod) {
  return (f < abs(mod)) ? f: modFloat(f - abs(mod), mod);
}


void keyPressed() {
  if (key == 'p') saveFrame("orb.png");
}
