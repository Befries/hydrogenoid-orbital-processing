class WaveFunction {
  
  // les premiers polynomes de Laguerre et Legendre, utilise p0 comme le polynome x
  private final double [] P0_C = {1}, P1_C = {0, 1};
  private final Polynom p0 = new Polynom(P0_C), p1 = new Polynom(P1_C);
  
  private int n, l, m, z;
  private double YConstant, RConstant;
  
  public static final double a_0 = 0.001;
  
  // fonction de legendre;
  private Polynom Pml, Lnl;
  
  
  public WaveFunction(int n, int l, int m, int z) {
    
    this.n = n;
    this.l = l;
    this.m = m;
    this.z = z;
    
    generateLegendreFunction();
    initializeYConstant();
    
    generateLaguerreFunction();
    initializeRConstant();
    
  }
  
  
  public Complex evaluateWaveFunction(double r, double theta, double phi) {
    Complex res = evaluateY(theta, phi);
    res.mult(evaluateR(r));
    return res;
  }
  
  
  private void generateLegendreFunction() {
    Pml = getLegendre(l).getNDerivative(abs(m));
  }
  
  
  private void generateLaguerreFunction() {
    Lnl = getGeneralisedLaguerre(n - l - 1, 2 *l + 1);
  }
  
  private void initializeRConstant() {
    RConstant = (2 * Math.pow(Z/a_0, 3/2))/(n*n) * Math.sqrt(fact(n - l - 1) / fact(n+l)) * Math.pow(2*z/(n*a_0), l);
  }
  
  
  private Complex evaluateR(double r) {
    return new Complex(RConstant * Math.pow(r,l) * Lnl.evaluateAt(2*z*r/(n*a_0)) * Math.exp(-z*r/(n * a_0)), 0, 1);
  }
  
  
  // précalcul pour le faire qu'une seul fois
  private void initializeYConstant() {
    YConstant = pow(-1, 1/2 * (m + abs(m))) * Math.sqrt((2*l + 1) * fact(l - abs(m))/(4 * Math.PI * fact(l + abs(m))));
  }
  
  // Calcule la partie Y de la fonction d'onde
  private Complex evaluateY(double th, double ph) {
    double module = YConstant * Math.pow(Math.sin(th),abs(m)) * Pml.evaluateAt(Math.cos(th));
    return new Complex(module, m * ph, 1);
  }
  


  // renvoie le polynome de Legendre de degré n, pas mettre de nombre négatif
  private Polynom getLegendre(int n) {
    if (n < 0) println("Legendre, n non négatif");
    if (n == 0) return p0;
    if (n == 1) return p1;
    Polynom P_n_1 = p0;
    Polynom P_n = p1;
  
    for (int i = 1; i < n; i++) {
      Polynom old = P_n;
      P_n = getNextLegendre(P_n, P_n_1, i);
      P_n_1 = old;
    }
    return P_n;
  }


  // étape récursive pour obtenir le polynome
  private Polynom getNextLegendre(Polynom poln, Polynom poln_1, float n) {
    // P_[n+1] = ( (2n + 1)*x*P_[n] - n * P_[n-1] )/(n+1)
    Polynom res = p1.getScalarMult(2*n + 1);
    res = poln.getMultiplication(res);
    res = res.getAddition(poln_1.getScalarMult(-n));
    res.scalarMult(1/(n + 1));
    return res;
  }
  
  
  // renvoie le polynome de Laguerre de degré n
  public Polynom getGeneralisedLaguerre(int n, int alpha) {
    //génère le x^{n + alpha}
    double[] startPoly = new double[n + alpha + 1];
    for (int i = 0; i < n + alpha; i++) startPoly[i] = 0;
    startPoly[alpha + n] = 1;
    Polynom res = new Polynom(startPoly);
    res = res.getNMExpDerivative(n);
    res = res.getReduced(alpha);
    return res.getScalarMult(1/fact(n));
  }
  
  
  
  // renvoie la factoriel de x
  public double fact(int x) {
    return (x == 0) ? 1 : fact(x - 1) * x;
  }
  
}
