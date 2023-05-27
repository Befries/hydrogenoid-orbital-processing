class Complex {
  
  private double re, im, mod, phase;
  
  
  // classe pour manipuler des nombres complexes
  public Complex(double re, double im) {
    this.re = re;
    this.im = im;
    calculateEuler(); 
  }
  
  
  // l'int est inutile, je veux juste un constructeur qui accepte les mod et phase
  public Complex(double mod, double phase, int a) {
    this.mod = mod;
    this.phase = phase;
    calculateReIm();
  }
  
  // calcule le module et la phase pour utiliser la forme d'euler
  private void calculateEuler() {
    // obliger d'utiliser la classe Math pour la double précision
    mod = Math.sqrt(re*re + im*im);
    phase = Math.atan(im/re);
  }
  
  
  // calcule
  private void calculateReIm() {
    // obliger d'utiliser la classe Math pour la double précision
    re = mod * Math.cos(phase);
    im = mod * Math.sin(phase);
  }
  
  
  
  public void add(Complex c) {
    re += c.re();
    im += c.im();
    calculateEuler();
  }
  
  public void mult(Complex c) {
    mod *= c.mod();
    phase += c.phase();
    calculateReIm();
  }
  
  
  // mettre le complex à une certaine puissance.
  public void pow(double a) {
    mod = Math.pow(mod, a);
    phase *= a;
  }
  
  
  //getter et setter garantissant que re, im, mod et phase reste cohérent
  public double re() {
    return re;
  }
  
  public double im() {
    return im;
  }
  
  public double mod() {
    return mod;
  }
  
  public double phase() {
    return phase;
  }
  
  public void setRe(double re) {
    this.re = re;
    calculateEuler();
  }
  
  public void setIm(double im) {
    this.im = im;
    calculateEuler();
  }
  
  public void setMod(double mod) {
    this.mod = mod;
    calculateReIm();
  }
  
  public void setPhase(double phase) {
    this.phase = phase;
    calculateReIm();
  }
  
  
  public String toString() {
    return re + " + " + im + " i  ou  " + mod + " exp(i" + phase + ")";
  }
  
}
